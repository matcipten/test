@RestResource(urlMapping='/NewsletterUnsubscribe_v1.0/*')
global without sharing class RestNewsletterUnsubscribe {

    @HttpPut
    global static ResponseWrapper doPut() {
        
        DateTime startTime = System.now();
         
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        ResponseWrapper result = new ListResponseWrapper();

        
        try {
            List<Account> acc2Update = new List<Account>();
        	List<Account> acc2Return = new List<Account>();
            //WebService_Settings__c cs = WebService_Settings__c.getValues('General');
            //Decimal recordLimit = cs.NewsletterUnsubscribeRecordLimit__c;

            ListWrapper wrapper = (ListWrapper)JSON.deserialize(req.requestBody.toString(), ListWrapper.class);

            if(wrapper == null){
                throw new GenericException(Label.ERR_0003, 'No request payload found.');
            }

             String email = wrapper.email;

             //System.debug('listaMail: ' + listaMail);

            //if(listaMail == null){
            //    throw new GenericException(Label.ERR_0003, 'No Records found in request payload.');
            //}

            if(String.isEmpty(email)){
                throw new ResourceException(Label.ERR_0003, 'No Mail found in request payload.');
            }

            //Set<String> mailSet = new Set<String>(listaMail);

            //mailSet.remove(null);
            //mailSet.remove('');

            //System.debug('mailSet ' + mailSet);

            //if(mailSet.size() == 0){
            //    throw new GenericException(Label.ERR_0003, 'No Records found in request payload.');
            //}

            //if(mailSet.size() > recordLimit){
            //    throw new GenericException(Label.ERR_0003, 'Record Limit has been reached for newsletter unsubscribe.');
            //}

            List<Account> accs = [select id, Newsletter__c, Data_Cancellazione_Newsletter__c
                    from Account where Email_Ecommerce__c != null and Email_Ecommerce__c = :email];

            if(accs == null || accs.isEmpty()){
                throw new ResourceException(Label.ERR_0003, 'No Customers found with email ' + email);
            }                    

			for(Account a : accs){
				a.Newsletter__c = false;
				a.Data_Cancellazione_Newsletter__c = System.today();
				acc2Update.add(a);
                acc2Return.add(new Account(id = a.id));
			}
			
            System.debug('acc2Update ' + acc2Update);

			if(!acc2Update.isEmpty()){
				update acc2Update;
			}

            result = createSuccessResult(acc2Return);
           
            res.statusCode = 200;
            
            DateTime endTime = System.now();
            
            System.debug('Time(millisec) for creation ' + (endTime.getTime() - startTime.getTime()) );
         
         }catch(ResourceException ex){
            system.debug('Eccezione ' + ex.getMessage());
            system.debug('StackString ' + ex.getStackTraceString());
            
            res.statusCode = 404;
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
    
    /* private static ResponseWrapper createSuccessResult(Set<String> ids){
        SingleResponseWrapper result = new SingleResponseWrapper();
        result.success = true;
        result.message = 'Success';
        result.data = ids;
        
        return result;
    } */

    private static ResponseWrapper createSuccessResult(List<Sobject> l){
        ListResponseWrapper result = new ListResponseWrapper();
        result.success = true;
        result.message = 'Success';
        result.data = l;
        result.totalSize = l.size();
        result.page = 1;
        result.pageSize = l.size(); 
        
        return result;
    }

    global class ListWrapper{
        global String email{get;set;}

        public ListWrapper(String l){
            this.email = l;
        }
    }
    


}