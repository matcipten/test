@isTest
private class MyApexClassRestNewsletterUnsubscribeTest {

	@isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){

        req.requestURI =    '/NewsletterUnsubscribe_v1.0/'; 
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueOf('{"email" : "asd@asd.asd"}');

        Account a = new Account(
            FirstName = 'name', 
            LastName = 'ln', 
            PersonEmail = 'asd@asd.asd',
            Email_Ecommerce__c = 'asd@asd.asd',
            Id_Cliente_DW__c = '123456789'
            );
        insert a;

        RestContext.response= res;
        RestContext.request = req;
        
        RestNewsletterUnsubscribe.doPut();
            }
        Test.stopTest();
    }

    @isTest static void test_post_error() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){

        req.requestURI =    '/NewsletterUnsubscribe_v1.0/'; 
        req.httpMethod = 'PUT';
        req.requestBody = Blob.valueOf('{"email" : "asd@asd.asd"}');

        Account a = new Account(
            FirstName = 'name', 
            LastName = 'ln', 
            PersonEmail = 'asd@asd.asd',
            Id_Cliente_DW__c = '123456789'
            );
        insert a;

        RestContext.response= res;
        RestContext.request = req;
        
        RestNewsletterUnsubscribe.doPut();
            
                        }
        Test.stopTest();
    }

    @isTest static void test_post_error1() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){

        req.requestURI =    '/NewsletterUnsubscribe_v1.0/'; 
        req.httpMethod = 'PUT';

        Account a = new Account(
            FirstName = 'name', 
            LastName = 'ln', 
            PersonEmail = 'asd@asd.asd',
            Id_Cliente_DW__c = '123456789'
            );
        insert a;

        RestContext.response= res;
        RestContext.request = req;
        
        RestNewsletterUnsubscribe.doPut();
            
                        }
        Test.stopTest();
    }
}