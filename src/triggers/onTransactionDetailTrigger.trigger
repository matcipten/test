trigger onTransactionDetailTrigger on Transaction_Detail__c (after insert) {

	if(trigger.isInsert){
		if(trigger.isAfter){
			onTransactionDetailTriggerHandler.CreateGiftActivity(trigger.new);
		}
	}
    
}