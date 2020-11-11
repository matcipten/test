public class SF_to_Mulesoft_Queueable implements Queueable, Database.AllowsCallouts {
    List<SV_Log__c> logs;

    public SF_to_Mulesoft_Queueable(List<SV_Log__c> records) {
        this.logs = records;
    }
    public void execute(QueueableContext context) {
        if(logs.size()<=0 || logs==null){
            return;
        }
        SV_Log__c log= logs.remove(0);
        try{
            
            String body= REST_Salesforce_to_Mulesoft.buildPayload(log.AccountID__c);
            if(log.Source__c== 'POST'){
                REST_Salesforce_to_Mulesoft.doPostSync(body);
            }else{
                REST_Salesforce_to_Mulesoft.doPutSync(body);
            }
            log.Retry_Attempt__c=true;
        }catch(Exception e){
            
        }
        // for(SV_Log__c log : this.logs){
        //     try{
        //         String body= REST_Salesforce_to_Mulesoft.buildPayload(log.AccountID__c);
        //         if(log.Source__c== 'POST'){
        //             REST_Salesforce_to_Mulesoft.doPost(body);
        //         }else{
        //             REST_Salesforce_to_Mulesoft.doPut(body);
        //         }
        //         log.Retry_Attempt__c=true;
        //     }catch(Exception e){
                
        //     }
        // }
        update log;
        if(!Test.isRunningTest() && logs.size()>=1){
            ID jobID = System.enqueueJob(new SF_to_Mulesoft_Queueable(logs));
        }
        
    }
}