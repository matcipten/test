@RestResource(urlMapping='/Tender_v1.0/*')
global without sharing class RestTender{


    @HttpPost
    global static ResponseWrapper doPost(Tender__c tender) {
        return new RestTenderlHandler().doPostHandler(tender);
    }

    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestTenderlHandler().doGetHandler(RestContext.request, RestContext.response);
    }

    @HttpPut
    global static ResponseWrapper doPatch(Tender__c tender) {
        return new RestTenderlHandler().doPatchHandler(tender);
    }

    public static Tender__c getTenderById(String id){
        return (Tender__c)GenericDao.getAllFieldsResultById('Tender__c', 'Key__c', id);
    }


    public class RestTenderlHandler extends ProvaHandler{
        public Override Object get(RestRequest req,  RestResponse res){
            String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

            Tender__c a = RestTender.getTenderById(id);
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

             List<Tender__c> result = [
                Select m.Id
                From Tender__c m
                WHERE Id = :id
            ];
            
            if(result != null && !result.isEmpty()){
                Tender__c m = result.get(0); 
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
            return 'tender';
        }
    }



}