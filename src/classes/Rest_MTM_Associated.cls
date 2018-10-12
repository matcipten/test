@RestResource(urlMapping='/MTM/V1/Associated/*')
global without sharing class Rest_MTM_Associated {
    
    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestAssociatedHandler().doGetHandler(RestContext.request, RestContext.response);
    }
    
    public static List<Associated__c> getAssociatedByUserId(String userId){
        User usr = [Select id, Codice_Boutique__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE id = : userId];
        List<Associated__c> result = new List<Associated__c>();
        if(usr.Nome_Profilo__c == 'BC - Associate'){
            result = GenericDao.getAllFieldsListResultById('Associated__c', 'Id_Associate__c', usr.Codice_Associate__c);
        } else {
            result = GenericDao.getAllFieldsListResultById('Associated__c', 'Id_Location_Micros__c', usr.Codice_Boutique__c);
        }
        return result;
    }
    
    public class RestAssociatedHandler extends Rest_MTM_CalloutHandler{
        
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

            List<Associated__c> assList = RestAssociatedHandler.getAssociatedByUserId(userId);
            
            // ARRAY associativa
            /*
            Map<String, Object> m = new Map<String, Object>();
            for (Associated__c ass : assList){
                m.put(ass.Id, ass); 
            }
			*/
            

            return assList;
        }
        
        public Override SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj){
            return obj;
             /*
             String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

             List<Associated__c> result = [
                Select m.Id
                From Associated__c m
                WHERE Id = :id
            ];
            
            if(result != null && !result.isEmpty()){
                Associated__c m = result.get(0); 
                obj.id = m.id;
            } else {
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Id');
            }
            */
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
            return 'associated';
        }
    }

}