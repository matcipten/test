trigger OnOrdineSartoriaSolomeoTrigger on Ordine_Sartoria_Solomeo__c (before insert, before update, after update) {
    
    if(trigger.isInsert){
        if(trigger.isBefore){
            OnOrdineSartoriaSolomeoTriggerHandler.executeOrdineSartoriaSolomeo(OnOrdineSartoriaSolomeoTriggerHandler.processOnlyStatusNotEditing(trigger.New), trigger.isBefore, trigger.isInsert, trigger.isUpdate);
        }
        if(trigger.isAfter){}
    }
    
    if(trigger.isUpdate){
        SYSTEM.debug('TRIGGER UPDATE');
        if(trigger.isBefore){
            OnOrdineSartoriaSolomeoTriggerHandler.executeOrdineSartoriaSolomeo(OnOrdineSartoriaSolomeoTriggerHandler.processOnlyStatusNotEditing(trigger.New), trigger.isBefore, trigger.isInsert, trigger.isUpdate);
        }
        /* if(trigger.isAfter){
            SYSTEM.debug('TRIGGER isAfter');
            if(Rest_MTM_CalloutHandler.isFirstTimeForAfter){
                // EXECUTE TRIGGER ONLY ONCE 
                Rest_MTM_CalloutHandler.isFirstTimeForAfter = false;
                
                OnOrdineSartoriaSolomeoTriggerHandler.sendAllertOrdineSartoriaSolomeo(trigger.New, trigger.old);
                
                
            }
        } */
    }

}