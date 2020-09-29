global class BatchCreateContactDeleteRequest implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute

        String q='SELECT Id FROM Contact WHERE ';
        MC_Sync__c mcs = MC_Sync__c.getInstance();
        q+=mcs.Filtro_Contatti__c;
        if(mcs.Delta__c){
            q+=(' '+mcs.Delta_Time__c);
        }
        if(Test.isRunningTest()){
            q+=(' LIMIT 100');
        }
        return Database.getQueryLocator(q); 

    }
    global void execute(Database.BatchableContext bc, List<Contact> records){
        // process each batch of records
        List<Contact_Delete_Request__c> cdrList= new List<Contact_Delete_Request__c>();
        for(Contact c: records){
            Contact_Delete_Request__c cdr = new Contact_Delete_Request__c();
            cdr.Contact_Key__c=c.Id;
            cdrList.add(cdr);
            
        }
        System.debug('VS insert size batch: '+cdrList.size());
        insert cdrList;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        if(!Test.isRunningTest()){
            Database.executeBatch(new BatchCreateContactDeleteRequestFromSlave());
        }
    }    
}