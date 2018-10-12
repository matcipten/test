global with sharing class Schedule_Batch_ResetKPIOnAccount Implements Database.Batchable<SObject>, Database.Stateful, Schedulable{
    public Boolean testMode = false;
    String Query;
    List<Id> accountids = new List<Id>();
    // Query --SELECT Id FROM Account Where Importo_Totale_Acquisti__c != null AND Id Not In (Select Account__c From Transaction__c) 
    
    global Schedule_Batch_ResetKPIOnAccount(){
        Query = 'SELECT Id, '
            +'Preferred_shipping_country__c,'
            +'Data_Primo_Acquisto__c,'
            +'Data_Ultimo_Acquisto__c,'
            +'Importo_Totale_Acquisti__c,'
            +'Importo_Totale_Acquisti_BRL__c,'
            +'Importo_Totale_Acquisti_CAD__c,'
            +'Importo_Totale_Acquisti_CHF__c,'
            +'Importo_Totale_Acquisti_CNY__c,'
            +'Importo_Totale_Acquisti_EUR__c,'
            +'Importo_Totale_Acquisti_GBP__c,'
            +'Importo_Totale_Acquisti_HKD__c,'
            +'Importo_Totale_Acquisti_JPY__c,'
            +'Importo_Totale_Acquisti_USD__c,'
            +'N_Scontrini__c,'
            +'Sconto_Medio__c,'
            +'Sconto_Medio_BRL__c,'
            +'Sconto_Medio_CAD__c,'
            +'Sconto_Medio_CHF__c,'
            +'Sconto_Medio_CNY__c,'
            +'Sconto_Medio_EUR__c,'
            +'Sconto_Medio_GBP__c,'
            +'Sconto_Medio_HKD__c,'
            +'Sconto_Medio_JPY__c,'
            +'Sconto_Medio_USD__c,'
            +'Totale_Pezzi_Acquistati__c,'
            +'Numero_capi_resi__c,'
            +'Numero_acquisti_con_sconto__c,'
            +'Numero_Store_di_acquisto__c,'
            +'Importo_totale_Resi__c,'
            +'Importo_totale_Resi_BRL__c,'
            +'Importo_totale_Resi_CAD__c,'
            +'Importo_totale_Resi_CHF__c,'
            +'Importo_totale_Resi_CNY__c,'
            +'Importo_totale_Resi_EUR__c,'
            +'Importo_totale_Resi_GBP__c,'
            +'Importo_totale_Resi_HKD__c,'
            +'Importo_totale_Resi_JPY__c,'
            +'Importo_totale_Resi_USD__c,'
            +'Importo_Acquisti_ultimi_6_mesi__c,'
            +'Importo_Acquisti_ultimi_6_12_mesi__c,'
            +'Importo_acquisti_ultima_stagione__c,'
            +'Importo_acquisti_ultima_stagione_BRL__c,'
            +'Importo_acquisti_ultima_stagione_CAD__c,'
            +'Importo_acquisti_ultima_stagione_CHF__c,'
            +'Importo_acquisti_ultima_stagione_CNY__c,'
            +'Importo_acquisti_ultima_stagione_EUR__c,'
            +'Importo_acquisti_ultima_stagione_GBP__c,'
            +'Importo_acquisti_ultima_stagione_HKD__c,'
            +'Importo_acquisti_ultima_stagione_JPY__c,'
            +'Importo_acquisti_ultima_stagione_USD__c,'
            +'Numero_Acquisti_ultime_2_stagioni__c,'
            +'Importo_Totale_Acquisti_DOS__c,'
            +'Importo_Totale_Acquisti_BPS__c,'
            +'Importo_Totale_Acquisti_Ecommerce__c,'
            +'Totale_Pezzi_Acquistati_Ultimi_12_Mesi__c,'
            +'Totale_Pezzi_Acquistati_Ultima_Stagione__c,'
            +'Importo_acquisti_ultimi_24_mesi__c,'
            +'Importo_acquisti_ultimi_36_mesi__c,'
            +'Data_Primo_Acquisto_E_commerce__c,'
            +'Data_ultimo_acquisto_E_commerce__c,'
            +'Importo_Acquisti_E_commerce__c,'
            +'Importo_Acquisti_E_commerce_BRL__c,'
            +'Importo_Acquisti_E_commerce_CAD__c,'
            +'Importo_Acquisti_E_commerce_CHF__c,'
            +'Importo_Acquisti_E_commerce_CNY__c,'
            +'Importo_Acquisti_E_commerce_EUR__c,'
            +'Importo_Acquisti_E_commerce_GBP__c,'
            +'Importo_Acquisti_E_commerce_HKD__c,'
            +'Importo_Acquisti_E_commerce_JPY__c,'
            +'Importo_Acquisti_E_commerce_USD__c,'
            +'N_Ordini_E_commerce__c,'
            +'Sconto_Medio_E_commerce__c,'
            +'Sconto_Medio_E_commerce_BRL__c,'
            +'Sconto_Medio_E_commerce_CAD__c,'
            +'Sconto_Medio_E_commerce_CHF__c,'
            +'Sconto_Medio_E_commerce_CNY__c,'
            +'Sconto_Medio_E_commerce_EUR__c,'
            +'Sconto_Medio_E_commerce_GBP__c,'
            +'Sconto_Medio_E_commerce_HKD__c,'
            +'Sconto_Medio_E_commerce_JPY__c,'
            +'Sconto_Medio_E_commerce_USD__c,'
            +'Totale_pezzi_acquistati_Ecommerce__c,'
            +'Numero_Capi_Resi_E_commerce__c,'
            +'Numero_acquisti_con_sconto_E_commerce__c,'
            +'Importo_totale_Resi_E_commerce__c,'
            +'Importo_totale_Resi_E_commerce_BRL__c,'
            +'Importo_totale_Resi_E_commerce_CAD__c,'
            +'Importo_totale_Resi_E_commerce_CHF__c,'
            +'Importo_totale_Resi_E_commerce_CNY__c,'
            +'Importo_totale_Resi_E_commerce_EUR__c,'
            +'Importo_totale_Resi_E_commerce_GBP__c,'
            +'Importo_totale_Resi_E_commerce_HKD__c,'
            +'Importo_totale_Resi_E_commerce_JPY__c,'
            +'Importo_totale_Resi_E_commerce_USD__c,'
            +'Importo_acquisti_ultima_stagione_E_comm__c,'
            +'Importo_acquisti_ultima_stg_E_comm_BRL__c,'
            +'Importo_acquisti_ultima_stg_E_comm_CAD__c,'
            +'Importo_acquisti_ultima_stg_E_comm_CHF__c,'
            +'Importo_acquisti_ultima_stg_E_comm_CNY__c,'
            +'Importo_acquisti_ultima_stg_E_comm_EUR__c,'
            +'Importo_acquisti_ultima_stg_E_comm_GBP__c,'
            +'Importo_acquisti_ultima_stg_E_comm_HKD__c,'
            +'Importo_acquisti_ultima_stg_E_comm_JPY__c,'
            +'Importo_acquisti_ultima_stg_E_comm_USD__c '
            +'FROM Account ';
        
    }
    
    global void execute(SchedulableContext SC) {
        if(!this.testMode){
            Schedule_Batch_ResetKPIOnAccount accountsToBeProcessed = new Schedule_Batch_ResetKPIOnAccount();
            ID batchprocessid = Database.executeBatch(accountsToBeProcessed, 100 );     
        }
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        
        this.Query += this.Testmode ? ' limit 10 ' : ' Where Importo_Totale_Acquisti__c != null AND Id Not In (Select Account__c From Transaction__c) ';
        System.debug('Query: ' + Query);
        return Database.getQueryLocator(Query);
    }
    
    global void execute(Database.BatchableContext BC,List<Account> listAccount){
        System.debug('listAccount: ' + listAccount);
        system.debug('listAccount size : ' + listAccount.size());
        
        for(Account acc : listAccount) {
            accountids.add(acc.Id);
            acc.Preferred_shipping_country__c = 	null;
            acc.Data_Primo_Acquisto__c = 	null;
            acc.Data_Ultimo_Acquisto__c = 	null;
            acc.Importo_Totale_Acquisti__c = 	null;
            acc.Importo_Totale_Acquisti_BRL__c = 	null;
            acc.Importo_Totale_Acquisti_CAD__c = 	null;
            acc.Importo_Totale_Acquisti_CHF__c = 	null;
            acc.Importo_Totale_Acquisti_CNY__c = 	null;
            acc.Importo_Totale_Acquisti_EUR__c = 	null;
            acc.Importo_Totale_Acquisti_GBP__c = 	null;
            acc.Importo_Totale_Acquisti_HKD__c = 	null;
            acc.Importo_Totale_Acquisti_JPY__c = 	null;
            acc.Importo_Totale_Acquisti_USD__c = 	null;
            acc.N_Scontrini__c = 	null;
            acc.Sconto_Medio__c = 	null;
            acc.Sconto_Medio_BRL__c = 	null;
            acc.Sconto_Medio_CAD__c = 	null;
            acc.Sconto_Medio_CHF__c = 	null;
            acc.Sconto_Medio_CNY__c = 	null;
            acc.Sconto_Medio_EUR__c = 	null;
            acc.Sconto_Medio_GBP__c = 	null;
            acc.Sconto_Medio_HKD__c = 	null;
            acc.Sconto_Medio_JPY__c = 	null;
            acc.Sconto_Medio_USD__c = 	null;
            acc.Totale_Pezzi_Acquistati__c = 	null;
            acc.Numero_capi_resi__c = 	null;
            acc.Numero_acquisti_con_sconto__c = 	null;
            acc.Numero_Store_di_acquisto__c = 	null;
            acc.Importo_totale_Resi__c = 	null;
            acc.Importo_totale_Resi_BRL__c = 	null;
            acc.Importo_totale_Resi_CAD__c = 	null;
            acc.Importo_totale_Resi_CHF__c = 	null;
            acc.Importo_totale_Resi_CNY__c = 	null;
            acc.Importo_totale_Resi_EUR__c = 	null;
            acc.Importo_totale_Resi_GBP__c = 	null;
            acc.Importo_totale_Resi_HKD__c = 	null;
            acc.Importo_totale_Resi_JPY__c = 	null;
            acc.Importo_totale_Resi_USD__c = 	null;
            acc.Importo_Acquisti_ultimi_6_mesi__c = 	null;
            acc.Importo_Acquisti_ultimi_6_12_mesi__c = 	null;
            acc.Importo_acquisti_ultima_stagione__c = 	null;
            acc.Importo_acquisti_ultima_stagione_BRL__c = 	null;
            acc.Importo_acquisti_ultima_stagione_CAD__c = 	null;
            acc.Importo_acquisti_ultima_stagione_CHF__c = 	null;
            acc.Importo_acquisti_ultima_stagione_CNY__c = 	null;
            acc.Importo_acquisti_ultima_stagione_EUR__c = 	null;
            acc.Importo_acquisti_ultima_stagione_GBP__c = 	null;
            acc.Importo_acquisti_ultima_stagione_HKD__c = 	null;
            acc.Importo_acquisti_ultima_stagione_JPY__c = 	null;
            acc.Importo_acquisti_ultima_stagione_USD__c = 	null;
            acc.Numero_Acquisti_ultime_2_stagioni__c = 	null;
            acc.Importo_Totale_Acquisti_DOS__c = 	null;
            acc.Importo_Totale_Acquisti_BPS__c = 	null;
            acc.Importo_Totale_Acquisti_Ecommerce__c = 	null;
            acc.Totale_Pezzi_Acquistati_Ultimi_12_Mesi__c = 	null;
            acc.Totale_Pezzi_Acquistati_Ultima_Stagione__c = 	null;
            acc.Importo_acquisti_ultimi_24_mesi__c = 	null;
            acc.Importo_acquisti_ultimi_36_mesi__c = 	null;
            acc.Data_Primo_Acquisto_E_commerce__c = 	null;
            acc.Data_ultimo_acquisto_E_commerce__c = 	null;
            acc.Importo_Acquisti_E_commerce__c = 	null;
            acc.Importo_Acquisti_E_commerce_BRL__c = 	null;
            acc.Importo_Acquisti_E_commerce_CAD__c = 	null;
            acc.Importo_Acquisti_E_commerce_CHF__c = 	null;
            acc.Importo_Acquisti_E_commerce_CNY__c = 	null;
            acc.Importo_Acquisti_E_commerce_EUR__c = 	null;
            acc.Importo_Acquisti_E_commerce_GBP__c = 	null;
            acc.Importo_Acquisti_E_commerce_HKD__c = 	null;
            acc.Importo_Acquisti_E_commerce_JPY__c = 	null;
            acc.Importo_Acquisti_E_commerce_USD__c = 	null;
            acc.N_Ordini_E_commerce__c = 	null;
            acc.Sconto_Medio_E_commerce__c = 	null;
            acc.Sconto_Medio_E_commerce_BRL__c = 	null;
            acc.Sconto_Medio_E_commerce_CAD__c = 	null;
            acc.Sconto_Medio_E_commerce_CHF__c = 	null;
            acc.Sconto_Medio_E_commerce_CNY__c = 	null;
            acc.Sconto_Medio_E_commerce_EUR__c = 	null;
            acc.Sconto_Medio_E_commerce_GBP__c = 	null;
            acc.Sconto_Medio_E_commerce_HKD__c = 	null;
            acc.Sconto_Medio_E_commerce_JPY__c = 	null;
            acc.Sconto_Medio_E_commerce_USD__c = 	null;
            acc.Totale_pezzi_acquistati_Ecommerce__c = 	null;
            acc.Numero_Capi_Resi_E_commerce__c = 	null;
            acc.Numero_acquisti_con_sconto_E_commerce__c = 	null;
            acc.Importo_totale_Resi_E_commerce__c = 	null;
            acc.Importo_totale_Resi_E_commerce_BRL__c = 	null;
            acc.Importo_totale_Resi_E_commerce_CAD__c = 	null;
            acc.Importo_totale_Resi_E_commerce_CHF__c = 	null;
            acc.Importo_totale_Resi_E_commerce_CNY__c = 	null;
            acc.Importo_totale_Resi_E_commerce_EUR__c = 	null;
            acc.Importo_totale_Resi_E_commerce_GBP__c = 	null;
            acc.Importo_totale_Resi_E_commerce_HKD__c = 	null;
            acc.Importo_totale_Resi_E_commerce_JPY__c = 	null;
            acc.Importo_totale_Resi_E_commerce_USD__c = 	null;
            acc.Importo_acquisti_ultima_stagione_E_comm__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_BRL__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_CAD__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_CHF__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_CNY__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_EUR__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_GBP__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_HKD__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_JPY__c = 	null;
            acc.Importo_acquisti_ultima_stg_E_comm_USD__c = 	null;
        }
        
        update listAccount;
        
        
    }
    
    global void finish(Database.BatchableContext BC){
        
        System.debug('BATCH: finish');
        System.debug('Reset KPI on : ' + accountids.size() + ' :  Accounts');
        System.debug('Reset KPI on : ' + accountids + ' :  Accounts');
        System.debug('Reset KPI on : ' + Limits.getHeapSize() + ' :  Heap Size');
    }
}