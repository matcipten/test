@RestResource(urlMapping='/Credit_v1.0/*')
global without sharing class RestCredit{


    @HttpPost
    global static ResponseWrapper doPost(Credit__c credit) {
        return new RestCreditlHandler().doPostHandler(credit);
    }

    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestCreditlHandler().doGetHandler(RestContext.request, RestContext.response);
    }

    @HttpPut
    global static ResponseWrapper doPatch(Credit__c credit) {
        return new RestCreditlHandler().doPatchHandler(credit);
    }

    public static Credit__c getCreditById(String id){
        return (Credit__c)GenericDao.getAllFieldsResultById('Credit__c', 'Id', id);
    }


    public class RestCreditlHandler extends ProvaHandler{
        public Override Object get(RestRequest req,  RestResponse res){
            String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

            Credit__c a = RestCredit.getCreditById(id);
            Map<String, Object> m = a == null ? null : a.getPopulatedFieldsAsMap();

            return m;
        }

        public Override SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj){
             String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

             List<Credit__c> result = [
                Select m.Id
                From Credit__c m
                WHERE Id = :id
            ];
            
            if(result != null && !result.isEmpty()){
                Credit__c m = result.get(0); 
                obj.id = m.id;
            } else {
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Id');
            }

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

        public Override String getObjectName(){
            return 'credit';
        }
    }



}