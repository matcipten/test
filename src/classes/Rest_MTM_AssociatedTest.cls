@isTest
public class Rest_MTM_AssociatedTest {
    
    @isTest static void test_Get(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Location__c c = new Location__c();
        insert c;
        
        
        Associated__c t = new Associated__c();
        t.Id_Associate_Micros__c = '123456789';
        t.Location__c = c.Id;
        insert t;
        
        req.requestURI =    '/MTM/V1/Associated/'+u.Id; 
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = Rest_MTM_Associated.doGet();
        
        System.debug(rw);
    }
    
     @isTest static void test_get1() {
            new Rest_MTM_Associated.RestAssociatedHandler().beforeUpdate(null, null, null);
            new Rest_MTM_Associated.RestAssociatedHandler().afterUpdateResponse(null, null, null);
            new Rest_MTM_Associated.RestAssociatedHandler().beforeInsert(null);
            new Rest_MTM_Associated.RestAssociatedHandler().afterInsert(null);
        }

    
}