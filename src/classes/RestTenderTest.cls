@isTest
private class RestTenderTest {
    
    
    @isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            req.requestURI =    '/Tender_v1.0/'; 
            req.httpMethod = 'POST';
            
            
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
            Transaction__c c = new Transaction__c();
            c.Account__c = customer.Id;
            insert c;
            
            Tender__c t = new Tender__c();
            t.Transaction__c = c.Id;
            //insert t;
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTender.doPost(t);
            
            System.debug(rw);
            
        }
        Test.stopTest();
    }
    
    @isTest static void test_get() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
            Transaction__c c = new Transaction__c();
            c.Account__c = customer.Id;
            insert c;
            
            Tender__c t = new Tender__c();
            t.Transaction__c = c.Id;
            insert t;
            
            req.requestURI =    '/Tender_v1.0/' + t.Id; 
            req.httpMethod = 'GET';
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTender.doGet();
            
            System.debug(rw);
            
        }
        Test.stopTest();
    }
    
    @isTest static void test_patch() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
            Transaction__c c = new Transaction__c();
            c.Account__c = customer.Id;
            insert c;
            
            Tender__c t = new Tender__c();
            t.Transaction__c = c.Id;
            insert t;
            
            req.requestURI =    '/Tender_v1.0/' + t.Id; 
            req.httpMethod = 'PATCH';
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTender.doPatch(t);
            
            System.debug(rw);
            
        }
        Test.stopTest();
    }
    
}