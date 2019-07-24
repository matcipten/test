trigger OnContentDocumentLinkTrigger on ContentDocumentLink (after insert,after delete) {
	system.debug('start trigger');


	List<Trigger_Setting__mdt> triggerSettings =
	[
		SELECT Active__c,Trigger_Name__c,Event__c,sObject__c,isMassive__c
		FROM Trigger_Setting__mdt
		where sObject__c = 'ContentDocumentLink'
		                                   and Trigger_Name__c = 'OnContentDocumentLinkTrigger'
	];
		                   //and Active__c = false

	Map<String,Boolean> isTriggerActive = new Map<String,Boolean>();
	Map<String,Boolean> isTriggerMassive = new Map<String,Boolean>();

	if(triggerSettings != null && triggerSettings.size() > 0) {
		for(Trigger_Setting__mdt sett : triggerSettings) {
			isTriggerActive.put(sett.Event__c,sett.Active__c);
		}
	}
	if(triggerSettings != null && triggerSettings.size() > 0) {
		for(Trigger_Setting__mdt sett : triggerSettings) {
			isTriggerMassive.put(sett.Event__c,sett.isMassive__c);
		}
	}

	Map<String,String> cdlLinkedToProductMap = new Map<String,String>();
	if(Trigger.isAfter) {
		if(Trigger.isInsert) {

			if(isTriggerActive.get('After Insert') != null && isTriggerActive.get('After Insert') == false) {
				System.debug(isTriggerActive.get('After Insert'));
				return;
			}

			for(ContentDocumentLink cdl : Trigger.newMap.values()) {
				system.debug(cdl);
				//a04 are products
				if(String.valueOf(cdl.LinkedEntityId).startsWith('a04')) {
					cdlLinkedToProductMap.put((String)cdl.LinkedEntityId,cdl.Id);
				}
			}

		}
		else if(Trigger.isDelete) {

			if(isTriggerActive.get('After Delete') != null && isTriggerActive.get('After Delete') == false) {
				System.debug(isTriggerActive.get('After Delete'));
				return;
			}

			for(ContentDocumentLink cdl : Trigger.oldMap.values()) {
				system.debug(cdl);
				//a04 are products
				if(String.valueOf(cdl.LinkedEntityId).startsWith('a04')) {
					cdlLinkedToProductMap.put((String)cdl.LinkedEntityId,cdl.Id);
				}

			}
		}
		if(cdlLinkedToProductMap != null && cdlLinkedToProductMap.size() > 0) {
			System.debug(JSON.serializePretty(cdlLinkedToProductMap));
			if(Trigger.isInsert) {
				system.debug('call handler');
				OnContentDocumentLinkTriggerHandler.updateImagesOnGiftsAndTransactionDetails(Trigger.newMap,cdlLinkedToProductMap,'Insert');
				// OnContentDocumentLinkTriggerHandler.updateGiftImage(Trigger.newMap,cdlLinkedToProductMap,'Insert');
			}
			else if(Trigger.isDelete) {
				system.debug('call handler');
				OnContentDocumentLinkTriggerHandler.updateImagesOnGiftsAndTransactionDetails(Trigger.oldMap,cdlLinkedToProductMap,'Delete');
				// OnContentDocumentLinkTriggerHandler.updateGiftImage(Trigger.oldMap,cdlLinkedToProductMap,'Delete');
			}
		}
	}


}