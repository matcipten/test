@isTest
private class RestTransactionDetailTest {
    
    @isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            req.requestURI =    '/TransactionDetail_v1.0/'; 
            req.httpMethod = 'POST';
            
            
            Account customer = new Account();
            customer.LastName = 'Brambilla';
            insert customer;
            
            Transaction__c c = new Transaction__c();
            c.Account__c = customer.Id;
            insert c;
            
            Transaction_Detail__c t = new Transaction_Detail__c();
            t.Transaction__c = c.Id;
            t.CurrencyIsoCode = 'EUR';
            t.Prezzo_di_Vendita__c = 100;
            t.Prezzo_di_Listino__c = 100;
            
            Transaction_Detail__c t1 = new Transaction_Detail__c();
            t1.Transaction__c = c.Id;
            t1.CurrencyIsoCode = 'CHF';
            t.Prezzo_di_Vendita__c = 100;
            t.Prezzo_di_Listino__c = 100;
            //insert t;
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTransactionDetail.doPost(t);
            RestTransactionDetail.doPost(t1);
            
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
            
            Transaction_Detail__c t = new Transaction_Detail__c();
            t.Transaction__c = c.Id;
            insert t;
            
            req.requestURI =    '/TransactionDetail_v1.0/' + t.Id; 
            req.httpMethod = 'GET';
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTransactionDetail.doGet();
            
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
            
            Transaction_Detail__c t = new Transaction_Detail__c();
            t.Transaction__c = c.Id;
            insert t;
            
            req.requestURI =    '/TransactionDetail_v1.0/' + t.Id; 
            req.httpMethod = 'PATCH';
            
            RestContext.response= res;
            RestContext.request = req;
            
            ResponseWrapper rw = RestTransactionDetail.doPatch(t);
            
            System.debug(rw);
            
        }
        Test.stopTest();
    }
    
}