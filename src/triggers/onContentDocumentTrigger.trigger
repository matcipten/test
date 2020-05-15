trigger OnContentDocumentTrigger on ContentDocument (before delete,after delete, after insert) {

	List<Trigger_Setting__mdt> triggerSettings =
	[
		SELECT Active__c,Trigger_Name__c,Event__c,sObject__c,isMassive__c
		FROM Trigger_Setting__mdt
		where sObject__c = 'ContentDocument'
		                                   and Trigger_Name__c = 'OnContentDocumentTrigger'
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

	if(trigger.isDelete) {
		if(trigger.isBefore) {

			if(isTriggerActive.get('Before Delete') != null && isTriggerActive.get('Before Delete') == false) {
				System.debug(isTriggerActive.get('Before Delete'));
				return;
			}

			system.debug('ContentDocument delete');
			OnContentDocumentTriggerHandler.SetAllegatiInAccount(trigger.old);
			system.debug('secondTrigger');
			OnContentDocumentTriggerHandler.getLinkForUpdateGiftImageDelete(Trigger.oldMap);
			OnContentDocumentTriggerHandler.ImageDeleteActTracking(trigger.old);
		}
		//PN20190118
		else if(Trigger.isAfter) {

			if(isTriggerActive.get('After Delete') != null && isTriggerActive.get('After Delete') == false){
				System.debug(isTriggerActive.get('After Delete'));
				return;
			}
			OnContentDocumentTriggerHandler.fireUpdateGiftImage();
			//OnContentDocumentTriggerHandler.ImageDeleteActTracking(trigger.old);
		}
	}
	//PN20190118
	else if(Trigger.isInsert) {
		if(Trigger.isAfter) {

			if(isTriggerActive.get('After Insert') != null && isTriggerActive.get('After Insert') == false){
				System.debug(isTriggerActive.get('After Insert'));
				return;
			}

			OnContentDocumentTriggerHandler.getLinkForUpdateGiftImage(Trigger.newMap);
		}
	}
}