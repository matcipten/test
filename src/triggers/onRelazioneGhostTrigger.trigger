trigger onRelazioneGhostTrigger on Relazione_Ghost__c(after insert) {

    if(trigger.isInsert){
        if(trigger.isAfter){
            OnRelazioneGhostTriggerHandler.CreateRelazioni(trigger.new);
        }
    }

}