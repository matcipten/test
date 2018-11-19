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
    
    public static void setCurrencyInTransaction(list<Transaction_Detail__c> TransactionDetail){
        System.debug('SET CURRENCY IN TRANSACTION');
        set<Id> transaction_SetId = new set<Id>();
        for (Transaction_Detail__c t : TransactionDetail){
            transaction_SetId.add(t.Transaction__c);
        }
        
        System.debug('SV transaction_SetId: ' + transaction_SetId);
        
        Map<Id, Transaction__c> transectionMap = new Map<Id, Transaction__c>([SELECT Id, Prezzo_di_vendita_DKK__c, Prezzo_netto_IVA_DKK__c, Prezzo_di_listino_DKK__c,
                                                                              Prezzo_di_vendita_RUB__c, Prezzo_netto_IVA_RUB__c, Prezzo_di_listino_RUB__c,
                                                                              Prezzo_di_vendita_AUD__c, Prezzo_netto_IVA_AUD__c, Prezzo_di_listino_AUD__c
                                                                              FROM Transaction__c 
                                                                              WHERE Id IN : transaction_SetId]);
        
        List<Transaction_Detail__c> transectionDetailList = [SELECT Id, Prezzo_di_Listino__c, Prezzo_di_Vendita__c, Transaction__c, CurrencyIsoCode,
                                                             Prezzo_di_vendita_DKK__c, Prezzo_netto_IVA_DKK__c, Prezzo_di_listino_DKK__c,
                                                             Prezzo_di_vendita_RUB__c, Prezzo_netto_IVA_RUB__c, Prezzo_di_listino_RUB__c,
                                                             Prezzo_di_vendita_AUD__c, Prezzo_netto_IVA_AUD__c, Prezzo_di_listino_AUD__c
                                                             FROM Transaction_Detail__c 
                                                             WHERE Transaction__c IN : transaction_SetId];
        
        List<Transaction__c> transectionList = new List<Transaction__c>();
        Decimal Prezzo_vendita_DKK = 0;
        Decimal Prezzo_vendita_RUB = 0;
        Decimal Prezzo_vendita_AUD = 0;
        
        Decimal Prezzo_netto_IVA_DKK = 0;
        Decimal Prezzo_netto_IVA_RUB = 0;
        Decimal Prezzo_netto_IVA_AUD = 0;
        
        Decimal Prezzo_di_listino_DKK = 0;
        Decimal Prezzo_di_listino_RUB = 0;
        Decimal Prezzo_di_listino_AUD = 0;
        
        for(Id Id_transaction : transectionMap.keySet()){
            for (Transaction_Detail__c trsd : transectionDetailList){
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_Vendita_DKK__c != NULL){
                    Prezzo_vendita_DKK = Prezzo_vendita_DKK + trsd.Prezzo_di_Vendita_DKK__c;
                }
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_vendita_RUB__c != NULL){
                    Prezzo_vendita_RUB = Prezzo_vendita_RUB + trsd.Prezzo_di_vendita_RUB__c;
                }
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_vendita_AUD__c != NULL){
                    Prezzo_vendita_AUD = Prezzo_vendita_AUD + trsd.Prezzo_di_vendita_AUD__c;
                }
                
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_DKK__c != NULL){
                    Prezzo_netto_IVA_DKK = Prezzo_netto_IVA_DKK + trsd.Prezzo_netto_IVA_DKK__c;
                }
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_RUB__c != NULL){
                    Prezzo_netto_IVA_RUB = Prezzo_netto_IVA_RUB + trsd.Prezzo_netto_IVA_RUB__c;
                }
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_AUD__c != NULL){
                    Prezzo_netto_IVA_AUD = Prezzo_netto_IVA_AUD + trsd.Prezzo_netto_IVA_AUD__c;
                }
                
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_DKK__c != NULL){
                    Prezzo_di_listino_DKK = Prezzo_di_listino_DKK + trsd.Prezzo_di_listino_DKK__c;
                }
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_RUB__c != NULL){
                    Prezzo_di_listino_RUB = Prezzo_di_listino_RUB + trsd.Prezzo_di_listino_RUB__c;
                }
                if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_AUD__c != NULL){
                    Prezzo_di_listino_AUD = Prezzo_di_listino_AUD + trsd.Prezzo_di_listino_AUD__c;
                }
            }
            
            transectionMap.get(Id_transaction).Prezzo_di_Vendita_DKK__c = Prezzo_vendita_DKK;
            transectionMap.get(Id_transaction).Prezzo_di_Vendita_RUB__c = Prezzo_vendita_RUB;
            transectionMap.get(Id_transaction).Prezzo_di_vendita_AUD__c = Prezzo_vendita_AUD;
            
            transectionMap.get(Id_transaction).Prezzo_netto_IVA_DKK__c = Prezzo_netto_IVA_DKK;
            transectionMap.get(Id_transaction).Prezzo_netto_IVA_RUB__c = Prezzo_netto_IVA_RUB;
            transectionMap.get(Id_transaction).Prezzo_netto_IVA_AUD__c = Prezzo_netto_IVA_AUD;
            
            transectionMap.get(Id_transaction).Prezzo_di_listino_DKK__c = Prezzo_di_listino_DKK;
            transectionMap.get(Id_transaction).Prezzo_di_listino_RUB__c = Prezzo_di_listino_RUB;
            transectionMap.get(Id_transaction).Prezzo_di_listino_AUD__c = Prezzo_di_listino_AUD;
            
            transectionList.add(transectionMap.get(Id_transaction));
        }
        
        update transectionList;
        
    }
    
    public static void setScontoInTransactionDetailsInsert(List<Transaction_Detail__c> TransactionDetailNew){
        System.debug('SET SCONTO IN TRANSACTION DETAIL');
        for(Transaction_Detail__c tDetail : TransactionDetailNew){
            
            tDetail.Sconto_AUD__c  = (tDetail.Prezzo_di_listino_AUD__c != 0 && tDetail.Prezzo_di_vendita_AUD__c <= tDetail.Prezzo_di_listino_AUD__c) ? (tDetail.Prezzo_di_listino_AUD__c - tDetail.Prezzo_di_vendita_AUD__c) : 0; 
            tDetail.PSconto_AUD__c = (tDetail.Prezzo_di_listino_AUD__c > 0 && tDetail.Sconto_AUD__c > 0) ? (tDetail.Sconto_AUD__c / tDetail.Prezzo_di_listino_AUD__c)*100 : 0;
            
            
            tDetail.Sconto_DKK__c  = (tDetail.Prezzo_di_listino_DKK__c != 0 && tDetail.Prezzo_di_Vendita_DKK__c <= tDetail.Prezzo_di_listino_DKK__c) ? (tDetail.Prezzo_di_listino_DKK__c - tDetail.Prezzo_di_Vendita_DKK__c) : 0; 
            tDetail.PSconto_DKK__c = (tDetail.Prezzo_di_listino_DKK__c > 0 && tDetail.Sconto_DKK__c > 0) ? (tDetail.Sconto_DKK__c / tDetail.Prezzo_di_listino_DKK__c)*100 : 0;
            
            tDetail.Sconto_RUB__c  = (tDetail.Prezzo_di_listino_RUB__c != 0 && tDetail.Prezzo_di_vendita_RUB__c <= tDetail.Prezzo_di_listino_RUB__c) ? (tDetail.Prezzo_di_listino_RUB__c - tDetail.Prezzo_di_vendita_RUB__c) : 0; 
            tDetail.PSconto_RUB__c = (tDetail.Prezzo_di_listino_RUB__c > 0 && tDetail.Sconto_RUB__c > 0) ? (tDetail.Sconto_RUB__c / tDetail.Prezzo_di_listino_RUB__c)*100 : 0 ;
            
            tDetail.Sconto_MOP__c  = (tDetail.Prezzo_di_listino_MOP__c != 0 && tDetail.Prezzo_di_vendita_MOP__c <= tDetail.Prezzo_di_listino_MOP__c) ? (tDetail.Prezzo_di_listino_MOP__c - tDetail.Prezzo_di_vendita_MOP__c) : 0; 
            tDetail.PSconto_MOP__c = (tDetail.Prezzo_di_listino_MOP__c > 0 && tDetail.Sconto_MOP__c > 0) ? (tDetail.Sconto_MOP__c / tDetail.Prezzo_di_listino_MOP__c)*100 : 0;
            
        }
    }
    
    public static void setScontoInTransactionDetailsUpdate(Map<Id,Transaction_Detail__c> TransactionDetailNew, Map<Id,Transaction_Detail__c> TransactionDetailOld){
        System.debug('SET SCONTO IN TRANSACTION DETAIL');
        
        for(Transaction_Detail__c tDetail : TransactionDetailNew.values()){
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_Listino_AUD__c!= TransactionDetailOld.get(tDetail.Id).Prezzo_di_Listino_AUD__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_vendita_AUD__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_vendita_AUD__c)){
                tDetail.Sconto_AUD__c  = (tDetail.Prezzo_di_listino_AUD__c != 0 && tDetail.Prezzo_di_vendita_AUD__c <= tDetail.Prezzo_di_listino_AUD__c) ? (tDetail.Prezzo_di_listino_AUD__c - tDetail.Prezzo_di_vendita_AUD__c) : 0; 
                tDetail.PSconto_AUD__c = (tDetail.Prezzo_di_listino_AUD__c > 0 && tDetail.Sconto_AUD__c > 0) ? (tDetail.Sconto_AUD__c / tDetail.Prezzo_di_listino_AUD__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_DKK__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_DKK__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_Vendita_DKK__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_Vendita_DKK__c)){
                tDetail.Sconto_DKK__c  = (tDetail.Prezzo_di_listino_DKK__c != 0 && tDetail.Prezzo_di_Vendita_DKK__c <= tDetail.Prezzo_di_listino_DKK__c) ? (tDetail.Prezzo_di_listino_DKK__c - tDetail.Prezzo_di_Vendita_DKK__c) : 0; 
                tDetail.PSconto_DKK__c = (tDetail.Prezzo_di_listino_DKK__c > 0 && tDetail.Sconto_DKK__c > 0) ? (tDetail.Sconto_DKK__c / tDetail.Prezzo_di_listino_DKK__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_RUB__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_RUB__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_vendita_RUB__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_vendita_RUB__c)){
                tDetail.Sconto_RUB__c  = (tDetail.Prezzo_di_listino_RUB__c != 0 && tDetail.Prezzo_di_vendita_RUB__c <= tDetail.Prezzo_di_listino_RUB__c) ? (tDetail.Prezzo_di_listino_RUB__c - tDetail.Prezzo_di_vendita_RUB__c) : 0; 
                tDetail.PSconto_RUB__c = (tDetail.Prezzo_di_listino_RUB__c > 0 && tDetail.Sconto_RUB__c > 0) ? (tDetail.Sconto_RUB__c / tDetail.Prezzo_di_listino_RUB__c)*100 : 0 ;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_MOP__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_MOP__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_vendita_MOP__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_vendita_MOP__c)){
                tDetail.Sconto_MOP__c  = (tDetail.Prezzo_di_listino_MOP__c != 0 && tDetail.Prezzo_di_vendita_MOP__c <= tDetail.Prezzo_di_listino_MOP__c) ? (tDetail.Prezzo_di_listino_MOP__c - tDetail.Prezzo_di_vendita_MOP__c) : 0; 
                tDetail.PSconto_MOP__c = (tDetail.Prezzo_di_listino_MOP__c > 0 && tDetail.Sconto_MOP__c > 0) ? (tDetail.Sconto_MOP__c / tDetail.Prezzo_di_listino_MOP__c)*100 : 0;
            }
            
        }
        
        
    }
    
    
    
    
}