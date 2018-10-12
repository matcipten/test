@isTest
private class RestCreditTest {
    
    @isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){

        req.requestURI =    '/Credit_v1.0/'; 
        req.httpMethod = 'POST';
        

        Account customer = new Account();
        customer.LastName = 'Brambilla';
        insert customer;

         Credit__c c = new Credit__c();
        c.Account__c = customer.Id;
        //insert c;
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestCredit.doPost(c);
        
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

        Credit__c c = new Credit__c();
        c.Account__c = customer.Id;
        insert c;

        req.requestURI =    '/Credit_v1.0/' + c.Id; 
        req.httpMethod = 'GET';

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestCredit.doGet();
        
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

        Credit__c c = new Credit__c();
        c.Account__c = customer.Id;
        insert c;

        req.requestURI =    '/Credit_v1.0/' + c.Id; 
        req.httpMethod = 'PATCH';

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestCredit.doPatch(c);
        
        System.debug(rw);
            
        }
        Test.stopTest();
    }

}