public class onContentVersionTriggerHandler {
    
    public static void SetAllegatiInAccount(list<ContentVersion> listContentVersion){
        System.debug('ListContentVersion: ' + listContentVersion);
        
        set<Id> cDocListId = new set<Id>();
        for(ContentVersion cVer : listContentVersion){
            cDocListId.add(cVer.ContentDocumentId);
        }
        system.debug('cDocListId: ' + cDocListId);
        
        List<ContentDocumentLink> listAttach =  [ SELECT Id, ContentDocumentID,LinkedEntityId  
                                                 FROM ContentDocumentLink 
                                                 WHERE ContentDocumentID IN : cDocListId ];
        system.debug('listAttach: ' + listAttach);
        set<Id> accountId = new set<Id>();
        for(ContentDocumentLink cnl : listAttach){
            if(string.valueOf(cnl.LinkedEntityId).startsWith('001')){
                accountId.add(cnl.LinkedEntityId);
            }
        }
        system.debug('accountId: ' + accountId);
        
        List<Account> accountList = new List<Account>([SELECT Id, Allegati__c FROM Account WHERE Id IN : accountId]);
        system.debug('accountList: ' + accountList);
        for(Account a : accountList){
            if(!a.Allegati__c){
                a.Allegati__c = true;
                update a;  
            }	
        }
          
    }

    public static void UpdateImageActivityTracking(list<ContentVersion> listContentVersion){
        System.debug('ListContentVersion: ' + listContentVersion);

        Boolean isImage = false;
        String IdContentVersion;

        for(ContentVersion cVer : listContentVersion){
            if(cVer.FileType == 'PNG' || cVer.FileType == 'JPG'){
                isImage = true;
                IdContentVersion = cVer.Id;
            }
        }

        system.debug('isImage: ' + isImage);

        if(isImage) {
        
            set<Id> cDocListId = new set<Id>();
            for(ContentVersion cVer : listContentVersion){
                cDocListId.add(cVer.ContentDocumentId);
            }
            system.debug('cDocListId: ' + cDocListId);
        
            List<ContentDocumentLink> listAttach =  [ SELECT Id, ContentDocumentID,LinkedEntityId  
                                                 FROM ContentDocumentLink 
                                                 WHERE ContentDocumentID IN : cDocListId ];
            system.debug('listAttach: ' + listAttach);
            set<Id> actId = new set<Id>();
            for(ContentDocumentLink cnl : listAttach){
                if(string.valueOf(cnl.LinkedEntityId).startsWith('a1M')){
                    actId.add(cnl.LinkedEntityId);
                }
            }
            system.debug('ActivityTrackingId: ' + actId);
            List<Activity_tracking__c > activityList = new List<Activity_tracking__c >([SELECT Id,Image_Reference__c FROM Activity_tracking__c WHERE Id IN : actId]);
            system.debug('activityList: ' + activityList);
            for(Activity_tracking__c act : activityList){
                system.debug('IdContentVersion: ' + IdContentVersion);
                act.Image_Reference__c = IdContentVersion;
                update act;
            }

        } else {
                system.debug('Do Nothing');
        }
    } 
  
}