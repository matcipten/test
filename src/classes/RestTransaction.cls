@RestResource(urlMapping='/Transaction_v1.0/*')
global without sharing class RestTransaction  {


    @HttpPost
    global static ResponseWrapper doPost(Transaction__c transazione) {
        return new RestTransactionHandler().doPostHandler(transazione);
    }

    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestTransactionHandler().doGetHandler(RestContext.request, RestContext.response);
    }

    @HttpPut
    global static ResponseWrapper doPatch(Transaction__c transazione) {
        return new RestTransactionHandler().doPatchHandler(transazione);
    }

    public static Transaction__c getTransactionById(String id){
        return (Transaction__c)GenericDao.getAllFieldsResultById('Transaction__c', 'Key__c', id);
    }


    public class RestTransactionHandler extends ProvaHandler{
        public Override Object get(RestRequest req,  RestResponse res){
            String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;

            Transaction__c a = RestTransaction.getTransactionById(id);
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

             List<Transaction__c> result = [
                Select m.Id
                From Transaction__c m
                WHERE Id = :id
            ];
            
            if(result != null && !result.isEmpty()){
                Transaction__c m = result.get(0); 
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
            Transaction__c t = (Transaction__c)obj;
            String accountId = t.Account__c;

            if(!String.isBlank(t.Voided_SequenceNumber__c) && 
                !String.isBlank(t.Voided_RetailStoreID__c) &&
                !String.isBlank(t.Voided_WorkstationID__c)){
                System.debug('Skip transaction saving. This is a voided transaction.');
                // transazione di annullamento. Non deve essere salvata
                return false;
            }

            SObject a = RestAccount.getMember(accountId);

            if(a == null){
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Account__c');
            }
            
            String objectType = a.getSobjectType().getDescribe().getName();

             if(a != null && objectType == 'Account'){
                System.debug('Saving transaction:' + obj);

            } else if (a != null && objectType == 'Slave_Data__c'){

                obj.put('Account__c', a.get('Master_Record_Id__c'));
                System.debug('Saving transaction:' + obj);
            }

            return true;
        }

        public Override SObject afterInsert(SObject obj){
            Transaction__c t = (Transaction__c)obj;
            String key = t.Voided_SequenceNumber__c + t.Voided_RetailStoreID__c + t.Voided_WorkstationID__c;
            Boolean isVoided = !String.isBlank(t.Voided_SequenceNumber__c) && 
                !String.isBlank(t.Voided_RetailStoreID__c) &&
                !String.isBlank(t.Voided_WorkstationID__c);



            if(!isVoided){
                return obj;
            }

            System.debug('Key to update:' + key);    

            List<Transaction__c> l = [
                Select PostVoidReasonCode__c, 
                PostVoidComment__c, 
                Voided_BusinessDayDate__c, 
                Voided_SequenceNumber__c, 
                Voided_RetailStoreID__c, 
                Voided_WorkstationID__c
                from Transaction__c 
                where Key__c = :key
            ];

            if(l != null && !l.isEmpty()){
                Transaction__c m = l.get(0); 

                m.PostVoidReasonCode__c 	= t.PostVoidReasonCode__c;
                m.PostVoidComment__c 		= t.PostVoidComment__c;
                m.Voided_BusinessDayDate__c = t.Voided_BusinessDayDate__c;
                m.Voided_SequenceNumber__c 	= t.Voided_SequenceNumber__c;
                m.Voided_RetailStoreID__c 	= t.Voided_RetailStoreID__c;
                m.Voided_WorkstationID__c 	= t.Voided_WorkstationID__c;

                System.debug('Aggiorno transazione: ' + m);

                update m;
                
                // TEN@2017-12-20 (SALESFORCE-74)
                
                list<Transaction_Detail__c> listVoidDetail 			= new list<Transaction_Detail__c>();
                list<Transaction_Detail__c> listVoidDetailToUpdate 	= new list<Transaction_Detail__c>();
                
                listVoidDetail = [	select id, CurrencyIsoCode  
                					from Transaction_Detail__c 
                					where Transaction__c =:m.id];
                
                if(listVoidDetail.size()>0){
                
                	for(Transaction_Detail__c td:listVoidDetail){
                	
                		td.Prezzo_di_Listino__c = 0;
                		td.Prezzo_di_Vendita__c = 0;
                		td.Quantita__c			= 0;
                		
                		CurrencyUtils.convertCurrency(td);
                		
                		listVoidDetailToUpdate.add(td);
                	
                	}
                	
                	if(listVoidDetailToUpdate.size()>0){
                		update listVoidDetailToUpdate;
                	}          
                
                }
                
                // TEN@2017-12-20 (SALESFORCE-74)
                
                
            } else {
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Key__c');
            }

            return null;
        }

        public Override String getObjectName(){
            return 'transazione';
        }
    }



}