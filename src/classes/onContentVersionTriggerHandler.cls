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
}