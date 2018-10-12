@isTest
private class OnAccountTriggerHandlerTest {

    static testMethod void ManageSlaveTest() {

	/*        
	Test for: 
		- CreateSlaveAssociation method
		- CreateSlaveMap method
	*/        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            Account a1 	= new Account();
            a1.LastName = 'TestLastName1';
            insert a1;

            Account a2 	= new Account();
            a2.LastName = 'TestLastName2';
            insert a2;
            
            Map_Slave__c ms = [Select id, Account__c from Map_Slave__c where Account__c =: a1.id];
            
            ms.Account__c = a2.Id;
            update ms;
            
            delete a1;
            
        }
        Test.stopTest();
        
    }
    
    //RELATE TEST
    @isTest static void test_relate_insertUpdate() {
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        string ProfileId = UserInfo.getProfileId();
        system.debug('ProfileId: ' + ProfileId);
        User u =AllDataFactory.create_UserWithProfile(ProfileId);
        insert u;
        
        // Create the responses in the wrong sequence
        String response = '<?xml version="1.0" ?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"><S:Body><ns2:addOrUpdateCustomerResponse xmlns:ns2="http://v2_3.customer.webservices.csx.dtv.com/"><customerId>260112</customerId></ns2:addOrUpdateCustomerResponse></S:Body></S:Envelope>';
                    
        Test.startTest();
        System.runAs(u){
            
            // Set mock callout class 
            Test.setMock(HttpCalloutMock.class, new OnAccountTriggerHandlerMockImpl(response, 200));
            
            req.requestURI =    '/test/relate'; 
            req.httpMethod = 'POST';
            
            
            RestContext.response= res;
            RestContext.request = req;
            
            Account a1 	= new Account();
            a1.LastName = 'TestLastName1';
            insert a1;
            
            a1.FirstName = 'TestFirstName1';
            update a1;
         
        }
        Test.stopTest();
    }
    
}