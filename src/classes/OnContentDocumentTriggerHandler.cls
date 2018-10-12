public class OnContentDocumentTriggerHandler {
    
    public static void SetAllegatiInAccount(list<ContentDocument> listContentDocument){
        System.debug('listContentDocument: ' + listContentDocument);
        
        set<Id> cDocListId = new set<Id>();
        for(ContentDocument cDoc : listContentDocument){
            cDocListId.add(cDoc.Id);
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
        List<Attachment> attList = new List<Attachment>([SELECT Id, ParentId FROM Attachment WHERE ParentId IN : accountId]);
        List<ContentDocumentLink> conList = new List<ContentDocumentLink>([SELECT ContentDocumentId, LinkedEntityId  FROM ContentDocumentLink where LinkedEntityId IN : accountId]);
        
        for(Account a : accountList){
            Integer count = 0;
            for(Attachment attach : attList){
                if(attach.ParentId == a.Id){
                    count ++;
                }
            }
            
            for(ContentDocumentLink contDoc : conList){
                if(contDoc.LinkedEntityId == a.Id){
                    count ++;
                }
            }
            
            if(count - 1 == 0){
                a.Allegati__c = false;  
                update a;
            } 
        }
    }
}