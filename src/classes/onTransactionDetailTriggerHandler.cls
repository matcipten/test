public with sharing class onTransactionDetailTriggerHandler {


    //PN20190121 update picture on transactionDetail
    public static Boolean isMassiveUpdate = false;
    // public static Map<String,String> blockTriggerMap = new Map<String,String>();

    public static void CreateGiftActivity(list<Transaction_Detail__c> TransactionDetail){

        // if(onTransactionDetailTriggerHandler.blockTriggerMap.get('CreateGiftActivity') != null)
        //  return;
        list<Attivita_Marketing__c> ListNewActivity = new list<Attivita_Marketing__c>();

        set<string> SetTransactionIds               = new set<string>();
        list<Transaction__c> ListTransaction        = new list<Transaction__c>();
        map<string, string> MapTransactions         = new map<string, string>();

        string GiftRecTypeId = [SELECT id FROM Recordtype WHERE ( SobjectType = 'Attivita_Marketing__c'
                                                                                AND DeveloperName = 'Gift_Collection')].Id;

        for(Transaction_Detail__c t:TransactionDetail) {

            if(t.Gift__c) {

                SetTransactionIds.add(t.Transaction__c);

            }

        }

        ListTransaction = [ Select id, Account__c
                            From Transaction__c
                            Where id IN:SetTransactionIds];

        for(Transaction__c t:ListTransaction) {
            MapTransactions.put(t.Id, t.Account__c);
        }

        for(Transaction_Detail__c td:TransactionDetail) {

            if(td.Gift__c && MapTransactions.containsKey(td.Transaction__c)) {

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

        if(ListNewActivity.size()>0) {
            insert ListNewActivity;
        }

        // onTransactionDetailTriggerHandler.blockTriggerMap.put('CreateGiftActivity','CreateGiftActivity');


    }

    public static void setCurrencyInTransaction(list<Transaction_Detail__c> TransactionDetail){

        // if(onTransactionDetailTriggerHandler.blockTriggerMap.get('setCurrencyInTransaction') != null)
        //  return;

        System.debug('SET CURRENCY IN TRANSACTION');
        set<Id> transaction_SetId = new set<Id>();
        for (Transaction_Detail__c t : TransactionDetail) {
            transaction_SetId.add(t.Transaction__c);
        }

        System.debug('SV transaction_SetId: ' + transaction_SetId);

        Map<Id, Transaction__c> transectionMap = new Map<Id, Transaction__c>([SELECT Id,
                                                                              Prezzo_di_vendita_DKK__c, Prezzo_netto_IVA_DKK__c, Prezzo_di_listino_DKK__c,
                                                                              Prezzo_di_vendita_RUB__c, Prezzo_netto_IVA_RUB__c, Prezzo_di_listino_RUB__c,
                                                                              Prezzo_di_vendita_AUD__c, Prezzo_netto_IVA_AUD__c, Prezzo_di_listino_AUD__c,
                                                                              Prezzo_di_vendita_KRW__c, Prezzo_netto_IVA_KRW__c, Prezzo_di_listino_KRW__c,
                                                                              Prezzo_di_vendita_AED__c, Prezzo_netto_IVA_AED__c, Prezzo_di_listino_AED__c,
                                                                              Prezzo_di_vendita_PLN__c, Prezzo_netto_IVA_PLN__c, Prezzo_di_listino_PLN__c,
                                                                              Prezzo_di_vendita_QAR__c, Prezzo_netto_IVA_QAR__c, Prezzo_di_listino_QAR__c,
                                                                              Prezzo_di_vendita_SGD__c, Prezzo_netto_IVA_SGD__c, Prezzo_di_listino_SGD__c,
                                                                              Prezzo_di_vendita_SAR__c, Prezzo_netto_IVA_SAR__c, Prezzo_di_listino_SAR__c

                                                                              FROM Transaction__c
                                                                              WHERE Id IN: transaction_SetId]);

        List<Transaction_Detail__c> transectionDetailList = [SELECT Id, Prezzo_di_Listino__c, Prezzo_di_Vendita__c, Transaction__c, CurrencyIsoCode,
                                                             Prezzo_di_vendita_DKK__c, Prezzo_netto_IVA_DKK__c, Prezzo_di_listino_DKK__c,
                                                             Prezzo_di_vendita_RUB__c, Prezzo_netto_IVA_RUB__c, Prezzo_di_listino_RUB__c,
                                                             Prezzo_di_vendita_AUD__c, Prezzo_netto_IVA_AUD__c, Prezzo_di_listino_AUD__c,
                                                             Prezzo_di_vendita_KRW__c, Prezzo_netto_IVA_KRW__c, Prezzo_di_listino_KRW__c,
                                                             Prezzo_di_vendita_AED__c, Prezzo_netto_IVA_AED__c, Prezzo_di_listino_AED__c,
                                                             Prezzo_di_vendita_PLN__c, Prezzo_netto_IVA_PLN__c, Prezzo_di_listino_PLN__c,
                                                             Prezzo_di_vendita_QAR__c, Prezzo_netto_IVA_QAR__c, Prezzo_di_listino_QAR__c,
                                                             Prezzo_di_vendita_SGD__c, Prezzo_netto_IVA_SGD__c, Prezzo_di_listino_SGD__c,
                                                             Prezzo_di_vendita_SAR__c, Prezzo_netto_IVA_SAR__c, Prezzo_di_listino_SAR__c
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

        Decimal Prezzo_vendita_KRW = 0;
        Decimal Prezzo_netto_IVA_KRW = 0;
        Decimal Prezzo_di_listino_KRW = 0;

        Decimal Prezzo_vendita_AED = 0;
        Decimal Prezzo_netto_IVA_AED = 0;
        Decimal Prezzo_di_listino_AED = 0;

        Decimal Prezzo_vendita_PLN = 0;
        Decimal Prezzo_netto_IVA_PLN = 0;
        Decimal Prezzo_di_listino_PLN = 0;

        Decimal Prezzo_vendita_QAR = 0;
        Decimal Prezzo_netto_IVA_QAR = 0;
        Decimal Prezzo_di_listino_QAR = 0;

        Decimal Prezzo_vendita_SGD = 0;
        Decimal Prezzo_netto_IVA_SGD = 0;
        Decimal Prezzo_di_listino_SGD = 0;

        Decimal Prezzo_vendita_SAR = 0;
        Decimal Prezzo_netto_IVA_SAR = 0;
        Decimal Prezzo_di_listino_SAR = 0;


        for (Transaction_Detail__c trsd : transectionDetailList) {
        
            if(trsd.Prezzo_di_Vendita_DKK__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_DKK__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_DKK__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_DKK__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_DKK__c+trsd.Prezzo_di_Vendita_DKK__c;
					System.debug('MCIPE DEBUG '+Prezzo_vendita_DKK);
                    Prezzo_vendita_DKK += trsd.Prezzo_di_Vendita_DKK__c;
					System.debug('MCIPE DEBUG '+Prezzo_vendita_DKK);
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_DKK__c = Prezzo_vendita_DKK;
            }
            if(trsd.Prezzo_di_listino_DKK__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_DKK__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_DKK__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_DKK__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_DKK__c+trsd.Prezzo_di_listino_DKK__c;
					System.debug('MCIPE DEBUG '+Prezzo_di_listino_DKK);
                    Prezzo_di_listino_DKK += trsd.Prezzo_di_listino_DKK__c;
					System.debug('MCIPE DEBUG '+Prezzo_di_listino_DKK);
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_DKK__c = Prezzo_di_listino_DKK;                    
            }
            if(trsd.Prezzo_netto_IVA_DKK__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_DKK__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_DKK__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_DKK__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_DKK__c+trsd.Prezzo_netto_IVA_DKK__c;
					System.debug('MCIPE DEBUG '+Prezzo_netto_IVA_DKK);
                    Prezzo_netto_IVA_DKK += trsd.Prezzo_netto_IVA_DKK__c;
					System.debug('MCIPE DEBUG '+Prezzo_netto_IVA_DKK);
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_DKK__c = Prezzo_netto_IVA_DKK;                    
            }

            if(trsd.Prezzo_di_Vendita_RUB__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_RUB__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_RUB__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_RUB__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_RUB__c+trsd.Prezzo_di_Vendita_RUB__c;                    
                    Prezzo_vendita_RUB += trsd.Prezzo_di_Vendita_RUB__c;                    
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_RUB__c = Prezzo_vendita_RUB;                    
            }
            if(trsd.Prezzo_di_listino_RUB__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_RUB__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_RUB__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_RUB__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_RUB__c+trsd.Prezzo_di_listino_RUB__c;
                    Prezzo_di_listino_RUB += trsd.Prezzo_di_listino_RUB__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_RUB__c = Prezzo_di_listino_RUB;                     
            }
            if(trsd.Prezzo_netto_IVA_RUB__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_RUB__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_RUB__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_RUB__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_RUB__c+trsd.Prezzo_netto_IVA_RUB__c;
                    Prezzo_netto_IVA_RUB += trsd.Prezzo_netto_IVA_RUB__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_RUB__c = Prezzo_netto_IVA_RUB;                     
            }

            if(trsd.Prezzo_di_Vendita_AUD__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AUD__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AUD__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AUD__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AUD__c+trsd.Prezzo_di_Vendita_AUD__c;
                    Prezzo_vendita_AUD += trsd.Prezzo_di_Vendita_AUD__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AUD__c = Prezzo_vendita_AUD;
            }
            if(trsd.Prezzo_di_listino_AUD__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AUD__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AUD__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AUD__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AUD__c+trsd.Prezzo_di_listino_AUD__c;
                    Prezzo_di_listino_AUD += trsd.Prezzo_di_listino_AUD__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AUD__c = Prezzo_di_listino_AUD;
            }
            if(trsd.Prezzo_netto_IVA_AUD__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AUD__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AUD__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AUD__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AUD__c+trsd.Prezzo_netto_IVA_AUD__c;
                    Prezzo_netto_IVA_AUD += trsd.Prezzo_netto_IVA_AUD__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AUD__c = Prezzo_netto_IVA_AUD;                    
            }

            if(trsd.Prezzo_di_Vendita_KRW__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_KRW__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_KRW__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_KRW__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_KRW__c+trsd.Prezzo_di_Vendita_KRW__c;
                    Prezzo_vendita_KRW += trsd.Prezzo_di_Vendita_KRW__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_KRW__c = Prezzo_vendita_KRW;
            }
            if(trsd.Prezzo_di_listino_KRW__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_KRW__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_KRW__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_KRW__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_KRW__c+trsd.Prezzo_di_listino_KRW__c;
                    Prezzo_di_listino_KRW += trsd.Prezzo_di_listino_KRW__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_KRW__c = Prezzo_di_listino_KRW;
            }
            if(trsd.Prezzo_netto_IVA_KRW__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_KRW__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_KRW__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_KRW__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_KRW__c+trsd.Prezzo_netto_IVA_KRW__c;
                    Prezzo_netto_IVA_KRW += trsd.Prezzo_netto_IVA_KRW__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_KRW__c = Prezzo_netto_IVA_KRW; 
            }

            if(trsd.Prezzo_di_Vendita_AED__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AED__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AED__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AED__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AED__c+trsd.Prezzo_di_Vendita_AED__c;
                    Prezzo_vendita_AED += trsd.Prezzo_di_Vendita_AED__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_AED__c = Prezzo_vendita_AED;
            }
            if(trsd.Prezzo_di_listino_AED__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AED__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AED__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AED__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AED__c+trsd.Prezzo_di_listino_AED__c;
                    Prezzo_di_listino_AED += trsd.Prezzo_di_listino_AED__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_AED__c = Prezzo_di_listino_AED;
            }
            if(trsd.Prezzo_netto_IVA_AED__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AED__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AED__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AED__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AED__c+trsd.Prezzo_netto_IVA_AED__c;
                    Prezzo_netto_IVA_AED += trsd.Prezzo_netto_IVA_AED__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_AED__c = Prezzo_netto_IVA_AED;
            }

            if(trsd.Prezzo_di_Vendita_PLN__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_PLN__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_PLN__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_PLN__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_PLN__c+trsd.Prezzo_di_Vendita_PLN__c;
                    Prezzo_vendita_PLN += trsd.Prezzo_di_Vendita_PLN__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_PLN__c = Prezzo_vendita_PLN;
            }
            if(trsd.Prezzo_di_listino_PLN__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_PLN__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_PLN__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_PLN__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_PLN__c+trsd.Prezzo_di_listino_PLN__c;
                    Prezzo_di_listino_PLN += trsd.Prezzo_di_listino_PLN__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_PLN__c = Prezzo_di_listino_PLN;
            }
            if(trsd.Prezzo_netto_IVA_PLN__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_PLN__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_PLN__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_PLN__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_PLN__c+trsd.Prezzo_netto_IVA_PLN__c;
                    Prezzo_netto_IVA_PLN += trsd.Prezzo_netto_IVA_PLN__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_PLN__c = Prezzo_netto_IVA_PLN;
            }

            if(trsd.Prezzo_di_Vendita_QAR__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_QAR__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_QAR__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_QAR__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_QAR__c+trsd.Prezzo_di_Vendita_QAR__c;
                    Prezzo_vendita_QAR += trsd.Prezzo_di_Vendita_QAR__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_QAR__c = Prezzo_vendita_QAR;
            }
            if(trsd.Prezzo_di_listino_QAR__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_QAR__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_QAR__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_QAR__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_QAR__c+trsd.Prezzo_di_listino_QAR__c;
                    Prezzo_di_listino_QAR += trsd.Prezzo_di_listino_QAR__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_QAR__c = Prezzo_di_listino_QAR;
            }
            if(trsd.Prezzo_netto_IVA_QAR__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_QAR__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_QAR__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_QAR__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_QAR__c+trsd.Prezzo_netto_IVA_QAR__c;
                    Prezzo_netto_IVA_QAR += trsd.Prezzo_netto_IVA_QAR__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_QAR__c = Prezzo_netto_IVA_QAR;
            }

            if(trsd.Prezzo_di_Vendita_SGD__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SGD__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SGD__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SGD__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SGD__c+trsd.Prezzo_di_Vendita_SGD__c;
                    Prezzo_vendita_SGD += trsd.Prezzo_di_Vendita_SGD__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SGD__c = Prezzo_vendita_SGD;
            }
            if(trsd.Prezzo_di_listino_SGD__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SGD__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SGD__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SGD__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SGD__c+trsd.Prezzo_di_listino_SGD__c;
                    Prezzo_di_listino_SGD += trsd.Prezzo_di_listino_SGD__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SGD__c = Prezzo_di_listino_SGD;
            }
            if(trsd.Prezzo_netto_IVA_SGD__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SGD__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SGD__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SGD__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SGD__c+trsd.Prezzo_netto_IVA_SGD__c;
                    Prezzo_netto_IVA_SGD += trsd.Prezzo_netto_IVA_SGD__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SGD__c = Prezzo_netto_IVA_SGD; 
            }

            if(trsd.Prezzo_di_Vendita_SAR__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SAR__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SAR__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SAR__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SAR__c+trsd.Prezzo_di_Vendita_SAR__c;
                    Prezzo_vendita_SAR += trsd.Prezzo_di_Vendita_SAR__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_Vendita_SAR__c = Prezzo_vendita_SAR;
            }
            if(trsd.Prezzo_di_listino_SAR__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SAR__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SAR__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SAR__c = transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SAR__c+trsd.Prezzo_di_listino_SAR__c;
                    Prezzo_di_listino_SAR += trsd.Prezzo_di_listino_SAR__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_di_listino_SAR__c = Prezzo_di_listino_SAR;
            }
            if(trsd.Prezzo_netto_IVA_SAR__c != NULL) {
                if(transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SAR__c == null){
                        transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SAR__c = 0;
                    }
                    //transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SAR__c = transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SAR__c+trsd.Prezzo_netto_IVA_SAR__c;
                    Prezzo_netto_IVA_SAR += trsd.Prezzo_netto_IVA_SAR__c;
                    transectionMap.get(trsd.Transaction__c).Prezzo_netto_IVA_SAR__c = Prezzo_netto_IVA_SAR;
            }
        }

        for(Id Id_transaction : transectionMap.keySet()) {

            transectionList.add(transectionMap.get(Id_transaction));
        }





        // for(Id Id_transaction : transectionMap.keySet()) {
        //  for (Transaction_Detail__c trsd : transectionDetailList) {
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_Vendita_RUB__c != NULL) {
        //          Prezzo_vendita_DKK = Prezzo_vendita_DKK + trsd.Prezzo_di_Vendita_DKK__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_DKK__c != NULL) {
        //          Prezzo_di_listino_DKK = Prezzo_di_listino_DKK + trsd.Prezzo_di_listino_DKK__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_DKK__c != NULL) {
        //          Prezzo_netto_IVA_DKK = Prezzo_netto_IVA_DKK + trsd.Prezzo_netto_IVA_DKK__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_RUB__c != NULL) {
        //          Prezzo_netto_IVA_RUB = Prezzo_netto_IVA_RUB + trsd.Prezzo_netto_IVA_RUB__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_vendita_RUB__c != NULL) {
        //          Prezzo_vendita_RUB = Prezzo_vendita_RUB + trsd.Prezzo_di_vendita_RUB__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_RUB__c != NULL) {
        //          Prezzo_di_listino_RUB = Prezzo_di_listino_RUB + trsd.Prezzo_di_listino_RUB__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_AUD__c != NULL) {
        //          Prezzo_netto_IVA_AUD = Prezzo_netto_IVA_AUD + trsd.Prezzo_netto_IVA_AUD__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_vendita_AUD__c != NULL) {
        //          Prezzo_vendita_AUD = Prezzo_vendita_AUD + trsd.Prezzo_di_vendita_AUD__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_AUD__c != NULL) {
        //          Prezzo_di_listino_AUD = Prezzo_di_listino_AUD + trsd.Prezzo_di_listino_AUD__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_Vendita_KRW__c != NULL) {
        //          Prezzo_vendita_KRW = Prezzo_vendita_KRW + trsd.Prezzo_di_Vendita_KRW__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_KRW__c != NULL) {
        //          Prezzo_di_listino_KRW = Prezzo_di_listino_KRW + trsd.Prezzo_di_listino_KRW__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_KRW__c != NULL) {
        //          Prezzo_netto_IVA_KRW = Prezzo_netto_IVA_KRW + trsd.Prezzo_netto_IVA_KRW__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_Vendita_AED__c != NULL) {
        //          Prezzo_vendita_AED = Prezzo_vendita_AED + trsd.Prezzo_di_Vendita_AED__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_AED__c != NULL) {
        //          Prezzo_di_listino_AED = Prezzo_di_listino_AED + trsd.Prezzo_di_listino_AED__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_AED__c != NULL) {
        //          Prezzo_netto_IVA_AED = Prezzo_netto_IVA_AED + trsd.Prezzo_netto_IVA_AED__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_Vendita_PLN__c != NULL) {
        //          Prezzo_vendita_PLN = Prezzo_vendita_PLN + trsd.Prezzo_di_Vendita_PLN__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_PLN__c != NULL) {
        //          Prezzo_di_listino_PLN = Prezzo_di_listino_PLN + trsd.Prezzo_di_listino_PLN__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_PLN__c != NULL) {
        //          Prezzo_netto_IVA_PLN = Prezzo_netto_IVA_PLN + trsd.Prezzo_netto_IVA_PLN__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_Vendita_QAR__c != NULL) {
        //          Prezzo_vendita_QAR = Prezzo_vendita_QAR + trsd.Prezzo_di_Vendita_QAR__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_QAR__c != NULL) {
        //          Prezzo_di_listino_QAR = Prezzo_di_listino_QAR + trsd.Prezzo_di_listino_QAR__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_QAR__c != NULL) {
        //          Prezzo_netto_IVA_QAR = Prezzo_netto_IVA_QAR + trsd.Prezzo_netto_IVA_QAR__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_Vendita_SGD__c != NULL) {
        //          Prezzo_vendita_SGD = Prezzo_vendita_SGD + trsd.Prezzo_di_Vendita_SGD__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_SGD__c != NULL) {
        //          Prezzo_di_listino_SGD = Prezzo_di_listino_SGD + trsd.Prezzo_di_listino_SGD__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_SGD__c != NULL) {
        //          Prezzo_netto_IVA_SGD = Prezzo_netto_IVA_SGD + trsd.Prezzo_netto_IVA_SGD__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_Vendita_SAR__c != NULL) {
        //          Prezzo_vendita_SAR = Prezzo_vendita_SAR + trsd.Prezzo_di_Vendita_SAR__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_di_listino_SAR__c != NULL) {
        //          Prezzo_di_listino_SAR = Prezzo_di_listino_SAR + trsd.Prezzo_di_listino_SAR__c;
        //      }
        //      if(trsd.Transaction__c == Id_transaction && trsd.Prezzo_netto_IVA_SAR__c != NULL) {
        //          Prezzo_netto_IVA_SAR = Prezzo_netto_IVA_SAR + trsd.Prezzo_netto_IVA_SAR__c;
        //      }
        //  }

        //  transectionMap.get(Id_transaction).Prezzo_di_Vendita_DKK__c = Prezzo_vendita_DKK;
        //  transectionMap.get(Id_transaction).Prezzo_di_Vendita_RUB__c = Prezzo_vendita_RUB;
        //  transectionMap.get(Id_transaction).Prezzo_di_vendita_AUD__c = Prezzo_vendita_AUD;

        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_DKK__c = Prezzo_netto_IVA_DKK;
        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_RUB__c = Prezzo_netto_IVA_RUB;
        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_AUD__c = Prezzo_netto_IVA_AUD;

        //  transectionMap.get(Id_transaction).Prezzo_di_listino_DKK__c = Prezzo_di_listino_DKK;
        //  transectionMap.get(Id_transaction).Prezzo_di_listino_RUB__c = Prezzo_di_listino_RUB;
        //  transectionMap.get(Id_transaction).Prezzo_di_listino_AUD__c = Prezzo_di_listino_AUD;

        //  transectionMap.get(Id_transaction).Prezzo_di_Vendita_KRW__c = Prezzo_vendita_KRW;
        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_KRW__c = Prezzo_netto_IVA_KRW;
        //  transectionMap.get(Id_transaction).Prezzo_di_listino_KRW__c = Prezzo_di_listino_KRW;

        //  transectionMap.get(Id_transaction).Prezzo_di_Vendita_AED__c = Prezzo_vendita_AED;
        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_AED__c = Prezzo_netto_IVA_AED;
        //  transectionMap.get(Id_transaction).Prezzo_di_listino_AED__c = Prezzo_di_listino_AED;

        //  transectionMap.get(Id_transaction).Prezzo_di_Vendita_PLN__c = Prezzo_vendita_PLN;
        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_PLN__c = Prezzo_netto_IVA_PLN;
        //  transectionMap.get(Id_transaction).Prezzo_di_listino_PLN__c = Prezzo_di_listino_PLN;

        //  transectionMap.get(Id_transaction).Prezzo_di_Vendita_QAR__c = Prezzo_vendita_QAR;
        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_QAR__c = Prezzo_netto_IVA_QAR;
        //  transectionMap.get(Id_transaction).Prezzo_di_listino_QAR__c = Prezzo_di_listino_QAR;

        //  transectionMap.get(Id_transaction).Prezzo_di_Vendita_SGD__c = Prezzo_vendita_SGD;
        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_SGD__c = Prezzo_netto_IVA_SGD;
        //  transectionMap.get(Id_transaction).Prezzo_di_listino_SGD__c = Prezzo_di_listino_SGD;

        //  transectionMap.get(Id_transaction).Prezzo_di_Vendita_SAR__c = Prezzo_vendita_SAR;
        //  transectionMap.get(Id_transaction).Prezzo_netto_IVA_SAR__c = Prezzo_netto_IVA_SAR;
        //  transectionMap.get(Id_transaction).Prezzo_di_listino_SAR__c = Prezzo_di_listino_SAR;


        //  transectionList.add(transectionMap.get(Id_transaction));
        // }

        update transectionList;

        // onTransactionDetailTriggerHandler.blockTriggerMap.put('setCurrencyInTransaction','setCurrencyInTransaction');

    }

    public static void setScontoInTransactionDetailsInsert(List<Transaction_Detail__c> TransactionDetailNew){
        // if(onTransactionDetailTriggerHandler.blockTriggerMap.get('setScontoInTransactionDetailsInsert') != null)
        //  return;

        System.debug('SET SCONTO IN TRANSACTION DETAIL');
        for(Transaction_Detail__c tDetail : TransactionDetailNew) {

            tDetail.Sconto_AUD__c  = (tDetail.Prezzo_di_listino_AUD__c != 0 && tDetail.Prezzo_di_vendita_AUD__c <= tDetail.Prezzo_di_listino_AUD__c) ? (tDetail.Prezzo_di_listino_AUD__c - tDetail.Prezzo_di_vendita_AUD__c) : 0;
            tDetail.PSconto_AUD__c = (tDetail.Prezzo_di_listino_AUD__c > 0 && tDetail.Sconto_AUD__c > 0) ? (tDetail.Sconto_AUD__c / tDetail.Prezzo_di_listino_AUD__c)*100 : 0;


            tDetail.Sconto_DKK__c  = (tDetail.Prezzo_di_listino_DKK__c != 0 && tDetail.Prezzo_di_Vendita_DKK__c <= tDetail.Prezzo_di_listino_DKK__c) ? (tDetail.Prezzo_di_listino_DKK__c - tDetail.Prezzo_di_Vendita_DKK__c) : 0;
            tDetail.PSconto_DKK__c = (tDetail.Prezzo_di_listino_DKK__c > 0 && tDetail.Sconto_DKK__c > 0) ? (tDetail.Sconto_DKK__c / tDetail.Prezzo_di_listino_DKK__c)*100 : 0;

            tDetail.Sconto_RUB__c  = (tDetail.Prezzo_di_listino_RUB__c != 0 && tDetail.Prezzo_di_vendita_RUB__c <= tDetail.Prezzo_di_listino_RUB__c) ? (tDetail.Prezzo_di_listino_RUB__c - tDetail.Prezzo_di_vendita_RUB__c) : 0;
            tDetail.PSconto_RUB__c = (tDetail.Prezzo_di_listino_RUB__c > 0 && tDetail.Sconto_RUB__c > 0) ? (tDetail.Sconto_RUB__c / tDetail.Prezzo_di_listino_RUB__c)*100 : 0;

            tDetail.Sconto_MOP__c  = (tDetail.Prezzo_di_listino_MOP__c != 0 && tDetail.Prezzo_di_vendita_MOP__c <= tDetail.Prezzo_di_listino_MOP__c) ? (tDetail.Prezzo_di_listino_MOP__c - tDetail.Prezzo_di_vendita_MOP__c) : 0;
            tDetail.PSconto_MOP__c = (tDetail.Prezzo_di_listino_MOP__c > 0 && tDetail.Sconto_MOP__c > 0) ? (tDetail.Sconto_MOP__c / tDetail.Prezzo_di_listino_MOP__c)*100 : 0;

            tDetail.Sconto_KRW__c  = (tDetail.Prezzo_di_listino_KRW__c != 0 && tDetail.Prezzo_di_Vendita_KRW__c <= tDetail.Prezzo_di_listino_KRW__c) ? (tDetail.Prezzo_di_listino_KRW__c - tDetail.Prezzo_di_Vendita_KRW__c) : 0;
            tDetail.PSconto_KRW__c = (tDetail.Prezzo_di_listino_KRW__c > 0 && tDetail.Sconto_KRW__c > 0) ? (tDetail.Sconto_KRW__c / tDetail.Prezzo_di_listino_KRW__c)*100 : 0;

            tDetail.Sconto_AED__c  = (tDetail.Prezzo_di_listino_AED__c != 0 && tDetail.Prezzo_di_Vendita_AED__c <= tDetail.Prezzo_di_listino_AED__c) ? (tDetail.Prezzo_di_listino_AED__c - tDetail.Prezzo_di_Vendita_AED__c) : 0;
            tDetail.PSconto_AED__c = (tDetail.Prezzo_di_listino_AED__c > 0 && tDetail.Sconto_AED__c > 0) ? (tDetail.Sconto_AED__c / tDetail.Prezzo_di_listino_AED__c)*100 : 0;

            tDetail.Sconto_PLN__c  = (tDetail.Prezzo_di_listino_PLN__c != 0 && tDetail.Prezzo_di_Vendita_PLN__c <= tDetail.Prezzo_di_listino_PLN__c) ? (tDetail.Prezzo_di_listino_PLN__c - tDetail.Prezzo_di_Vendita_PLN__c) : 0;
            tDetail.PSconto_PLN__c = (tDetail.Prezzo_di_listino_PLN__c > 0 && tDetail.Sconto_PLN__c > 0) ? (tDetail.Sconto_PLN__c / tDetail.Prezzo_di_listino_PLN__c)*100 : 0;

            tDetail.Sconto_QAR__c  = (tDetail.Prezzo_di_listino_QAR__c != 0 && tDetail.Prezzo_di_Vendita_QAR__c <= tDetail.Prezzo_di_listino_QAR__c) ? (tDetail.Prezzo_di_listino_QAR__c - tDetail.Prezzo_di_Vendita_QAR__c) : 0;
            tDetail.PSconto_QAR__c = (tDetail.Prezzo_di_listino_QAR__c > 0 && tDetail.Sconto_QAR__c > 0) ? (tDetail.Sconto_QAR__c / tDetail.Prezzo_di_listino_QAR__c)*100 : 0;

            tDetail.Sconto_SGD__c  = (tDetail.Prezzo_di_listino_SGD__c != 0 && tDetail.Prezzo_di_Vendita_SGD__c <= tDetail.Prezzo_di_listino_SGD__c) ? (tDetail.Prezzo_di_listino_SGD__c - tDetail.Prezzo_di_Vendita_SGD__c) : 0;
            tDetail.PSconto_SGD__c = (tDetail.Prezzo_di_listino_SGD__c > 0 && tDetail.Sconto_SGD__c > 0) ? (tDetail.Sconto_SGD__c / tDetail.Prezzo_di_listino_SGD__c)*100 : 0;

            tDetail.Sconto_SAR__c  = (tDetail.Prezzo_di_listino_SAR__c != 0 && tDetail.Prezzo_di_Vendita_SAR__c <= tDetail.Prezzo_di_listino_SAR__c) ? (tDetail.Prezzo_di_listino_SAR__c - tDetail.Prezzo_di_Vendita_SAR__c) : 0;
            tDetail.PSconto_SAR__c = (tDetail.Prezzo_di_listino_SAR__c > 0 && tDetail.Sconto_SAR__c > 0) ? (tDetail.Sconto_SAR__c / tDetail.Prezzo_di_listino_SAR__c)*100 : 0;

        }

        // onTransactionDetailTriggerHandler.blockTriggerMap.put('setScontoInTransactionDetailsInsert','setScontoInTransactionDetailsInsert');
    }

    public static void setScontoInTransactionDetailsUpdate(Map<Id,Transaction_Detail__c> TransactionDetailNew, Map<Id,Transaction_Detail__c> TransactionDetailOld){

        // if(onTransactionDetailTriggerHandler.blockTriggerMap.get('setScontoInTransactionDetailsUpdate') != null)
        //  return;

        System.debug('SET SCONTO IN TRANSACTION DETAIL');

        for(Transaction_Detail__c tDetail : TransactionDetailNew.values()) {
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_Listino_AUD__c!= TransactionDetailOld.get(tDetail.Id).Prezzo_di_Listino_AUD__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_vendita_AUD__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_vendita_AUD__c)) {
                tDetail.Sconto_AUD__c  = (tDetail.Prezzo_di_listino_AUD__c != 0 && tDetail.Prezzo_di_vendita_AUD__c <= tDetail.Prezzo_di_listino_AUD__c) ? (tDetail.Prezzo_di_listino_AUD__c - tDetail.Prezzo_di_vendita_AUD__c) : 0;
                tDetail.PSconto_AUD__c = (tDetail.Prezzo_di_listino_AUD__c > 0 && tDetail.Sconto_AUD__c > 0) ? (tDetail.Sconto_AUD__c / tDetail.Prezzo_di_listino_AUD__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_DKK__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_DKK__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_Vendita_DKK__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_Vendita_DKK__c)) {
                tDetail.Sconto_DKK__c  = (tDetail.Prezzo_di_listino_DKK__c != 0 && tDetail.Prezzo_di_Vendita_DKK__c <= tDetail.Prezzo_di_listino_DKK__c) ? (tDetail.Prezzo_di_listino_DKK__c - tDetail.Prezzo_di_Vendita_DKK__c) : 0;
                tDetail.PSconto_DKK__c = (tDetail.Prezzo_di_listino_DKK__c > 0 && tDetail.Sconto_DKK__c > 0) ? (tDetail.Sconto_DKK__c / tDetail.Prezzo_di_listino_DKK__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_RUB__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_RUB__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_vendita_RUB__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_vendita_RUB__c)) {
                tDetail.Sconto_RUB__c  = (tDetail.Prezzo_di_listino_RUB__c != 0 && tDetail.Prezzo_di_vendita_RUB__c <= tDetail.Prezzo_di_listino_RUB__c) ? (tDetail.Prezzo_di_listino_RUB__c - tDetail.Prezzo_di_vendita_RUB__c) : 0;
                tDetail.PSconto_RUB__c = (tDetail.Prezzo_di_listino_RUB__c > 0 && tDetail.Sconto_RUB__c > 0) ? (tDetail.Sconto_RUB__c / tDetail.Prezzo_di_listino_RUB__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_MOP__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_MOP__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_vendita_MOP__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_vendita_MOP__c)) {
                tDetail.Sconto_MOP__c  = (tDetail.Prezzo_di_listino_MOP__c != 0 && tDetail.Prezzo_di_vendita_MOP__c <= tDetail.Prezzo_di_listino_MOP__c) ? (tDetail.Prezzo_di_listino_MOP__c - tDetail.Prezzo_di_vendita_MOP__c) : 0;
                tDetail.PSconto_MOP__c = (tDetail.Prezzo_di_listino_MOP__c > 0 && tDetail.Sconto_MOP__c > 0) ? (tDetail.Sconto_MOP__c / tDetail.Prezzo_di_listino_MOP__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_KRW__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_KRW__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_Vendita_KRW__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_Vendita_KRW__c)) {
                tDetail.Sconto_KRW__c  = (tDetail.Prezzo_di_listino_KRW__c != 0 && tDetail.Prezzo_di_Vendita_KRW__c <= tDetail.Prezzo_di_listino_KRW__c) ? (tDetail.Prezzo_di_listino_KRW__c - tDetail.Prezzo_di_Vendita_KRW__c) : 0;
                tDetail.PSconto_KRW__c = (tDetail.Prezzo_di_listino_KRW__c > 0 && tDetail.Sconto_KRW__c > 0) ? (tDetail.Sconto_KRW__c / tDetail.Prezzo_di_listino_KRW__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_AED__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_AED__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_Vendita_AED__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_Vendita_AED__c)) {
                tDetail.Sconto_AED__c  = (tDetail.Prezzo_di_listino_AED__c != 0 && tDetail.Prezzo_di_Vendita_AED__c <= tDetail.Prezzo_di_listino_AED__c) ? (tDetail.Prezzo_di_listino_AED__c - tDetail.Prezzo_di_Vendita_AED__c) : 0;
                tDetail.PSconto_AED__c = (tDetail.Prezzo_di_listino_AED__c > 0 && tDetail.Sconto_AED__c > 0) ? (tDetail.Sconto_AED__c / tDetail.Prezzo_di_listino_AED__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_PLN__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_PLN__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_Vendita_PLN__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_Vendita_PLN__c)) {
                tDetail.Sconto_PLN__c  = (tDetail.Prezzo_di_listino_PLN__c != 0 && tDetail.Prezzo_di_Vendita_PLN__c <= tDetail.Prezzo_di_listino_PLN__c) ? (tDetail.Prezzo_di_listino_PLN__c - tDetail.Prezzo_di_Vendita_PLN__c) : 0;
                tDetail.PSconto_PLN__c = (tDetail.Prezzo_di_listino_PLN__c > 0 && tDetail.Sconto_PLN__c > 0) ? (tDetail.Sconto_PLN__c / tDetail.Prezzo_di_listino_PLN__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_QAR__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_QAR__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_Vendita_QAR__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_Vendita_QAR__c)) {
                tDetail.Sconto_QAR__c  = (tDetail.Prezzo_di_listino_QAR__c != 0 && tDetail.Prezzo_di_Vendita_QAR__c <= tDetail.Prezzo_di_listino_QAR__c) ? (tDetail.Prezzo_di_listino_QAR__c - tDetail.Prezzo_di_Vendita_QAR__c) : 0;
                tDetail.PSconto_QAR__c = (tDetail.Prezzo_di_listino_QAR__c > 0 && tDetail.Sconto_QAR__c > 0) ? (tDetail.Sconto_QAR__c / tDetail.Prezzo_di_listino_QAR__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_SGD__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_SGD__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_Vendita_SGD__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_Vendita_SGD__c)) {
                tDetail.Sconto_SGD__c  = (tDetail.Prezzo_di_listino_SGD__c != 0 && tDetail.Prezzo_di_Vendita_SGD__c <= tDetail.Prezzo_di_listino_SGD__c) ? (tDetail.Prezzo_di_listino_SGD__c - tDetail.Prezzo_di_Vendita_SGD__c) : 0;
                tDetail.PSconto_SGD__c = (tDetail.Prezzo_di_listino_SGD__c > 0 && tDetail.Sconto_SGD__c > 0) ? (tDetail.Sconto_SGD__c / tDetail.Prezzo_di_listino_SGD__c)*100 : 0;
            }
            if((TransactionDetailNew.get(tDetail.Id).Prezzo_di_listino_SAR__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_listino_SAR__c) || (TransactionDetailNew.get(tDetail.Id).Prezzo_di_Vendita_SAR__c != TransactionDetailOld.get(tDetail.Id).Prezzo_di_Vendita_SAR__c)) {
                tDetail.Sconto_SAR__c  = (tDetail.Prezzo_di_listino_SAR__c != 0 && tDetail.Prezzo_di_Vendita_SAR__c <= tDetail.Prezzo_di_listino_SAR__c) ? (tDetail.Prezzo_di_listino_SAR__c - tDetail.Prezzo_di_Vendita_SAR__c) : 0;
                tDetail.PSconto_SAR__c = (tDetail.Prezzo_di_listino_SAR__c > 0 && tDetail.Sconto_SAR__c > 0) ? (tDetail.Sconto_SAR__c / tDetail.Prezzo_di_listino_SAR__c)*100 : 0;
            }

        }

        // onTransactionDetailTriggerHandler.blockTriggerMap.put('setScontoInTransactionDetailsUpdate','setScontoInTransactionDetailsUpdate');

    }


    //PN20190121 update picture on transactionDetail
    public static void updateDetailImage(Map<String,Product__c> productsMap,List<Transaction_Detail__c> details){
        // if(onTransactionDetailTriggerHandler.blockTriggerMap.get('updateDetailImage') != null)
        //  return;

        system.debug('start handler');
        Map<String,String> relatedProductsMap = new Map<String,String>();
        Map<String,List<String> > relatedProductGiftsMap = new Map<String,List<String> >();

        productsMap = new Map<String,Product__c>([SELECT Id, (SELECT Id,LinkedEntityId,ContentDocument.CreatedDate FROM ContentDocumentLinks WHERE LinkedEntity.Type = 'Product__c' ORDER BY ContentDocument.CreatedDate DESC LIMIT 1) FROM Product__c WHERE Id IN: productsMap.keySet()]);

        Map<String,String> contentDocumentsandCDL = new Map<String,String> ();
        for(Product__c p : productsMap.values()) {
            if(p.ContentDocumentLinks != null && p.ContentDocumentLinks.size() >0) {
                for(ContentDocumentLink cdl : p.ContentDocumentLinks) {
                    contentDocumentsandCDL.put(cdl.Id,cdl.ContentDocumentId);
                }
            }
        }

        Map<String,ContentDocument> contentDocumentsMap = new Map<String,ContentDocument>([SELECT Id, (SELECT Id FROM ContentVersions WHERE IsLatest = true) FROM ContentDocument WHERE Id IN: contentDocumentsandCDL.values()]);

        for(Transaction_Detail__c detail : details) {

            if(detail.Product__c == null) {
                detail.Product_Image_Reference__c = null;
            }
            else{
                String prodId =  detail.Product__c;
                Product__c prod = productsMap.get(prodId);
                System.debug('product');
                System.debug(JSON.serializePretty(prod));
                system.debug(prod.ContentDocumentLinks);
                system.debug(prod.ContentDocumentLinks.size());
                if(prod.ContentDocumentLinks != null && prod.ContentDocumentLinks.size() >0)
                {
                    System.debug('***************************');
                    String contentDocumentId = prod.ContentDocumentLinks.get(0).ContentDocumentId;
                    system.debug(contentDocumentId);
                    ContentDocument cd = contentDocumentsMap.get(contentDocumentId);

                    if(cd != null) {
                        system.debug(cd);
                        if(cd.ContentVersions != null) {
                            system.debug(cd.ContentVersions);
                            system.debug(cd.COntentVersions.size());
                            if(cd != null && cd.ContentVersions != null && cd.ContentVersions.size() >0) {
                                ContentVersion cv = cd.ContentVersions.get(0);
                                detail.Product_Image_Reference__c = cv.Id;
                            }
                            else{
                                detail.Product_Image_Reference__c = null;
                            }
                        }else{
                            detail.Product_Image_Reference__c = null;
                        }
                    }
                    else{
                        detail.Product_Image_Reference__c = null;
                    }
                }
                else{
                    detail.Product_Image_Reference__c = null;
                }
            }
        }
        // onTransactionDetailTriggerHandler.blockTriggerMap.put('updateDetailImage','updateDetailImage');
    }
    //PN20190121 update picture on transactionDetail END

    //PN20190121 accountId on transactionDetail
    // public static void updateAccountId(List<Transaction_Detail__c> details){

    //  // if(onTransactionDetailTriggerHandler.blockTriggerMap.get('updateAccountId') != null)
    //  //  return;

    //  Set<String> transId = new Set<String>();
    //  for(Transaction_Detail__c detail : details) {
    //      transId.add(detail.Transaction__c);
    //  }

    //  Map<String,Transaction__c> relatedTransactions = new Map<String,Transaction__c>();
    //  relatedTransactions = new Map<String,Transaction__c>(
    //      [
    //          SELECT Id,Account__c
    //          FROM Transaction__c
    //          WHERE Id IN: transId
    //      ]

    //      );

    //  for(Transaction_Detail__c detail : details) {
    //      Transaction__c trans = relatedTransactions.get(detail.Transaction__c);
    //      detail.Account__c = (trans != null) ? trans.Account__c : null;
    //  }

    //  // onTransactionDetailTriggerHandler.blockTriggerMap.put('updateAccountId','updateAccountId');

    // }
    //PN20190121 update accountId on transactionDetail END




}