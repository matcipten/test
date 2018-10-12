public class OnAttachmentTriggerHandler {

    public static void SetAllegatiInAccount(list<Attachment> listAttachment, String action){
        System.debug('ListAttachment: ' + listAttachment);
        
        set<Id> accountId = new set<Id>();
        for(Attachment att : listAttachment){
            accountId.add(att.ParentId);
        }
        system.debug('accountId: ' + accountId);
        
        if(action == 'I'){
            List<Account> accountList = new List<Account>([SELECT Id, Allegati__c FROM Account WHERE Id IN : accountId]);
            for(Account a : accountList){
                if(!a.Allegati__c){
                    a.Allegati__c = true;
                    update a;  
                }	
            }
        } else if(action == 'D'){
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
                
                if(count - 1 > 0){
                    system.debug('count: ' + count);
                    a.Allegati__c = true;  
                } else {
                    a.Allegati__c = false;   
                }
                update a;
            }  
        }
    }
}