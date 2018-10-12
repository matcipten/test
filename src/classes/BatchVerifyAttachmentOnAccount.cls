global with sharing  class BatchVerifyAttachmentOnAccount Implements Database.Batchable<SObject>, Database.Stateful{

    global final String Query;
    Set<Id> accountids = new Set<Id>();
    
    global BatchVerifyAttachmentOnAccount(){
        Query = 'SELECT Id, Allegati__c FROM Account';
        System.debug('Query: ' + Query);
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC,List<Account> listAccount){
        System.debug('listAccount: ' + listAccount);
        list<Account> accountList = new list<Account>();
        Set<Id> accountSet = new Set<Id>();
        Map<Id, Account> mapAccount = new Map<Id, Account>();
        for(Account acc : listAccount){
            mapAccount.put(acc.Id, acc);
        }
        
		accountSet = mapAccount.keySet();
        System.debug('accountSet: ' + accountSet);
        
        List<Attachment> attList = [SELECT Id, ParentId FROM Attachment WHERE ParentId IN : accountSet];
        List<ContentDocumentLink> cDocList = [SELECT Id, LinkedEntityId FROM ContentDocumentLink WHERE LinkedEntityId IN : accountSet];
        
        for(Attachment att : attList){
            if(!accountids.contains(att.ParentId)){
                Account acc = mapAccount.get(att.ParentId);
                if(!acc.Allegati__c){
                    acc.Allegati__c = true;
                    accountList.add(acc);
                    accountids.add(acc.Id);
                }
                System.debug('Attachment: ' + att);
            }
        }
        
        for(ContentDocumentLink cDoc : cDocList){
            if(!accountids.contains(cDoc.LinkedEntityId)){
                Account acc = mapAccount.get(cDoc.LinkedEntityId);
                if(!acc.Allegati__c){
                    acc.Allegati__c = true;
                    accountList.add(acc);
                    accountids.add(acc.Id);
                }
                System.debug('ContentDocument: ' + cDoc);
            }
        }
        
        if(accountList.size() > 0){
            System.debug('accountList size: ' + accountList.size());
            update(accountList);
        }
          
    }
    
    global void finish(Database.BatchableContext BC){
        System.debug('BATCH: finish');
        System.debug('Update ' + accountids.size() + ' Accounts');
    }
    
}