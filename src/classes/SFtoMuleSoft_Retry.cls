public class SFtoMuleSoft_Retry {
    @AuraEnabled
    public static String doRetry(){
        Mulesoft_Endpoint__c mce = Mulesoft_Endpoint__c.getInstance();
        List<SV_Log__c> logList;
        if(mce.LIMIT__c!= null){
            String query= 'SELECT Id, Name, Input_Payload__c, Output_Payload__c, Source__c, Status__c, Success__c,  Retry_Attempt__c,AccountID__c FROM SV_Log__c WHERE Success__c = false AND Retry_Attempt__c = false Order by Source__c LIMIT '+mce.LIMIT__c;
            logList = Database.query(query);
        }else{
            logList = [SELECT Id, Name, Input_Payload__c, Output_Payload__c, Source__c, Status__c, Success__c,  Retry_Attempt__c,AccountID__c
                                    FROM SV_Log__c
                                    WHERE Success__c = false AND Retry_Attempt__c = false
                                    Order by Source__c ];
        }

        
        ID jobID = System.enqueueJob(new SF_to_Mulesoft_Queueable(logList));
        return 'abc';
    }

}