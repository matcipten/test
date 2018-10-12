public abstract class Rest_MTM_CalloutHandler {
    
    public abstract String getObjectName();
    public abstract Boolean beforeInsert(SObject obj);
    public abstract SObject afterInsert(SObject obj);
    public abstract SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj);
    public abstract ResponseWrapper afterUpdateResponse(RestRequest req,  RestResponse res, SObject obj);
    public abstract Object get(RestRequest req,  RestResponse res);
    public abstract SObject afterInsertUpdate(SObject obj);
    
    public static Boolean isFirstTimeForAfter = true;
    public static Boolean isFirstTimeForBefore = true;
    
    public ResponseWrapper doGetHandler(RestRequest req,  RestResponse res){
        return handleGet(req, res);
    }
    
    public ResponseWrapper doPostHandler(SObject obj){
        return handlePost(obj);
    }
    
    public ResponseWrapper doPostHandlerWrapper(String step, SObject obj){
        system.debug('SObject: ' + obj);
        
        return handlePostWrapper(step, obj);
    }
    
    public ResponseWrapper doPostHandlerWrapper(String step, String sarto, SObject obj, List<Rest_MTM_MisureCustomer.AttachWrapper> attachments){
        system.debug('SObject: ' + obj);
        
        return handlePostWrapper(step, sarto, obj, attachments);
    }
    public ResponseWrapper doPatchHandler(SObject obj){
        return handlePatch(obj);
    }
    
    private  ResponseWrapper handleGet(RestRequest req,  RestResponse res) { 
        System.debug('WEBSERVICE - GET');
        
        DateTime startTime = System.now();
        Map<String, String> params = req.params;
        ResponseWrapper responseWrapper;
        
        String reqUri = req.requestURI.substring(1);
        
        String[] arr = reqUri.split('\\/');
        Integer arrSize = arr.size();
        String service = arr[0];
        String version = arr[1];
        String type = arr[2];
        String id = arrSize > 3 ? arr[3] : null;
        String relatedResource = arrSize > 4 ? arr[4] : null;
        String idRelatedResource = arrSize > 5 ? arr[5] : null;
        
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
    
    private ResponseWrapper handlePost(SObject obj){
        System.debug('WEBSERVICE - POST');
        System.debug('obj: ' + obj);
        
        DateTime startTime = System.now();
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new SingleResponseWrapper();
        
        
        Map<String, String> params = req.params;
        
        system.debug('params: ' + params);
        
        String reqUri = req.requestURI.substring(1);
        
        String[] arr = reqUri.split('\\/');
        Integer arrSize = arr.size();
        String service = arr[0];
        String version = arr[1];
        String type = arr[2];
        String id = arrSize > 3 ? arr[3] : null;
        String relatedResource = arrSize > 4 ? arr[4] : null;
        String idRelatedResource = arrSize > 5 ? arr[5] : null;
        
        try {
            
            Boolean hasToInsert = beforeInsert(obj);
            
            if(hasToInsert){
                //insert obj;
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
    
    private ResponseWrapper handlePostWrapper(String step, SObject obj){
        System.debug('WEBSERVICE - POST');
        System.debug('obj : '+ obj);
        DateTime startTime = System.now();
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new SingleResponseWrapper();
        
        
        Map<String, String> params = req.params;
        
        String reqUri = req.requestURI.substring(1);
        
        String[] arr = reqUri.split('\\/');
        Integer arrSize = arr.size();
        String service = arr[0];
        String version = arr[1];
        String type = arr[2];
        String id = arrSize > 3 ? arr[3] : null;
        String relatedResource = arrSize > 4 ? arr[4] : null;
        String idRelatedResource = arrSize > 5 ? arr[5] : null;
        
        try {
            
            
            if(step == 'I'){
                Boolean hasToInsert = beforeInsert(obj);
                
                if(hasToInsert){
                    insert obj;
                }
                
                result = createSuccessResult(afterInsertUpdate(obj));
                
                res.statusCode = 200;
            } else {
                
                SObject s = beforeUpdate(req, res, obj);
                
                System.debug('Updating ' + s);
                System.debug('Updating getSobjectType ' + s.getSobjectType());
                
                update s;
                
                //res.statusCode = 204;
                res.statusCode = 200;
                
                result = createSuccessResult(afterInsertUpdate(s));
                
            }
            
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
    private ResponseWrapper handlePostWrapper(String step ,String profilo ,SObject obj,List<Rest_MTM_MisureCustomer.AttachWrapper> attachments){
        System.debug('WEBSERVICE - POST');
        //System.debug('obj : '+ obj);
        //System.debug('profilo : '+ profilo);
        DateTime startTime = System.now();
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new SingleResponseWrapper();
        
        
        Map<String, String> params = req.params;
        
        String reqUri = req.requestURI.substring(1);
        
        String[] arr = reqUri.split('\\/');
        Integer arrSize = arr.size();
        String service = arr[0];
        String version = arr[1];
        String type = arr[2];
        String id = arrSize > 3 ? arr[3] : null;
        String relatedResource = arrSize > 4 ? arr[4] : null;
        String idRelatedResource = arrSize > 5 ? arr[5] : null;
        
        try {
            
            Id ossId = (Id)obj.get('Ordine_Sartoria_Solomeo__c');
            //ordineSS name is used in attachments name
            Ordine_Sartoria_Solomeo__c ordineSS = [SELECT Name FROM Ordine_Sartoria_Solomeo__c WHERE Id =: ossId  LIMIT 1];
            //MC- Overwrite attachment of type pdf or pdf_client  2018.08.02 #Start
            List<Attachment> attachmentList = new List<Attachment>();
            List<Attachment> attachSFList = new List<Attachment>();
            List<Attachment> attachPdfSFList = new List<Attachment>();
            List<Attachment> attachPdfClientSFList = new List<Attachment>();
            boolean pdfSFtodelete = false;
            boolean pdfclientSFtodelete = false;
            if(attachments != null){
                attachSFList = [SELECT Id,Name FROM Attachment WHERE ParentId =:ossId];	//MC- 2018.08.02
                if(attachSFList != null && attachSFList.size() > 0){
                    for(Attachment attachSF :attachSFList){
                        if(attachSF.Name.startsWithIgnoreCase('pdf_' + ordineSS.Name)){
                            attachPdfSFList.add(attachSF);
                        }else if(attachSF.Name.startsWithIgnoreCase('pdf_cliente_' + ordineSS.Name)){
                            attachPdfClientSFList.add(attachSF);
                        }
                    }                    
                }
            }
            system.debug('MC- attachPdfSFList.size: ' + attachPdfSFList.size());
            system.debug('MC- attachPdfClientSFList.size: ' + attachPdfClientSFList.size());
            //MC- Overwrite attachment of type pdf or pdf_client #End
            if(step == 'I'){
                Boolean hasToInsert = beforeInsert(obj);
                system.debug('hasToInsert : ' + hasToInsert);
                system.debug('obj : ' + obj);
                if(hasToInsert){
                    insert obj;
                    // Object nameVal =  obj.get('Name');
                }
                
                //result = createSuccessResult(afterInsertUpdate(obj)); //MC- Remmed
                
                if(attachments != null){
                    integer count = 0;
                    for(Rest_MTM_MisureCustomer.AttachWrapper attachRest : attachments){
                        if(!String.isEmpty(attachRest.attachment)){
                            if(!pdfSFtodelete){
                            	pdfSFtodelete = (attachRest.type == 'pdf' && attachPdfSFList.size() > 0) ? true : false;	//MC- 2018.08.02
                            }
                            if(!pdfclientSFtodelete){
                            	pdfclientSFtodelete = (attachRest.type == 'pdf_client' && attachPdfClientSFList.size() > 0) ? true : false;	//MC- 2018.08.02
                            }
                            Blob myBlob = Blob.valueOf(attachRest.attachment);
                            Attachment attach = new Attachment();
                            attach.contentType = (attachRest.format == 'pdf') ? 'application/'+attachRest.format  : 'image/'+ +attachRest.format;
                            if(attachRest.format != 'pdf'){
                            	attach.name =  attachRest.type + '_' + ordineSS.Name + '_' + Datetime.now().format('yy_MM_dd_HH.mm.ss') + '_' + string.valueOf(count) +'.'+attachRest.format;
                            	count += 1;
                            }else{
                               attach.name =  attachRest.type + '_' + ordineSS.Name + '.' + attachRest.format; 
                            }                         
                            attach.parentId = (Id)obj.get('Ordine_Sartoria_Solomeo__c');
                            attach.body = EncodingUtil.base64Decode(attachRest.attachment);
                            attachmentList.add(attach);
                            //insert attach;
                        }
                        
                    }
                }
                
                if(attachmentList.size() > 0 ){
                    insert attachmentList;
                }
                
                //MC- Overwrite attachment of type pdf or pdf_client 
                system.debug('MC- pdfSFtodelete = ' + pdfSFtodelete + ' - pdfclientSFtodelete = ' + pdfclientSFtodelete);
                if(pdfSFtodelete || pdfclientSFtodelete){
                    attachPdfSFList.addAll(attachPdfClientSFList);
                    delete attachPdfSFList;
                }
                
                res.statusCode = 200;
            } else {
                
                if(profilo == 'Sarto' || profilo == 'First Level Approver MTM'){
                    Map<String, Object> fields = obj.getPopulatedFieldsAsMap(); 
                    //system.debug('fields : ' + fields);
                    //system.debug('fields : ' + fields.keySet());
                    
                    String fieldsUsedinMisure = '';
                    
                    for (String fieldName : fields.keySet()) {
                        system.debug('fieldName : ' + fieldName);
                        
                        fieldsUsedinMisure += fieldName + ',';
                    }
                    
                    String newfieldsUsedinMisure =  fieldsUsedinMisure.removeEnd(',');
                    String misureIdCondition = 'Id = \''+ (String)obj.get('Id') + '\'';
                    
                    
                    system.debug('newfieldsUsedinMisure : ' + newfieldsUsedinMisure);
                    
                    SObject misureToCompare = GenericDao.getFieldsResultById('Account_Misure_Sartoriali__c', newfieldsUsedinMisure , misureIdCondition );
                    
                    String toSaveNewValeMisure = '';
                    String toSaveMisuredubbie = '';
                    for(String fieldName : fields.keySet()){
                        
                        if( (fieldName != 'LastModifiedDate' ) && (fieldName != 'Ordine_Sartoria_Solomeo__c' ) && obj.get(fieldName) != misureToCompare.get(fieldName)){
                            system.debug('fieldName : ' +  fieldName); 
                            if(!fieldName.contains('_checkbox')){
                                toSaveNewValeMisure +=  fieldName +' da '+ misureToCompare.get(fieldName) +' a '+ obj.get(fieldName) + ', ';
                            }
                        }else if(fieldName.contains('_checkbox') && (misureToCompare.get(fieldName) == true || obj.get(fieldName) == true)){
                            toSaveMisuredubbie += fieldName + ', ';
                        }
                    }
                    system.debug('toSaveNewValeMisure 1 : ' + toSaveNewValeMisure   );
                    system.debug('toSaveMisuredubbie 1 : ' + toSaveMisuredubbie   );
                    toSaveNewValeMisure =  toSaveNewValeMisure.replaceAll('__c' , ' ');
                    toSaveNewValeMisure = toSaveNewValeMisure.replaceAll('_' , ' ');
                    toSaveNewValeMisure = toSaveNewValeMisure.removeEnd(', ');
                    
                    if(toSaveNewValeMisure.endsWith(',') || toSaveNewValeMisure.endsWith(', ')){
                        toSaveNewValeMisure = toSaveNewValeMisure.removeEnd(', ');
                    }
                    toSaveMisuredubbie =  toSaveMisuredubbie.replaceAll('checkbox__c' , ' ');
                    toSaveMisuredubbie = toSaveMisuredubbie.replaceAll('_' , ' ');
                    toSaveMisuredubbie = toSaveMisuredubbie.removeEnd(', ');
                    
                    if(toSaveMisuredubbie.endsWith(',') || toSaveMisuredubbie.endsWith(', ')){
                        toSaveMisuredubbie = toSaveMisuredubbie.removeEnd(', ');
                    }
                    
                    
                    system.Debug('toSaveNewValeMisure : ' + toSaveNewValeMisure);
                    obj.put('New_values__c' , toSaveNewValeMisure) ;
                    obj.put('Misure_dubbie__c' , toSaveMisuredubbie) ;
                }else{
                    obj.put('New_values__c' , '') ;
                }
                SObject s = beforeUpdate(req, res, obj);
                
                System.debug('Updating ' + s);
                System.debug('Updating getSobjectType ' + s.getSobjectType());
                
                update s;
                
                if(attachments != null){
                    integer count = 0;
                    for(Rest_MTM_MisureCustomer.AttachWrapper attachRest : attachments){
                        if(!String.isEmpty(attachRest.attachment)){
                            if(!pdfSFtodelete){
                            	pdfSFtodelete = (attachRest.type == 'pdf' && attachPdfSFList.size() > 0) ? true : false;	//MC- 2018.08.02
                            }
                            if(!pdfclientSFtodelete){
                            	pdfclientSFtodelete = (attachRest.type == 'pdf_client' && attachPdfClientSFList.size() > 0) ? true : false;	//MC- 2018.08.02
                            }
                            Blob myBlob = Blob.valueOf(attachRest.attachment);
                            Attachment attach = new Attachment();
                            attach.contentType = (attachRest.format == 'pdf') ? 'application/'+attachRest.format  : 'image/'+ +attachRest.format;
                            if(attachRest.format != 'pdf'){
                            	attach.name =  attachRest.type + '_' + ordineSS.Name + '_' + Datetime.now().format('yy_MM_dd_HH.mm.ss') + '_' + string.valueOf(count) +'.'+attachRest.format;
                            	count +=1;
                            }else{
                               attach.name =  attachRest.type + '_' + ordineSS.Name + '.' + attachRest.format; 
                            } 
                            attach.parentId = (Id)obj.get('Ordine_Sartoria_Solomeo__c');
                            attach.body = EncodingUtil.base64Decode(attachRest.attachment);
                            attachmentList.add(attach);
                        }
                        
                    }
                }
                
                if(attachmentList.size() > 0 ){
                    insert attachmentList;
                }
                
                //MC- Overwrite attachment of type pdf or pdf_client 
                system.debug('MC- pdfSFtodelete = ' + pdfSFtodelete + ' - pdfclientSFtodelete = ' + pdfclientSFtodelete);
                if(pdfSFtodelete || pdfclientSFtodelete){
                    attachPdfSFList.addAll(attachPdfClientSFList);
                    delete attachPdfSFList;
                }
                
                //res.statusCode = 204;
                res.statusCode = 200;
                /*
                // PN 20180803 add attachmentList
                // maybe could be better use wrapper classes
                
                Map<String,Object> tempObj = (Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(obj));
                
                //Map<String,String> test = new Map<String,String>();
                //MC-
                List<Rest_MTM_MisureCustomer.returnedAttachment> attachList = new List<Rest_MTM_MisureCustomer.returnedAttachment>();
                for(Attachment a : attachmentList){
                	//test.put(a.Name,a.Id);
                	Rest_MTM_MisureCustomer.returnedAttachment att = new Rest_MTM_MisureCustomer.returnedAttachment();
                    att.Name = a.Name;
                    att.Id = a.Id;
                    attachList.add(att);
                }
                
                //tempObj.put('attachments',test);
                tempObj.put('sentAttachments',attachList);
                
                // END PN 20180803 add attachmentList
                
                result = createSuccessResult(tempObj);
                
                //result = createSuccessResult(afterInsertUpdate(s));
                */
            }
            
            //MC- Start 
            // PN 20180803 add attachmentList
            // maybe could be better use wrapper classes                
            Map<String,Object> tempObj = (Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(obj));               
            //Map<String,String> test = new Map<String,String>();
            //MC-
            List<Rest_MTM_MisureCustomer.returnedAttachment> attachList = new List<Rest_MTM_MisureCustomer.returnedAttachment>();
            if(attachmentList != null && attachmentList.size() > 0){
                for(Attachment a : attachmentList){
                    //test.put(a.Name,a.Id);
                    Rest_MTM_MisureCustomer.returnedAttachment att = new Rest_MTM_MisureCustomer.returnedAttachment();
                    att.Name = a.Name;
                    att.Id = a.Id;
                    attachList.add(att);
                }               
                //tempObj.put('attachments',test);
                tempObj.put('sentAttachments',attachList);
            }
            // END PN 20180803 add attachmentList    
            result = createSuccessResult(tempObj);       
            //MC- END
            
            
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
        System.debug('WEBSERVICE - PATCH');
        
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