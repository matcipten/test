trigger onTransactionDetailTrigger on Transaction_Detail__c (after insert, before insert, after update, before update, after delete) {

	List<Trigger_Setting__mdt> triggerSettings =
	[
		SELECT Active__c,Trigger_Name__c,Event__c,sObject__c,isMassive__c
		FROM Trigger_Setting__mdt
		where sObject__c = 'Transaction_Detail__c'
		                   and Trigger_Name__c = 'onTransactionDetailTrigger'
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

	//PN20190121 ----------- update picture on transactionDetail -----------
	// Map<String,String> relatedProductsMapWithNull = new Map<String,String>();
	Map<String,Product__c> productsMap = new Map<String,Product__c>();
	//PN20190121 ----------- update picture on transactionDetail END -----------


	//PN20190121 accountId on transactionDetail
	List<Transaction_Detail__c> detailsWithDifferentTransactionList = new List<Transaction_Detail__c> ();
	//PN20190121 accountId on transactionDetail END

	//PN20190211 --- update only detail without account__c
	// List<Transaction_Detail__c> detailsWithoutAccountLookup = new List<Transaction_Detail__c>();

	if(trigger.isInsert) {

		if(trigger.isBefore) {

			if(isTriggerActive.get('Before Insert') != null && isTriggerActive.get('Before Insert') == false) {
				System.debug(isTriggerActive.get('Before Insert'));
				return;
			}

			onTransactionDetailTriggerHandler.setScontoInTransactionDetailsInsert(trigger.new);

			//PN20190121 accountId on transactionDetail
			//PN20190211 --- update only detail without account__c - replaced Trigger.new with detailsWithoutAccountLookup
			// onTransactionDetailTriggerHandler.updateAccountId(trigger.new);
			//PN20190121 accountId on transactionDetail END

			for(Transaction_Detail__c newDetail : Trigger.new) {

				//PN20190121 ----------- update picture on transactionDetail -----------

				//PN20190211 --- added Reference is Empty
				// if(newDetail.Product__c != null) {
				if(newDetail.Product__c != null && (newDetail.Product_Image_Reference__c == null || newDetail.Product_Image_Reference__c == '')) {
					system.debug('newDetail.Product__c != null');
					system.debug(newDetail.Product__c);
					system.debug('newDetail.Id,newDetail.Product__c');
					system.debug(newDetail.Id+' '+newDetail.Product__c);
					// relatedProductsMapWithNull.put(newDetail.Id,newDetail.Product__c);
					productsMap.put(newDetail.Product__c,null);
				}
				//PN20190121 ----------- update picture on transactionDetail END -----------


				//PN20190211 --- update only detail without account__c

				// if(newDetail.Account__c == null) {
				// 	detailsWithoutAccountLookup.add(newDetail);
				// }

				//PN20190211 --- update only detail without account__c END


			}
			//PN20190121 ----------- update picture on transactionDetail -----------
			if(productsMap != null && productsMap.size() > 0) {
				OnTransactionDetailTriggerHandler.updateDetailImage(productsMap,Trigger.new);
			}
			//PN20190121 ----------- update picture on transactionDetail END -----------

			// if(detailsWithoutAccountLookup != null && detailsWithoutAccountLookup.size() > 0) {
			// 	//PN20190211 --- update only detail without account__c - replaced Trigger.new with detailsWithoutAccountLookup
			// 	OnTransactionDetailTriggerHandler.updateAccountId(detailsWithoutAccountLookup);
			// 	//PN20190211 --- update only detail without account__c - replaced Trigger.new with detailsWithoutAccountLookup END
			// }

		}

		if(trigger.isAfter) {

			if(isTriggerActive.get('After Insert') != null && isTriggerActive.get('After Insert') == false) {
				System.debug(isTriggerActive.get('After Insert'));
				return;
			}

			onTransactionDetailTriggerHandler.CreateGiftActivity(null,trigger.new);
			onTransactionDetailTriggerHandler.setCurrencyInTransaction(trigger.new);
		}
	}

	if(trigger.isUpdate) {

		if(trigger.isBefore) {

			if(isTriggerActive.get('Before Update') != null && isTriggerActive.get('Before Update') == false) {
				System.debug(isTriggerActive.get('Before Update'));
				return;
			}
			onTransactionDetailTriggerHandler.setScontoInTransactionDetailsUpdate(trigger.newMap, trigger.OldMap);

			//PN20190121 ----------- update picture on transactionDetail -----------
			System.debug('Is Massive Update: ' + OnTransactionDetailTriggerHandler.isMassiveUpdate);
			Boolean isMassiveMetadata = false;
			if(isTriggerMassive.get('Before Update') != null && isTriggerMassive.get('Before Update') == true) {
				System.debug(isTriggerMassive.get('Before Update'));
				isMassiveMetadata = true;
			}
			System.debug('Is Massive Update Metadata: ' + OnAttivitaMarketingTriggerHandler.isMassiveUpdate);

			for(Transaction_Detail__c newDetail : Trigger.new) {

				Transaction_Detail__c oldDetail = Trigger.oldMap.get(newDetail.Id);

				//PN20190121 ----------- update picture on transactionDetail -----------
				if(oldDetail.Product__c != newDetail.Product__c || OnTransactionDetailTriggerHandler.isMassiveUpdate == true || isMassiveMetadata == true) {
					system.debug('oldDetail.Product__c != newDetail.Product__c');
					system.debug(newDetail.Id+' '+newDetail.Product__c);
					// relatedProductsMapWithNull.put(newDetail.Id,newDetail.Product__c);
					if(newDetail.Product__c != null) {
						system.debug('newDetail.Product__c != null');
						system.debug(newDetail.Product__c);
						productsMap.put(newDetail.Product__c,null);
					}
				}
				//PN20190121 ----------- update picture on transactionDetail END -----------

				//PN20190121 accountId on transactionDetail
				if((oldDetail.Transaction__c != newDetail.Transaction__c) || OnTransactionDetailTriggerHandler.isMassiveUpdate == true || isMassiveMetadata == true)
					detailsWithDifferentTransactionList.add(newDetail);
				//PN20190121 accountId on transactionDetail END
			}


			//PN20190121 accountId on transactionDetail
			// if(detailsWithDifferentTransactionList != null && detailsWithDifferentTransactionList.size() > 0)
			// 	onTransactionDetailTriggerHandler.updateAccountId(detailsWithDifferentTransactionList);
			//PN20190121 accountId on transactionDetail END

			//PN20190121 ----------- update picture on transactionDetail -----------
			if(productsMap != null && productsMap.size() > 0) {
				OnTransactionDetailTriggerHandler.updateDetailImage(productsMap,Trigger.new);
			}
			//PN20190121 ----------- update picture on transactionDetail END -----------
		}

		if(trigger.isAfter) {

			if(isTriggerActive.get('After Update') != null && isTriggerActive.get('After Update') == false) {
				System.debug(isTriggerActive.get('After Update'));
				return;
			}
			onTransactionDetailTriggerHandler.CreateGiftActivity(Trigger.oldMap,trigger.new);
			onTransactionDetailTriggerHandler.setCurrencyInTransaction(trigger.new);
		}
	}

	if(trigger.isDelete) {

		if(trigger.isAfter) {
			if(isTriggerActive.get('After Delete') != null && isTriggerActive.get('After Delete') == false) {
				System.debug(isTriggerActive.get('After Delete'));
				return;
			}

			onTransactionDetailTriggerHandler.setCurrencyInTransaction(trigger.old);
		}
	}

}