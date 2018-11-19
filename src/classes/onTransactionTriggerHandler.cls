public class onTransactionTriggerHandler {
    
    public static void setScontoInTransactionInsert(List<Transaction__c> TransactionNew){
        System.debug('SET SCONTO IN TRANSACTION ');
        for(Transaction__c trans : TransactionNew){
            
            trans.Sconto_AUD__c  = (trans.Prezzo_di_listino_AUD__c != 0 && trans.Prezzo_di_vendita_AUD__c <= trans.Prezzo_di_listino_AUD__c) ? (trans.Prezzo_di_listino_AUD__c - trans.Prezzo_di_vendita_AUD__c) : 0; 
            trans.PSconto_AUD__c = (trans.Prezzo_di_listino_AUD__c > 0 && trans.Sconto_AUD__c > 0) ? (trans.Sconto_AUD__c / trans.Prezzo_di_listino_AUD__c)*100 : 0;
            
            
            trans.Sconto_DKK__c  = (trans.Prezzo_di_Vendita_DKK__c != 0 && trans.Prezzo_di_Vendita_DKK__c <= trans.Prezzo_di_listino_DKK__c) ? (trans.Prezzo_di_listino_DKK__c - trans.Prezzo_di_Vendita_DKK__c) : 0; 
            trans.PSconto_DKK__c = (trans.Prezzo_di_listino_DKK__c > 0 && trans.Sconto_DKK__c > 0) ? (trans.Sconto_DKK__c / trans.Prezzo_di_listino_DKK__c)*100 : 0;
            
            trans.Sconto_RUB__c  = (trans.Prezzo_di_vendita_RUB__c != 0 && trans.Prezzo_di_vendita_RUB__c <= trans.Prezzo_di_listino_RUB__c) ? (trans.Prezzo_di_listino_RUB__c - trans.Prezzo_di_vendita_RUB__c) : 0; 
            trans.PSconto_RUB__c = (trans.Prezzo_di_listino_RUB__c > 0 && trans.Sconto_RUB__c > 0) ? (trans.Sconto_RUB__c / trans.Prezzo_di_listino_RUB__c)*100 : 0 ;
            
            trans.Sconto_MOP__c  = (trans.Prezzo_di_vendita_MOP__c != 0 && trans.Prezzo_di_vendita_MOP__c <= trans.Prezzo_di_listino_MOP__c) ? (trans.Prezzo_di_listino_MOP__c - trans.Prezzo_di_vendita_MOP__c) : 0; 
            trans.PSconto_MOP__c = (trans.Prezzo_di_listino_MOP__c > 0 && trans.Sconto_MOP__c > 0) ? (trans.Sconto_MOP__c / trans.Prezzo_di_listino_MOP__c)*100 : 0;
            System.debug('SET SCONTO INside TRANSACTION ' + trans.Sconto_MOP__c + ' -Sconto_MOP__c- ');
        }
    }
    
     public static void setScontoInTransactionUpdate(Map<Id,Transaction__c> TransactionNew, Map<Id,Transaction__c> TransactionOld){
        System.debug('SET SCONTO IN TRANSACTION ');
        
        for(Transaction__c trans : TransactionNew.values()){
            if((TransactionNew.get(trans.Id).Prezzo_di_Listino_AUD__c != TransactionOld.get(trans.Id).Prezzo_di_Listino_AUD__c) || (TransactionNew.get(trans.Id).Prezzo_di_vendita_AUD__c != TransactionOld.get(trans.Id).Prezzo_di_vendita_AUD__c)){
                trans.Sconto_AUD__c  = (trans.Prezzo_di_listino_AUD__c != 0 && trans.Prezzo_di_vendita_AUD__c <= trans.Prezzo_di_listino_AUD__c) ? (trans.Prezzo_di_listino_AUD__c - trans.Prezzo_di_vendita_AUD__c) : 0; 
                trans.PSconto_AUD__c = (trans.Prezzo_di_listino_AUD__c > 0 && trans.Sconto_AUD__c > 0) ? (trans.Sconto_AUD__c / trans.Prezzo_di_listino_AUD__c)*100 : 0;
            }
            if((TransactionNew.get(trans.Id).Prezzo_di_listino_DKK__c != TransactionOld.get(trans.Id).Prezzo_di_listino_DKK__c) || (TransactionNew.get(trans.Id).Prezzo_di_Vendita_DKK__c != TransactionOld.get(trans.Id).Prezzo_di_Vendita_DKK__c)){
                trans.Sconto_DKK__c  = (trans.Prezzo_di_listino_DKK__c != 0 && trans.Prezzo_di_Vendita_DKK__c <= trans.Prezzo_di_listino_DKK__c) ? (trans.Prezzo_di_listino_DKK__c - trans.Prezzo_di_Vendita_DKK__c) : 0; 
                trans.PSconto_DKK__c = (trans.Prezzo_di_listino_DKK__c > 0 && trans.Sconto_DKK__c > 0) ? (trans.Sconto_DKK__c / trans.Prezzo_di_listino_DKK__c)*100 : 0;
            }
            if((TransactionNew.get(trans.Id).Prezzo_di_listino_RUB__c != TransactionOld.get(trans.Id).Prezzo_di_listino_RUB__c) || (TransactionNew.get(trans.Id).Prezzo_di_vendita_RUB__c != TransactionOld.get(trans.Id).Prezzo_di_vendita_RUB__c)){
                trans.Sconto_RUB__c  = (trans.Prezzo_di_listino_RUB__c != 0 && trans.Prezzo_di_vendita_RUB__c <= trans.Prezzo_di_listino_RUB__c) ? (trans.Prezzo_di_listino_RUB__c - trans.Prezzo_di_vendita_RUB__c) : 0; 
                trans.PSconto_RUB__c = (trans.Prezzo_di_listino_RUB__c > 0 && trans.Sconto_RUB__c > 0) ? (trans.Sconto_RUB__c / trans.Prezzo_di_listino_RUB__c)*100 : 0 ;
            }
            if((TransactionNew.get(trans.Id).Prezzo_di_listino_MOP__c != TransactionOld.get(trans.Id).Prezzo_di_listino_MOP__c) || (TransactionNew.get(trans.Id).Prezzo_di_vendita_MOP__c != TransactionOld.get(trans.Id).Prezzo_di_vendita_MOP__c)){
                trans.Sconto_MOP__c  = (trans.Prezzo_di_listino_MOP__c != 0 && trans.Prezzo_di_vendita_MOP__c <= trans.Prezzo_di_listino_MOP__c) ? (trans.Prezzo_di_listino_MOP__c - trans.Prezzo_di_vendita_MOP__c) : 0; 
                trans.PSconto_MOP__c = (trans.Prezzo_di_listino_MOP__c > 0 && trans.Sconto_MOP__c > 0) ? (trans.Sconto_MOP__c / trans.Prezzo_di_listino_MOP__c)*100 : 0;
            }
        }
    }

}