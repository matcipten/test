@isTest
private class RestAssociatedTest {
    
    @isTest static void test_get() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

         Location__c c = new Location__c();
        insert c;


         Associated__c t = new Associated__c();
         t.Id_Associate_Micros__c = '123456789';
         t.Location__c = c.Id;
        insert t;

        req.requestURI =    '/Associated_v1.0/123456789'; 
        req.httpMethod = 'GET';

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestAssociated.doGet();
        
        System.debug(rw);
    }

        @isTest static void test_get1() {
            new RestAssociated.RestAssociatedHandler().beforeUpdate(null, null, null);
            new RestAssociated.RestAssociatedHandler().afterUpdateResponse(null, null, null);
            new RestAssociated.RestAssociatedHandler().beforeInsert(null);
            new RestAssociated.RestAssociatedHandler().afterInsert(null);
        }

    
}