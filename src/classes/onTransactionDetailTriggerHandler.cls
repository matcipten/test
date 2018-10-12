public with sharing class onTransactionDetailTriggerHandler {

    public static void CreateGiftActivity(list<Transaction_Detail__c> TransactionDetail){

        list<Attivita_Marketing__c> ListNewActivity = new list<Attivita_Marketing__c>();

        set<string> SetTransactionIds               = new set<string>();
        list<Transaction__c> ListTransaction        = new list<Transaction__c>();
        map<string, string> MapTransactions         = new map<string, string>();
        
        string GiftRecTypeId = [Select id 
                                From Recordtype 
                                Where SobjectType = 'Attivita_Marketing__c' and
                                DeveloperName = 'Gift_Collection'].Id;

        for(Transaction_Detail__c t:TransactionDetail){
        
            if(t.Gift__c){
                
                SetTransactionIds.add(t.Transaction__c);
                
            }
            
        }
            
        ListTransaction = [ Select id, Account__c
                            From Transaction__c
                            Where id IN:SetTransactionIds];
                            
        for(Transaction__c t:ListTransaction){
            MapTransactions.put(t.Id, t.Account__c);
        }

        for(Transaction_Detail__c td:TransactionDetail){
        
            if(td.Gift__c && MapTransactions.containsKey(td.Transaction__c)){
        
                Attivita_Marketing__c am    = new Attivita_Marketing__c();
                am.RecordTypeId             = GiftRecTypeId;
                am.Cliente__c               = MapTransactions.get(td.Transaction__c);
                am.Product__c               = td.Product__c;
                am.Dettaglio_Transazione__c = td.Id;
                am.Data__c                  = system.today();
                am.Gift__c                  = true;
                ListNewActivity.add(am);
        
            }
        
        }

        if(ListNewActivity.size()>0){
            insert ListNewActivity;
        }


    }

}