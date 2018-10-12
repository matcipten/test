@RestResource(urlMapping='/Location_v1.0/*')
global without sharing class RestLocation{

    /*
    @HttpPost
    global static ResponseWrapper doPost(Location__c location) {
        return new RestLocationHandler().doPostHandler(location);
    }
    */

    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestLocationHandler().doGetHandler(RestContext.request, RestContext.response);
    }

    /*
    @HttpPatch
    global static ResponseWrapper doPatch(Location__c location) {
        return new RestLocationHandler().doPatchHandler(location);
    }
    */

    public static Location__c getLocationById(String id){
        return (Location__c)GenericDao.getAllFieldsResultById('Location__c', 'Id_Location_Micros__c', id);
    }


    public class RestLocationHandler extends ProvaHandler{
        public Override Object get(RestRequest req,  RestResponse res){
            String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

            Location__c a = RestLocation.getLocationById(id);
            Map<String, Object> m = a == null ? null : a.getPopulatedFieldsAsMap();

            return m;
        }

        public Override SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj){
            return obj;
             /*String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

             List<Location__c> result = [
                Select m.Id
                From Location__c m
                WHERE Id = :id
            ];
            
            if(result != null && !result.isEmpty()){
                Location__c m = result.get(0); 
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
            return 'location';
        }
    }



}