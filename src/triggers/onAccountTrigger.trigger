trigger onAccountTrigger on Account (after insert, after delete, after update) {
    if(system.isFuture()) return;
    Profile__c mhc = Profile__c.getInstance(system.UserInfo.getProfileId());
    Set<Id> Prevent_Profile_callout = new Set<Id>();
    
    Prevent_Profile_callout.add(mhc.Id_Admin_Apex__c);
    Prevent_Profile_callout.add(mhc.Id_Xstore_Apex__c);
    Prevent_Profile_callout.add(mhc.Id_Demandware_Apex__c);
    
    if(trigger.isInsert){
        if(trigger.isAfter){
            Id profile_id = UserInfo.getProfileId();
            OnAccountTriggerHandler.CreateSlaveMap(trigger.new);
            
            system.debug('TRIGGER Update profile Id: ' + profile_id);
            system.debug('TRIGGER Prevent profile Id: ' + Prevent_Profile_callout);
            
            Set<Id> accountId = new Set<Id>();
            for(Account acc : trigger.new){
                if(Prevent_Profile_callout.contains(profile_id)){
                    if(UserInfo.getProfileId() == mhc.Id_Demandware_Apex__c && acc.Registrazione_Al_Sito__c){
                        accountId.add(acc.Id);
                    }
                } else {
                    accountId.add(acc.Id);
                }
            }
            
            if(accountId.size() > 0){
                system.debug('SEND TO RELATE PROFILE ID: ' + profile_id + ' ACCOUNT ID LIST: ' + accountId);
                String jsonOldMap = null;
                OnAccountTriggerHandler.sendRequestToRelate(accountId, 'I', jsonOldMap);                
            } else {
                system.debug('NOT SEND TO RELATE PROFILE ID: ' + profile_id);
            }
            
            // CHIAMATA RELATE
            // ONLY FOR TEST USER ID: 0051v000004drnlAAA
            // 
            /*
            system.debug('USER ID: ' + system.UserInfo.getUserId());
            if(system.UserInfo.getUserId() == mhc.Id_Test_Contact_Card__c){
                if(Prevent_Profile_callout.contains(profile_id)){
                    system.debug('NOT SEND TO RELATE PROFILE ID: ' + profile_id);
                } else {
                    system.debug('SEND TO RELATE PROFILE ID: ' + profile_id);
                    OnAccountTriggerHandler.sendRequestToRelate(accountId);
                }
            }   
			*/
        }
    }
   
    if(trigger.isDelete){
        if(trigger.isAfter){
            system.debug('TRIGGER delete');
            OnAccountTriggerHandler.CreateSlaveAssociation(trigger.old);
        }
        
    }

    if(trigger.isUpdate){
        
        
        if(trigger.isAfter){
            Id profile_id = UserInfo.getProfileId();
            system.debug('TRIGGER Update profile Id: ' + profile_id);
            system.debug('TRIGGER Prevent profile Id: ' + Prevent_Profile_callout);

            Set<Id> accountId = new Set<Id>();
            for(Account acc : trigger.new){
                if(Prevent_Profile_callout.contains(profile_id)){
                    if(UserInfo.getProfileId() == mhc.Id_Demandware_Apex__c && acc.Registrazione_Al_Sito__c){
                        accountId.add(acc.Id);
                    }
                } else {
                    accountId.add(acc.Id);
                }
            }
            
            if(accountId.size() > 0){
                system.debug('SEND TO RELATE PROFILE ID: ' + profile_id + ' ACCOUNT ID LIST: ' + accountId);
                String jsonOldMap = JSON.serialize(Trigger.oldMap);
                OnAccountTriggerHandler.sendRequestToRelate(accountId, 'U', jsonOldMap);                
            } else {
                system.debug('NOT SEND TO RELATE PROFILE ID: ' + profile_id);
            }
            
            // CHIAMATA RELATE
            // ONLY FOR TEST USER ID: 0051v000004drnlAAA
            // 
            /*
            system.debug('USER ID: ' + UserInfo.getUserId());
            if(UserInfo.getUserId() == mhc.Id_Test_Contact_Card__c){
                OnAccountTriggerHandler.sendRequestToRelate(accountId);
            } else {
                if(Prevent_Profile_callout.contains(profile_id)){
                    system.debug('NOT SEND TO RELATE PROFILE ID: ' + profile_id);
                } else {
                    system.debug('SEND TO RELATE PROFILE ID: ' + profile_id);
                    OnAccountTriggerHandler.sendRequestToRelate(accountId);
                }                
            }
			*/
            
        }
    }
    
}