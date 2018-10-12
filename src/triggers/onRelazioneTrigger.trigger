trigger onRelazioneTrigger on Relazioni__c (after delete) {

    if(trigger.isdelete){
        if(trigger.isAfter){
            OnRelazioneTriggerHandler.DeleteRelazioni(trigger.old);
        }
    }

}