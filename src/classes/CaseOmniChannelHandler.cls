public with sharing class CaseOmniChannelHandler {
    
    public static void setBusinessHours(List<Case> cases){
        handleBusinessHours(cases);
    }

    public static void setBusinessHoursUpdate(Map<Id, Case> oldMap, List<Case> cases){
        List<Case> caseToWork = new List<Case>();
        for (Case c : cases){
            System.debug('OLD VALUE OMNICHANNEL: '+oldMap.get(c.Id).Assegnato_Da_OmniChannel__c);
            System.debug('New VALUE OMNICHANNEL: '+c.Assegnato_Da_OmniChannel__c);
            System.debug('OLD VALUE OWNER ID: '+oldMap.get(c.Id).OwnerId);
            System.debug('New VALUE OWNER ID: '+c.OwnerId);
            if (oldMap.get(c.Id).Assegnato_Da_OmniChannel__c != c.Assegnato_Da_OmniChannel__c || oldMap.get(c.Id).OwnerId != c.OwnerId){         
                caseToWork.add(c);
            }
        }

        System.debug('Case to work: '+caseToWork);
        handleBusinessHours(caseToWork);
    }

    private static void handleBusinessHours(List<Case> cases){
        Set<Id> users = new Set<Id>();
        Set<Id> queues = new Set<Id>();
        
        for (Case c : cases){
            if(String.valueOf(c.OwnerId).startsWith('005')){
                users.add(c.OwnerId);
            }else if(String.valueOf(c.OwnerId).startsWith('00G')){
                queues.add(c.OwnerId);
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
}