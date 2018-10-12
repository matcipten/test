@isTest
private class RestProductTest {
    
@isTest static void test_get() {
    RestRequest req = new RestRequest();
    RestResponse res = new RestResponse();

    Product__c c = new Product__c();
    insert c;

    req.requestURI =    '/Product_v1.0/' + c.Id; 
    req.httpMethod = 'GET';

    RestContext.response= res;
    RestContext.request = req;
    
    ResponseWrapper rw = RestProduct.doGet();
    
    System.debug(rw);
}

@isTest static void test_get1() {
    new RestProduct.RestProductlHandler().beforeUpdate(null, null, null);
    new RestProduct.RestProductlHandler().afterUpdateResponse(null, null, null);
    new RestProduct.RestProductlHandler().beforeInsert(null);
    new RestProduct.RestProductlHandler().afterInsert(null);
}


}