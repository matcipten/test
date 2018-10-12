public abstract class ProvaHandler {

    public abstract String getObjectName();
    public abstract Boolean beforeInsert(SObject obj);
    public abstract SObject afterInsert(SObject obj);
    public abstract SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj);
    public abstract ResponseWrapper afterUpdateResponse(RestRequest req,  RestResponse res, SObject obj);
    public abstract Object get(RestRequest req,  RestResponse res);


    public ResponseWrapper doPostHandler(SObject obj){
        return handlePost(obj);
    }

    public ResponseWrapper doPatchHandler(SObject obj){
        return handlePatch(obj);
    }

    public ResponseWrapper doGetHandler(RestRequest req,  RestResponse res){
        return handleGet(req, res);
    }

    private ResponseWrapper handlePost(SObject obj){
        
        DateTime startTime = System.now();
         
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new SingleResponseWrapper();
        
        try {
        
            Boolean hasToInsert = beforeInsert(obj);

            if(hasToInsert){
                insert obj;
            }

            result = createSuccessResult(afterInsert(obj));
           
            res.statusCode = 201;
            
            DateTime endTime = System.now();
            
            System.debug('Time(millisec) for creation ' + (endTime.getTime() - startTime.getTime()) );
         
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


    private ResponseWrapper handlePatch(SObject obj){
        
        DateTime startTime = System.now();
         
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new SingleResponseWrapper();
        ResponseWrapper responseWrapper;

        try {
        
            SObject s = beforeUpdate(req, res, obj);

            System.debug('Updating ' + s);
            System.debug('Updating getSobjectType ' + s.getSobjectType());

            update s;
           
            //res.statusCode = 204;
            res.statusCode = 200;
            
            DateTime endTime = System.now();
            
            System.debug('Time(millisec) for PATCH ' + (endTime.getTime() - startTime.getTime()) );
                
            responseWrapper = afterUpdateResponse(req, res, s);    

            System.debug('responseWrapper:' + responseWrapper);
            
        }catch(ResourceException ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 404;
            responseWrapper = createErrorResult(ex.code, ex.getMessage());
            
        }catch(DMLException ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 400;
            responseWrapper = createErrorResult(Label.ERR_0003, ex.getMessage());
            
        }catch(Exception ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 500;
            responseWrapper = createErrorResult(Label.ERR_0001, ex.getMessage());
        }
        
        return responseWrapper;
    }

    private  ResponseWrapper handleGet(RestRequest req,  RestResponse res) { 
        System.debug('WEBSERVICE - Get');
        
        DateTime startTime = System.now();
        Map<String, String> params = req.params;
        ResponseWrapper responseWrapper;
        
        String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;
        
        try {

            Object result = get(req, res);

            if(result == null){
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Record non trovato');
            }

           responseWrapper = createSuccessResult(result);
           
           DateTime endTime = System.now();
            
           System.debug('Time(millisec) for get ' + (endTime.getTime() - startTime.getTime()) );
            
            
        }catch(ResourceException ex){
            system.debug('Exception ' + ex);
            system.debug('Message ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 404;
            responseWrapper = createErrorResult(ex.code, ex.getMessage());
            
        }catch(DMLException ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 400;
            responseWrapper = createErrorResult(Label.ERR_0003, ex.getMessage());
            
        }catch(Exception ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 500;
            responseWrapper = createErrorResult(Label.ERR_0001, ex.getMessage());
        }
        
        return responseWrapper;
    }


    protected ResponseWrapper createErrorResult(String code, String message){
        SingleResponseWrapper result = new SingleResponseWrapper();
        result.success = false;
        result.errors = new List<ErrorWrapper>();
        
        ErrorWrapper ew = new ErrorWrapper();
        ew.code = code;
        ew.description = message;
        
        result.errors.add(ew);
        
        return result;
    }
    
     protected ResponseWrapper createSuccessResult(SObject member){
        SingleResponseWrapper result = new SingleResponseWrapper();
        result.message = Label.MSG_SUCCESS;
        result.success = true;
        result.data = new Map<String, SObject>();
        result.data.put(getObjectName(), member);
        
        return result;
    }


     protected ResponseWrapper createSuccessResult(Object member){
        SingleObjectResponseWrapper result = new SingleObjectResponseWrapper();
        result.message = Label.MSG_SUCCESS;
        result.success = true;
        result.data = new Map<String, Object>();
        result.data.put(getObjectName(), member);
        
        return result;
    }



}