@isTest
private class RestTransactionTest {
    
    
    @isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            req.requestURI =    '/Transaction_v1.0/'; 
            req.httpMethod = 'POST';
            
            
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
            Transaction__c c = new Transaction__c();
            c.Account__c = customer.Id;
            //insert c;
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTransaction.doPost(c);
            
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
            
            req.requestURI =    '/Transaction_v1.0/' + c.Id; 
            req.httpMethod = 'GET';
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTransaction.doGet();
            
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
            
            req.requestURI =    '/Transaction_v1.0/' + c.Id; 
            req.httpMethod = 'PATCH';
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTransaction.doPatch(c);
            
            System.debug(rw);
            
        }
        Test.stopTest();
    }
    
    @isTest static void test_postError() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            req.requestURI =    '/Transaction_v1.0/'; 
            req.httpMethod = 'POST';
            
            
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
            Transaction__c c = new Transaction__c();
            c.Account__c = customer.Id;
            //insert c;
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTransaction.doPost(null);
            
            System.debug(rw);
            
        }
        Test.stopTest();
    }
    
    @isTest static void test_getError() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI =    '/Transaction_v1.0/null'; 
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestTransaction.doGet();
        
        System.debug(rw);
    }
    
    
    @isTest static void test_patchError() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI =    '/Transaction_v1.0/null'; 
        req.httpMethod = 'PATCH';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestTransaction.doPatch(null);
        
        System.debug(rw);
    }
    
}