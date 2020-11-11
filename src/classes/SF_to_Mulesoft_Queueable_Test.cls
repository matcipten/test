@istest
public class SF_to_Mulesoft_Queueable_Test {
    public class MockHttpResponseGeneratorPos implements HttpCalloutMock {
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest req) {
            // Optionally, only send a mock response for a specific endpoint
            // and method.
            // System.assertEquals('http://example.com/example/test', req.getEndpoint());
            // System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(200);
            return res;
        }
    }
    @istest
    public static void test(){
        string ProfileId = UserInfo.getProfileId();
        system.debug('ProfileId: ' + ProfileId);
        User u =AllDataFactory.create_UserWithProfile(ProfileId);
        insert u;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorPos());
        String response = '<?xml version="1.0" ?><S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/"><S:Body><ns2:addOrUpdateCustomerResponse xmlns:ns2="http://v2_3.customer.webservices.csx.dtv.com/"><customerId>260112</customerId></ns2:addOrUpdateCustomerResponse></S:Body></S:Envelope>';
        

        Test.startTest();
            System.runAs(u){
                Profile__c profileSettings = AllDataFactory.create_TriggerSetting(u.ProfileId);
                insert profileSettings;
                Mulesoft_Endpoint__c cs = new Mulesoft_Endpoint__c();
                cs.Endpoint__c = 'http://example.com/example/test';
                cs.Username__c = 'testun';
                cs.Password__c = 'testpw';
                insert cs;
                Account a= new Account();
                a.Name ='Test ten';
                insert a;
                SV_Log__c log1 = new SV_Log__c();
                log1.Success__c = false; 
                log1.Source__c = 'POST'; 
                log1.Retry_Attempt__c = false;
                log1.AccountID__c=a.ID;

                SV_Log__c log2 = new SV_Log__c();
                log2.Success__c = false; 
                log2.Source__c = 'PUT'; 
                log2.Retry_Attempt__c = false;
                log2.AccountID__c=a.ID;
                List<SV_Log__c> listLog= new List<SV_Log__c>();
                listLog.add(log1);
                listLog.add(log2);
                insert listLog;
                System.enqueueJob(new SF_to_Mulesoft_Queueable(listLog));
            }
        Test.stopTest();
    }
}