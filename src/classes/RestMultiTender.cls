@RestResource(urlMapping='/MultiTender_v1.0/*')
global without sharing class RestMultiTender {

    @HttpPost
    global static ResponseWrapper doPost() {
        
        DateTime startTime = System.now();
         
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new ListResponseWrapper();

        
        try {
          WebService_Settings__c cs = WebService_Settings__c.getValues('General');
      Decimal recordLimit = cs.TenderDetailPostRecordLimit__c;

             Type t = Type.forName('List<Tender__c>');

             ListWrapper wrapper = (ListWrapper)JSON.deserialize(req.requestBody.toString(), ListWrapper.class);
             List<Tender__c> tenders = wrapper.tenders;

             System.debug('tender: ' + tenders);

      if(tenders == null){
        throw new GenericException(Label.ERR_0003, 'No Records found in request payload.');
      }

      if(tenders.size() > recordLimit){
        throw new GenericException(Label.ERR_0003, 'Record Limit has been reached for creation operation.');
      }

            insert tenders;

            result = createSuccessResult(tenders);
           
            res.statusCode = 201;
            
            DateTime endTime = System.now();
            
            System.debug('Time(millisec) for creation ' + (endTime.getTime() - startTime.getTime()) );
         
         }catch(GenericException ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 400;
            result = createErrorResult(ex.code, ex.getMessage());
             
        }catch(DMLException ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 400;
            result = createErrorResult(Label.ERR_0003, ex.getMessage());
            
        }catch(Exception ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 500;
            result = createErrorResult(Label.ERR_0001, ex.getMessage());
        }
        
        return result;
  }

  private static ResponseWrapper createErrorResult(String code, String message){
        SingleResponseWrapper result = new SingleResponseWrapper();
        result.success = false;
        result.errors = new List<ErrorWrapper>();
        
        ErrorWrapper ew = new ErrorWrapper();
        ew.code = code;
        ew.description = message;
        
        result.errors.add(ew);
        
        return result;
    }
    
     private static ResponseWrapper createSuccessResult(List<SObject> l){
        ListResponseWrapper result = new ListResponseWrapper();
        result.message = Label.MSG_SUCCESS;
        result.success = true;
        result.totalSize = l.size();
        result.page = 1;
        result.pageSize = 20;
        result.data = l;
        
        return result;
    }

    global class ListWrapper{
        global List<Tender__c> tenders{get;set;}

        public ListWrapper(List<Tender__c> l){
            this.tenders = l;
        }
    }
  
}