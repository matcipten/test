public with sharing class CaseOmniChannelHandler {
    
    public static void setBusinessHours(List<Case> cases){        
        List<Case> cas = setClientAssistant(cases,true);
        handleBusinessHours(cas);
    }

    public static void setBusinessHoursUpdate(Map<Id, Case> oldMap, List<Case> cases){        
        List<Case> caseToWork = new List<Case>();
        List<Case> caseToHandleClientAssistant = new List<Case>();
        for (Case c : cases){
            System.debug('OLD VALUE OMNICHANNEL: '+oldMap.get(c.Id).Assegnato_Da_OmniChannel__c);
            System.debug('New VALUE OMNICHANNEL: '+c.Assegnato_Da_OmniChannel__c);
            System.debug('OLD VALUE OWNER ID: '+oldMap.get(c.Id).OwnerId);
            System.debug('New VALUE OWNER ID: '+c.OwnerId);
            if (oldMap.get(c.Id).Assegnato_Da_OmniChannel__c != c.Assegnato_Da_OmniChannel__c || oldMap.get(c.Id).OwnerId != c.OwnerId){    
                caseToWork.add(c);
            }

            if (oldMap.get(c.Id).AccountId != c.AccountId){
                caseToHandleClientAssistant.add(c);
            }
        }

        System.debug('Case to work: '+caseToWork);
        if (!caseToWork.isEmpty()){
            handleBusinessHours(caseToWork);
        }

        if (!caseToHandleClientAssistant.isEmpty()){
            List<Case> cas = setClientAssistant(caseToHandleClientAssistant,true);           
            handleBusinessHours(cas);
        }        
    }

    private static void handleBusinessHours(List<Case> cases){
        Set<Id> users = new Set<Id>();
        Set<Id> queues = new Set<Id>();
        
        for (Case c : cases){
            if (c.OwnerId!=null){
                if(String.valueOf(c.OwnerId).startsWith('005')){
                    users.add(c.OwnerId);
                }else if(String.valueOf(c.OwnerId).startsWith('00G')){
                    queues.add(c.OwnerId);
                }
            }            
        }

        Id businessHourQueueDefault = getDefaultBusinessHour();
        Map<Id,Id> userBusinessHour = new Map<Id,Id>();
        List<User> usersList = [SELECT Id, Business_Hour_lun_ven__c,Manager.Email FROM User WHERE Id IN:users];
        Map<Id, User> userMap = new Map<Id, User>(usersList);
        List<BusinessHours> businessHours = [SELECT Id,Name FROM BusinessHours];
        Map<String,Id> mapIdBusinessHours = new Map<String,Id>();

        for (BusinessHours bh : businessHours){
            mapIdBusinessHours.put(bh.Name,bh.Id);
        }
        
        for (User u : usersList){
            if (u.Business_Hour_lun_ven__c !=null){
                userBusinessHour.put(u.Id,mapIdBusinessHours.get(u.Business_Hour_lun_ven__c));
            }else {
                userBusinessHour.put(u.Id,businessHourQueueDefault);
            }            
        }
        
        for (Id i : queues){
            userBusinessHour.put(i,businessHourQueueDefault);
        }

        System.debug(userBusinessHour);
        Id_Automatismi_Milestone__c mail = Id_Automatismi_Milestone__c.getOrgDefaults();
        for (Case c : cases){
            System.debug(c.OwnerId);
            if (userBusinessHour.containsKey(c.OwnerId)){
                System.debug('Modifico business hour');
                c.BusinessHoursId = userBusinessHour.get(c.OwnerId);
            }  
            System.debug('VS owner id: '+c.OwnerId);
            System.debug('VS owner Name: '+c.Owner.Name);
            System.debug('VS owner Email: '+c.Owner.Email);
        
            
            if(String.valueOf(c.OwnerId).startsWith('005') && userMap.containsKey(c.OwnerId)){
                System.debug('VS utente');
                if(userMap.get(c.OwnerId).Manager.Email!=null){
                    System.debug('VS con mail: '+userMap.get(c.OwnerId).Manager.Email);
                    c.Mail_Owner_s_Manager__c= userMap.get(c.OwnerId).Manager.Email;
                }
                else{
                    System.debug('VS senza mail');
                    c.Mail_Owner_s_Manager__c= mail.Manager_Default_Mail__c;
                }
            }
            else{
                System.debug('VS coda');
                c.Mail_Owner_s_Manager__c= mail.Manager_Default_Mail__c;
            }
        }
    }

    private static Id getDefaultBusinessHour(){
        List<BusinessHours> businessHours = [SELECT Id FROM BusinessHours WHERE Name = 'Roma 8-22' LIMIT 1];
        if (!businessHours.isEmpty()){
            return businessHours.get(0).Id;
        }

        return null;
    }

    private static List<Case> setClientAssistant(List<Case> cases, Boolean isUpdate){
        Map<Id,Id> caseContactIds = new Map<Id,Id>();
        Id recordType = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Ticket_E_commerce_Notify_Me').getRecordTypeId();
        for (Case c : cases){
            if (c.AccountId!=null && c.RecordTypeId != recordType){
                caseContactIds.put(c.AccountId,c.Id);
            }
        }

        Map<Id,Id> contactClientIds = new Map<Id,Id>();
        List<Account> accounts = [SELECT Id, Personal_Client_Assistant__c FROM  Account WHERE Id IN:  caseContactIds.keySet()];
        for (Account con : accounts){
            if (con.Personal_Client_Assistant__c!=null){
                contactClientIds.put(con.Id,con.Personal_Client_Assistant__c);
            }
        }

        System.debug('contactClientIds: '+contactClientIds);
        Map<Id,Boolean> onlineUser = getOnlineUser();
        System.debug('onlineUser: '+onlineUser);
        for (Case c : cases){
            if (c.AccountId!=null && c.RecordTypeId != recordType){                
                if (contactClientIds.containsKey(c.AccountId)){  
                    String message = '';
                    Id oldOwner = c.OwnerId;
                    System.debug('oldOwner: '+oldOwner);
                    if (onlineUser.containsKey(contactClientIds.get(c.AccountId))){
                        c.OwnerId = contactClientIds.get(c.AccountId);
                        c.Assigned_to_Personal_Client_Assistant__c = true;  
                        message = System.Label.Reassign_Case_Success;
                        System.debug('VS IF: '+message);
                    }else {
                        c.OwnerId = oldOwner;
                        message = System.Label.Reassign_Case_Error;
                        System.debug('VS ELSE: '+message);
                    }
                    
                    if (isUpdate){
                        CaseClientAssistant__e event = new CaseClientAssistant__e (UserId__c = UserInfo.getUserId(), Message__c = message);
                        System.debug('@@@@@publish event');
                        EventBus.publish(event);
                    }                    
                }                          
            }
        }

        return cases;
    }

    private static Map<Id,Boolean> getOnlineUser(){
        Map<Id,Boolean> onlineUser = new Map<Id,Boolean>();
        List<UserServicePresence> servicePresences = [SELECT UserId, User.Name 
                                                      FROM UserServicePresence 
                                                      WHERE IsCurrentState = true 
                                                      AND (ServicePresenceStatus.MasterLabel ='Disponibile' OR ServicePresenceStatus.MasterLabel LIKE 'Available%')];
        for (UserServicePresence usp : servicePresences){
            onlineUser.put(usp.UserId,true);
        }

        return onlineUser;
    }
}