@isTest
private class RestAccountTest {
    
    @isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI =    '/Customer_v1.0/'; 
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');

        Account customer = new Account();
        customer.LastName = 'Brambilla';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAccount.doPost(customer);
        
        System.debug(rw);
    }

    @isTest static void test_get() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
       

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
            insert profileSettings;
        Account customer = new Account();
        customer.LastName = 'Brambilla';
        insert customer;

        req.requestURI =    '/Customer_v1.0/' + customer.Id; 
        req.httpMethod = 'GET';

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAccount.doGet();
        
        System.debug(rw);
            }
        Test.stopTest();
    }

    @isTest static void test_getAS400() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;

        Account customer = new Account();
        customer.LastName = 'Brambilla';
        customer.Id_Cliente__c = 'Id_Cliente__c';
        insert customer;

        req.requestURI =    '/Customer_v1.0/Id_Cliente__c'; 
        req.httpMethod = 'GET';
        req.addParameter('ou', 'a');
        //req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAccount.doGet();
        
        System.debug(rw);
            }
        Test.stopTest();
    }

    @isTest static void test_getIdEcommerce() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
       

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
            insert profileSettings;
        Account customer = new Account();
        customer.LastName = 'Brambilla';
        customer.Id_Cliente_DW__c = 'Id_Cliente_DW__c';
        insert customer;

        req.requestURI =    '/Customer_v1.0/Id_Cliente_DW__c'; 
        req.httpMethod = 'GET';
        req.addParameter('ou', 'e');
        //req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAccount.doGet();
        
        System.debug(rw);
            }
        Test.stopTest();
    }

    @isTest static void test_getIdEcommerceError() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        User usr = AllDataFactory.create_User();
        insert usr;
        
        

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        Account customer = new Account();
        customer.LastName = 'Brambilla';
        customer.Id_Cliente_DW__c = 'Id_Cliente_DW__c';
        insert customer;

        req.requestURI =    '/Customer_v1.0/Id_Cliente_DW__c?ou=e'; 
        req.httpMethod = 'GET';
        //req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAccount.doGet();
        
        System.debug(rw);
            }
        Test.stopTest();
    }

    @isTest static void test_getIdExtXStore() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        User usr = AllDataFactory.create_User();
        insert usr;
        
        

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        Account customer = new Account();
        customer.LastName = 'Brambilla';
        customer.Id_Cliente_xStore__c = 'Id_Cliente_xStore__c';
        insert customer;

        req.requestURI =    '/Customer_v1.0/Id_Cliente_xStore__c'; 
        req.httpMethod = 'GET';
        req.addParameter('ou', 'x');
        //req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAccount.doGet();
        
        System.debug(rw);
             }
        Test.stopTest();
    }


    @isTest static void test_getIdMDM() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        User usr = AllDataFactory.create_User();
        insert usr;
        
        

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        Account customer = new Account();
        customer.LastName = 'Brambilla';
        customer.Id_Cliente_MDM__c = 'Id_Cliente_MDM__c';
        insert customer;

        req.requestURI =    '/Customer_v1.0/Id_Cliente_MDM__c'; 
        req.httpMethod = 'GET';
        req.addParameter('ou', 'm');
        //req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAccount.doGet();
        
        System.debug(rw);
             }
        Test.stopTest();
    }    

    @isTest static void test_patch() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        User usr = AllDataFactory.create_User();
        insert usr;
        
        

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        Account customer = new Account();
        customer.LastName = 'Brambilla';
        insert customer;

        customer.FirstName = 'Giovanni';

        req.requestURI =    '/Customer_v1.0/' + customer.Id; 
        req.httpMethod = 'PATCH';

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAccount.doPatch(customer);
        
        System.debug(rw);
            }
        Test.stopTest();
    }

    @isTest static void test_copyFromAccountToSlave() {

        User usr = AllDataFactory.create_User();
        insert usr;
        
       

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
            insert profileSettings;
        Account customer = new Account();
        customer.LastName = 'Brambilla';
        insert customer;

        Slave_Data__c slave = new Slave_Data__c();

        slave = RestAccount.copyFromAccountToSlave(customer);

        Test.stopTest();
        }
    }


    @isTest static void test_convertSlaveToMap() {

        User usr = AllDataFactory.create_User();
        insert usr;
        
        

        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        Account customer = new Account();
        customer.LastName = 'Brambilla';
        insert customer;

        Slave_Data__c slave = new Slave_Data__c();
        slave.LastName__c = 'Brambilla';


        Map<String, Object> m = new Map<String, Object>();

        m = RestAccount.convertSlaveToMap(slave);

        Test.stopTest();
        }
    }

}