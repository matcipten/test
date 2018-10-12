@RestResource(urlMapping='/MultiTransaction_Detail_v1.0/*')
global without sharing class RestMultiTransactionDetail {

    /*@HttpPost
    global static ResponseWrapper doPost() {
        
        DateTime startTime = System.now();
         
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new ListResponseWrapper();


        System.debug('Request Body:' + req.requestBody);

        Type t = Type.forName('List<Transaction_Detail__c>');

        List<Transaction_Detail__c> x = (List<Transaction_Detail__c>)JSON.deserialize(req.requestBody.toString(), t);

        System.debug('List<Transaction_Detail__c> x:' + x);

        return null;
    }
    */

    
    @HttpPost
    global static ResponseWrapper doPost() {
        
        DateTime startTime = System.now();
         
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new ListResponseWrapper();

        
        try {
            WebService_Settings__c cs = WebService_Settings__c.getValues('General');
            Decimal recordLimit = cs.TransactionDetailPostRecordLimit__c;

             Type t = Type.forName('List<Transaction_Detail__c>');

             //List<Transaction_Detail__c> dettaglioTransazione = (List<Transaction_Detail__c>)JSON.deserialize(req.requestBody.toString(), t);
             ListWrapper wrapper = (ListWrapper)JSON.deserialize(req.requestBody.toString(), ListWrapper.class);
             List<Transaction_Detail__c> dettaglioTransazione = wrapper.dettaglioTransazione;

             System.debug('dettaglioTransazione: ' + dettaglioTransazione);

            if(dettaglioTransazione == null){
                throw new GenericException(Label.ERR_0003, 'No Records found in request payload.');
            }

            if(dettaglioTransazione.size() > recordLimit){
                throw new GenericException(Label.ERR_0003, 'Record Limit has been reached for creation operation.');
            }

            for(Transaction_Detail__c td : dettaglioTransazione){
                CurrencyUtils.convertCurrency(td);
            }

            insert dettaglioTransazione;

            result = createSuccessResult(dettaglioTransazione);
           
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
        global List<Transaction_Detail__c> dettaglioTransazione{get;set;}

        public ListWrapper(List<Transaction_Detail__c> l){
            this.dettaglioTransazione = l;
        }
    }
    
}