@RestResource(urlMapping='/MTM/V1/Misure/*')
global without sharing class Rest_MTM_MisureCustomer {
    
    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestMisureCustomerHandler().doGetHandler(RestContext.request, RestContext.response);
    }
    
    @HttpPost
    global static ResponseWrapper doPost(MisureWrapper misure) { 
        Account_Misure_Sartoriali__c misureData = new Account_Misure_Sartoriali__c();
        misureData = misure.data;
        List<AttachWrapper> attach = new List<AttachWrapper>();
        attach = misure.attachments;
        
        return new RestMisureCustomerHandler().doPostHandlerWrapper(misure.step, misure.profilo , misureData, attach);
    }
    
    public static List<Account_Misure_Sartoriali__c> getMisureCustomerById(String accountId){
        
        List<Account_Misure_Sartoriali__c> result = new List<Account_Misure_Sartoriali__c>();
        result = GenericDao.getAllFieldsListResultById('Account_Misure_Sartoriali__c', 'Account__c', accountId);
        return result;
        
    }
    
    public class RestMisureCustomerHandler extends Rest_MTM_CalloutHandler{
        
        public Override Object get(RestRequest req,  RestResponse res){
            
            String reqUri = req.requestURI.substring(1);
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String version = arr[1];
            String objects = arr[2];
            String accountId = arrSize > 3 ? arr[3] : null;
            String relatedResource = arrSize > 4 ? arr[4] : null;
            String idRelatedResource = arrSize > 5 ? arr[5] : null;
            
            List<Account_Misure_Sartoriali__c> misureAccountList = RestMisureCustomerHandler.getMisureCustomerById(accountId);
            
            return misureAccountList;
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
            return 'Account_Misure_Sartoriali__c';
        }
    }
    global class MisureWrapper {
        
      public String step;
      public String profilo;
      public Account_Misure_Sartoriali__c data;
      public List<AttachWrapper> attachments;
               
    }
    global class AttachWrapper {
        
     public String format;
     public string type;   
     public String attachment;
         
    }
    
    //MC- wrapper for attachments data returned by the POST
    global class returnedAttachment {
        public string Name;
        public string Id;
    } 
    
    
}