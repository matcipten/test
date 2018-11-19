trigger onTransactionTrigger on Transaction__c (after insert, before insert, after update, before update, after delete) {
    
    if(trigger.isInsert){
        
        if(trigger.isBefore){
            onTransactionTriggerHandler.setScontoInTransactionInsert(trigger.new);
        }
        
        if(trigger.isAfter){
        }
    }
    
    if(trigger.isUpdate){
        
        if(trigger.isBefore){
            onTransactionTriggerHandler.setScontoInTransactionUpdate(trigger.newMap,trigger.oldMap);
        }
        
        if(trigger.isAfter){
        }
    }
    
   
}