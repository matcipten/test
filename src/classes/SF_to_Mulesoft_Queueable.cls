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
            Map<String, Object> mbody = (Map<String, Object>) JSON.deserializeUntyped(body);    
            Map<String,Object> p = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(mbody.get('PayLoad')));
            String idmdm= (String)p.get('Id_Cliente_MDM__c');
            if(log.Source__c== 'POST' && idmdm==null){
                System.debug('VS id mdm nullo per l\'account: '+log.AccountID__c);
                REST_Salesforce_to_Mulesoft.doPostSync(body);
            }else{
                REST_Salesforce_to_Mulesoft.doPutSync(body);
            }
            if(log.Source__c== 'POST' && idmdm!=null){
                System.debug('VS id mdm popolato per l\'account: '+log.AccountID__c);
                log.Success__c=true;
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