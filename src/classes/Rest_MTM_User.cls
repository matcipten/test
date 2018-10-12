@RestResource(urlMapping='/MTM/V1/User/*')
global without sharing class Rest_MTM_User {
    
    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestUserHandler().doGetHandler(RestContext.request, RestContext.response);
    }
    
    public static List<User> getUserById(String userId){
        
        List<User> result = new List<User>();
        result = GenericDao.getAllFieldsListResultById('User', 'Id', userId);
        return result;
        
    }
    
    public class RestUserHandler extends Rest_MTM_CalloutHandler{
        
        public Override Object get(RestRequest req,  RestResponse res){
            
            String reqUri = req.requestURI.substring(1);
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String version = arr[1];
            String objects = arr[2];
            String userId = arrSize > 3 ? arr[3] : null;
            String relatedResource = arrSize > 4 ? arr[4] : null;
            String idRelatedResource = arrSize > 5 ? arr[5] : null;

            List<User> userList = RestUserHandler.getUserById(userId);

            return userList;
        }
        
        public Override SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj){
            return obj;
        }

        public Override ResponseWrapper afterUpdateResponse(RestRequest req,  RestResponse res, SObject obj){
            return null;
        }

        public Override Boolean beforeInsert(SObject obj){
            return true;
        }

        public Override SObject afterInsert(SObject obj){
            return obj;
        }
        
        public Override SObject afterInsertUpdate(SObject obj){
            return obj;
        }

        public Override String getObjectName(){
            return 'user';
        }
    }

}