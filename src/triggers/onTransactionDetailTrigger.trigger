trigger onTransactionDetailTrigger on Transaction_Detail__c (after insert, before insert, after update, before update, after delete) {

	if(trigger.isInsert){
        
        if(trigger.isBefore){
            onTransactionDetailTriggerHandler.setScontoInTransactionDetailsInsert(trigger.new);
		}
		
		if(trigger.isAfter){
			onTransactionDetailTriggerHandler.CreateGiftActivity(trigger.new);
            onTransactionDetailTriggerHandler.setCurrencyInTransaction(trigger.new);
		}
	}
    
    if(trigger.isUpdate){
       
        if(trigger.isBefore){
            onTransactionDetailTriggerHandler.setScontoInTransactionDetailsUpdate(trigger.newMap, trigger.OldMap);
		}
		
		if(trigger.isAfter){
			onTransactionDetailTriggerHandler.setCurrencyInTransaction(trigger.new);
		}
	}
    
    if(trigger.isDelete){
        if(trigger.isAfter){
            onTransactionDetailTriggerHandler.setCurrencyInTransaction(trigger.old);
        }
    }
    
}