trigger onAccountTrigger on Account (after insert, after delete, after update, before update) {

    Funzionalita__c f = Funzionalita__c.getInstance();
    if (f.Disable_Trigger__c){
      System.debug('SV FUNZIONALITA DISATTIVA TRGGER ON PER UTENTE O PROFILO');
      return;
    }


    if(system.isFuture()) {
        system.debug('future');
        return;
    }else{
        system.debug('no future');
    }
    Profile__c mhc = Profile__c.getInstance(system.UserInfo.getProfileId());
    Set<Id> Prevent_Profile_callout = new Set<Id>();



    Prevent_Profile_callout.add(mhc.Id_Admin_Apex__c);
    Prevent_Profile_callout.add(mhc.Id_Xstore_Apex__c);
    Prevent_Profile_callout.add(mhc.Id_Demandware_Apex__c);
    if(trigger.isInsert){
        if(trigger.isAfter){
            System.debug('VS insert after');
            Id profile_id = UserInfo.getProfileId();
            OnAccountTriggerHandler.CreateSlaveMap(trigger.new);
            if(!Test.isRunningTest()){
                for(Account acc : trigger.new){
                    if(acc.Id_Cliente_MDM__c== null || acc.Id_Cliente_MDM__c==''){
                        String body= REST_Salesforce_to_Mulesoft.buildPayload(acc.Id);
                        REST_Salesforce_to_Mulesoft.doPost(body);
                    }
                    
                }
            }
            
            system.debug('TRIGGER Update profile Id: ' + profile_id);
            system.debug('TRIGGER Prevent profile Id: ' + Prevent_Profile_callout);
            
            Set<Id> accountId = new Set<Id>();
            for(Account acc : trigger.new){
                if(Prevent_Profile_callout.contains(profile_id)){
                    if(UserInfo.getProfileId() == mhc.Id_Demandware_Apex__c && acc.Registrazione_Al_Sito__c){
                        if(acc.Id_Cliente_MDM__c == null){
                            accountId.add(acc.Id);
                        } 
                    }
                } else {
                    if(acc.Id_Cliente_MDM__c == null){
                        accountId.add(acc.Id);
                    } 
                }
                // String body= REST_Salesforce_to_Mulesoft.buildPayload(acc.Id);
                // REST_Salesforce_to_Mulesoft.doPost(body);
                
            }

            if(accountId.size() > 0){
                System.debug('VS insert after dentro relate');
                system.debug('SEND TO RELATE PROFILE ID: ' + profile_id + ' ACCOUNT ID LIST: ' + accountId);
                String jsonOldMap = null;
                OnAccountTriggerHandler.sendRequestToRelate(accountId, 'I', jsonOldMap);

            } else {
                system.debug('insert NOT SEND TO RELATE PROFILE ID: ' + profile_id);
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
            
            
            System.debug('VS update after');
            Id profile_id = UserInfo.getProfileId();
            system.debug('TRIGGER Update profile Id: ' + profile_id);
            system.debug('TRIGGER Prevent profile Id: ' + Prevent_Profile_callout);

            Set<Id> accountId = new Set<Id>();
            Datetime dt= Datetime.now();
            for(Account acc : trigger.new){
                Datetime accdt  =acc.LastModifiedDate.addMinutes(1);
                if(Prevent_Profile_callout.contains(profile_id)){
                    if(UserInfo.getProfileId() == mhc.Id_Demandware_Apex__c && acc.Registrazione_Al_Sito__c){
                        if(accdt < dt ){
                            accountId.add(acc.Id);
                        }
                    }
                } else {
                    if(accdt < dt ){
                            accountId.add(acc.Id);
                        }
                }
                
                // String body= REST_Salesforce_to_Mulesoft.buildPayload(acc.Id);
                // REST_Salesforce_to_Mulesoft.doPut(body);
                
            }
            
            if(accountId.size() > 0){
                System.debug('VS update after dentro relate');
                system.debug('SEND TO RELATE PROFILE ID: ' + profile_id + ' ACCOUNT ID LIST: ' + accountId);
                String jsonOldMap = JSON.serialize(Trigger.oldMap);
                OnAccountTriggerHandler.sendRequestToRelate(accountId, 'U', jsonOldMap);  
                      
            } else {
                system.debug('update NOT SEND TO RELATE PROFILE ID: ' + profile_id);
            }

            Profile pf= [SELECT Id, name FROM Profile WHERE Id =:profile_id];
            Map<Id, Slave_Data__c> mappaSlaveAcc = new Map<Id, Slave_Data__c>([SELECT Id, Account__c FROM Slave_Data__c WHERE Account__c IN: Trigger.newMap.keySet() AND Deduplica_Mulesoft__c = true ORDER BY Account__c, LastModifiedDate DESC]);

            Map<Id, Slave_Data__c> accIdXSlave = new Map<Id, Slave_Data__c>();
            for(Slave_Data__c sd : mappaSlaveAcc.values()){
                if(!accIdXSlave.containsKey(sd.Account__c)){
                    accIdXSlave.put(sd.Account__c, sd);
                }
            }

            if(!Test.isRunningTest()){
                for(Account acc : trigger.new){
                    // System.debug('VS set id contains: '+OnAccountTriggerHandler.SetOfIDs.contains(acc.id));
                    // if (!OnAccountTriggerHandler.SetOfIDs.contains(acc.id) && pf.Name=='BC - Mulesoft EE (API only)') {
                    if(accIdXSlave.containsKey(acc.Id) && pf.Name == 'BC - Mulesoft EE (API only)'){
                        continue;
                    }
                    // if (!OnAccountTriggerHandler.SetOfIDs.contains(acc.id) && pf.Name=='System Administrator') {
                    System.debug('prima check runonce');
                    if(OnAccountTriggerHandler.runOnce() && acc.Id_Cliente_MDM__c!= null){
                        System.debug('dentro check runonce');
                        String body= REST_Salesforce_to_Mulesoft.buildPayload(acc.Id);
                        REST_Salesforce_to_Mulesoft.doPut(body);
                    }
                    System.debug('dopo check runonce');
                }
            }

            if(pf.Name == 'BC - Mulesoft EE (API only)'){
                for(Slave_Data__c sd : accIdXSlave.values()){
                    sd.Deduplica_Mulesoft__c = false;
                }

                update accIdXSlave.values();
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