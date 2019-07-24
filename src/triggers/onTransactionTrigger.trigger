trigger onTransactionTrigger on Transaction__c (after insert, before insert, after update, before update, after delete) {

	List<Trigger_Setting__mdt> triggerSettings =
	[
		SELECT Active__c,Trigger_Name__c,Event__c,sObject__c,isMassive__c
		FROM Trigger_Setting__mdt
		WHERE (
			sObject__c = 'Transaction__c'
			                             AND Trigger_Name__c = 'onTransactionTrigger'
			)
	];
			             //AND Active__c = false

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

	if(trigger.isInsert) {

		if(trigger.isBefore) {
			if(isTriggerActive.get('Before Insert') != null && isTriggerActive.get('Before Insert') == false) {
				System.debug(isTriggerActive.get('Before Insert'));
				return;
			}
			onTransactionTriggerHandler.setScontoInTransactionInsert(trigger.new);
		}

		if(trigger.isAfter) {
		}
	}

	if(trigger.isUpdate) {

		if(trigger.isBefore) {
			if(isTriggerActive.get('Before Update') != null && isTriggerActive.get('Before Update') == false) {
				System.debug(isTriggerActive.get('Before Update'));
				return;
			}
			onTransactionTriggerHandler.setScontoInTransactionUpdate(trigger.newMap,trigger.oldMap);
		}

		if(trigger.isAfter) {

			// if(isTriggerActive.get('After Update') != null && isTriggerActive.get('After Update') == false) {
			// 	System.debug(isTriggerActive.get('After Update'));
			// 	return;
			// }

			// Map<String,Transaction__c> transactionWithAccountChangeMap = new Map<String,Transaction__c>();
			// for(Transaction__c newTrans : Trigger.new) {
			// 	Transaction__c oldTrans = Trigger.oldMap.get(newTrans.Id);

			// 	if(oldTrans.Account__c != null && newTrans.Account__c != null && oldTrans.Account__c != newTrans.Account__c) {
			// 		transactionWithAccountChangeMap.put(newTrans.Id,newTrans);
			// 	}
			// }
			// if(transactionWithAccountChangeMap != null && transactionWithAccountChangeMap.size() > 0)
			// 	onTransactionTriggerHandler.updateDetailsAccount(transactionWithAccountChangeMap);
		}
	}


}