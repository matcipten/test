@isTest
public class Rest_MTM_UserTest {
    
      @isTest static void test_Get(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
              
        
        req.requestURI =    '/MTM/V1/User/'+u.Id; 
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = Rest_MTM_User.doGet();
        
        System.debug(rw);
    }
    
     @isTest static void test_get1() {
            new Rest_MTM_User.RestUserHandler().beforeUpdate(null, null, null);
            new Rest_MTM_User.RestUserHandler().afterUpdateResponse(null, null, null);
            new Rest_MTM_User.RestUserHandler().beforeInsert(null);
            new Rest_MTM_User.RestUserHandler().afterInsert(null);
         	new Rest_MTM_User.RestUserHandler().afterInsertUpdate(null);
        }

}