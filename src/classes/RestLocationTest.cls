@isTest
private class RestLocationTest {
    
    @isTest static void test_get() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        Location__c c = new Location__c();
        c.Id_Location_Micros__c = '123456789';
        insert c;

        req.requestURI =    '/Location_v1.0/123456789'; 
        req.httpMethod = 'GET';

        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = RestLocation.doGet();
        
        System.debug(rw);
    }

@isTest static void test_get1() {
    new RestLocation.RestLocationHandler().beforeUpdate(null, null, null);
    new RestLocation.RestLocationHandler().afterUpdateResponse(null, null, null);
    new RestLocation.RestLocationHandler().beforeInsert(null);
    new RestLocation.RestLocationHandler().afterInsert(null);
}
}