@RestResource(urlMapping='/Associated_v1.0/*')
global without sharing class RestAssociated{


    /*
    @HttpPost
    global static ResponseWrapper doPost(Associated__c associated) {
        return new RestAssociatedHandler().doPostHandler(associated);
    }
    */

    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestAssociatedHandler().doGetHandler(RestContext.request, RestContext.response);
    }

    /*
    @HttpPatch
    global static ResponseWrapper doPatch(Associated__c associated) {
        return new RestAssociatedHandler().doPatchHandler(associated);
    }
    */

    public static Associated__c getAssociatedById(String id){
        return (Associated__c)GenericDao.getAllFieldsResultById('Associated__c', 'Id_Associate__c', id);
    }


    public class RestAssociatedHandler extends ProvaHandler{
        public Override Object get(RestRequest req,  RestResponse res){
            String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

            Associated__c a = RestAssociated.getAssociatedById(id);
            Map<String, Object> m = a == null ? null : a.getPopulatedFieldsAsMap();

            return m;
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

        public Override String getObjectName(){
            return 'associated';
        }
    }



}