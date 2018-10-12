@isTest
private class RestMultiTenderTest {
  
    @isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            req.requestURI =    '/MultiTender_v1.0/'; 
            req.httpMethod = 'POST';
            
            WebService_Settings__c cs= new WebService_Settings__c(Name='General');
            cs.TenderDetailPostRecordLimit__c = 50;
            cs.TransactionDetailPostRecordLimit__c = 50;
            cs.OMS_Endpoint__c = 'http://46.30.169.234:8084/dispatch/tickets/oms/close';
            cs.OMS_Enviroment__c = '';
            cs.OMS_Task_Parameter__c = 'ticket';
            insert cs;
            
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
            Transaction__c c = new Transaction__c();
            c.Account__c = customer.Id;
            insert c;
            
            Tender__c t = new Tender__c();
            t.Transaction__c = c.Id;
            
            Tender__c t1 = new Tender__c();
            t1.Transaction__c = c.Id;
            //insert t;
            
            List<Tender__c> l = new List<Tender__c>{t, t1};
                RestMultiTender.ListWrapper w = new RestMultiTender.ListWrapper(l);
            
            String j = JSON.serialize(w);
            
            RestContext.response= res;
            RestContext.request = req;
            req.requestBody = Blob.valueOf(j);
            
            ResponseWrapper rw = RestMultiTender.doPost();
            
            System.debug(rw);
            
        }
        Test.stopTest();
    }
    
}