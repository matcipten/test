trigger OnAttivitaMarketingTrigger on Attivita_Marketing__c (before insert,before update) {

	List<Trigger_Setting__mdt> triggerSettings =
	[
		SELECT Active__c,Trigger_Name__c,Event__c,sObject__c,isMassive__c
		FROM Trigger_Setting__mdt
		where sObject__c = 'Attivita_Marketing__c'
		                   and Trigger_Name__c = 'OnAttivitaMarketingTrigger'
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


	system.debug('start trigger');
	// Map<String,String> relatedProductsMapWithNull = new Map<String,String>();
	Map<String,Product__c> productsMap = new Map<String,Product__c>();
	//Map<String,Attivita_Marketing__c> changePhotoGiftsMap = new Map<String,Attivita_Marketing__c>();
	for(Attivita_Marketing__c newGift : Trigger.new) {
		if(Trigger.isBefore) {
			if (Trigger.isUpdate) {

				if(isTriggerActive.get('Before Update') != null && isTriggerActive.get('Before Update') == false) {
					System.debug(isTriggerActive.get('Before Update'));
					return;
				}

				Attivita_Marketing__c oldGift = Trigger.oldMap.get(newGift.Id);
				System.debug('Is Massive Update: ' + OnAttivitaMarketingTriggerHandler.isMassiveUpdate);
				Boolean isMassiveMetadata = false;
				if(isTriggerMassive.get('Before Update') != null && isTriggerMassive.get('Before Update') == true) {
					System.debug(isTriggerMassive.get('Before Update'));
					isMassiveMetadata = true;
				}
				System.debug('Is Massive Update Metadata: ' + OnAttivitaMarketingTriggerHandler.isMassiveUpdate);
				if(oldGift.Product__c != newGift.Product__c || OnAttivitaMarketingTriggerHandler.isMassiveUpdate == true || isMassiveMetadata == true) {
					system.debug('oldGift.Product__c != newGift.Product__c');
					system.debug(newGift.Id+' '+newGift.Product__c);
					// relatedProductsMapWithNull.put(newGift.Id,newGift.Product__c);
					//changePhotoGiftsMap.put(newGift.Id,newGift);
					if(newGift.Product__c != null) {
						system.debug('newGift.Product__c != null');
						system.debug(newGift.Product__c);
						productsMap.put(newGift.Product__c,null);
					}
				}
			}
			if (Trigger.isInsert) {

				if(isTriggerActive.get('Before Insert') != null && isTriggerActive.get('Before Insert') == false) {
					System.debug(isTriggerActive.get('Before Insert'));
					return;
				}

				//PN20190211 added check reference is not blank
				// if(newGift.Product__c != null && (newGift.Product_Image_Reference__c == null || newGift.Product_Image_Reference__c == '')) {
				if(newGift.Product__c != null && (newGift.Product_Image_Reference__c == null || newGift.Product_Image_Reference__c == '')) {

					system.debug('newGift.Product__c != null');
					system.debug(newGift.Product__c);
					system.debug('newGift.Id,newGift.Product__c');
					system.debug(newGift.Id+' '+newGift.Product__c);
					// relatedProductsMapWithNull.put(newGift.Id,newGift.Product__c);
					productsMap.put(newGift.Product__c,null);
					//changePhotoGiftsMap.put(newGift.Id,newGift);
				}
			}
		}
	}
	system.debug('call handler');
	if(Trigger.isBefore && (Trigger.isUpdate || Trigger.isInsert)) {
		if(productsMap.size() > 0)
			OnAttivitaMarketingTriggerHandler.updateGiftImage(productsMap,Trigger.new);
	}


}