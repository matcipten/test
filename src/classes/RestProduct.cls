@RestResource(urlMapping='/Product_v1.0/*')
global with sharing class RestProduct{

    /*
    @HttpPost
    global static ResponseWrapper doPost(Product__c product) {
        return new RestProductlHandler().doPostHandler(product);
    }
    */

    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestProductlHandler().doGetHandler(RestContext.request, RestContext.response);
    }

    /*
    @HttpPatch
    global static ResponseWrapper doPatch(Product__c product) {
        return new RestProductlHandler().doPatchHandler(product);
    }
    */

    public static Product__c getProductById(String id){
        return (Product__c)GenericDao.getAllFieldsResultById('Product__c', 'Item_ID__c', id);
    }


    public class RestProductlHandler extends ProvaHandler{
        public Override Object get(RestRequest req,  RestResponse res){
            String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

            Product__c a = RestProduct.getProductById(id);
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

             List<Product__c> result = [
                Select m.Id
                From Product__c m
                WHERE Id = :id
            ];
            
            if(result != null && !result.isEmpty()){
                Product__c m = result.get(0); 
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
            return 'product';
        }
    }



}