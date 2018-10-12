@RestResource(urlMapping='/MTM/V1/Customer/*')
global without sharing class Rest_MTM_Customer {
    
    @HttpGet
    global static ResponseWrapper doGet(){
        return new RestCustomerHandler().doGetHandler(RestContext.request , RestContext.response);
    }
    
    public static List<CustomerWrapper> getAccountsFromParam(String param){
        
        List<List<sObject>> resultAccount = new List<List<sObject>>();
        List<CustomerWrapper> finList = new List<CustomerWrapper>();
        List<String> childList = new List<String>{ 'Account_Misure_Sartoriali__c' };
        List<String> childList2 = new List<String>{ 'Ordine_Sartoria_Solomeo__c' };
            system.debug('param : ' +param );
        
        resultAccount = GenericDao.getAllFieldsListWithParam('Account', param);
        Set<Id> setAccount = new Set<Id>();
        for(List<Account> accList : resultAccount){
            for(Account acc : accList){
                setAccount.add(acc.Id);
            }
        }
        List<Account_Misure_Sartoriali__c> allMisure = new List<Account_Misure_Sartoriali__c>();
        List<Ordine_Sartoria_Solomeo__c> allOrdini = new List<Ordine_Sartoria_Solomeo__c>();
        allMisure = GenericDao.getAllFieldsListWhereInConditions('Account_Misure_Sartoriali__c', 'Account__c', setAccount);
        allOrdini = GenericDao.getAllFieldsListWhereInConditionsWithAttachments('Ordine_Sartoria_Solomeo__c', 'Cliente__c', setAccount); //MC-
        system.debug('resultAccount : ' + resultAccount);
        for(List<Account> accList : resultAccount){
            system.debug('acc : ' + accList);
            for(Account acc : accList){
                CustomerWrapper fin = new CustomerWrapper();
                setAccount.add(acc.Id);
                fin.id = acc.Id;
                fin.Name = acc.Name;
                fin.FirstName = acc.FirstName;
                fin.LastName = acc.LastName;
                fin.PersonEmail = acc.PersonEmail;
                fin.Phone = acc.Phone;
                fin.Id_Cliente_Relate = acc.Id_Cliente_Relate__c;
                List<Account_Misure_Sartoriali__c> misureAccount = new List<Account_Misure_Sartoriali__c>();
                for(Account_Misure_Sartoriali__c misura : allMisure){
                    if(misura.Account__c == acc.Id){
                        misureAccount.add(misura);
                    }
                }
                List<Ordine_Sartoria_Solomeo__c> ordineAccount = new List<Ordine_Sartoria_Solomeo__c>();
                for(Ordine_Sartoria_Solomeo__c ordine : allOrdini){
                    if(ordine.Cliente__c == acc.Id){
                        ordineAccount.add(ordine);
                    }
                }
                fin.misure = misureAccount;
                fin.ordini = ordineAccount;
                finList.add(fin);
            }
        }
        
        return finList;
        
    }

    public class RestCustomerHandler extends Rest_MTM_CalloutHandler{
        
        public override Object get(RestRequest req,  RestResponse res){
            
            String reqUri = req.requestURI.substring(1);
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String version = arr[1];
            String objects = arr[2];
            String Id = arrSize > 3 ? arr[3] : null;
            String relatedResource = arrSize > 4 ? arr[4] : null;
            String idRelatedResource = arrSize > 5 ? arr[5] : null;
            
            Map<String, String> params = req.params;
            system.debug('PARAM: ' + params);
            
            List<CustomerWrapper> result = RestCustomerHandler.getAccountsFromParam(params.get('str'));
            
            return result;
            
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
            return 'Customer';
        }
    }
    
    public class CustomerWrapper {
        
       @TestVisible Id Id;
       @TestVisible String Name;
       @TestVisible String FirstName;
       @TestVisible String LastName;
       @TestVisible String PersonEmail;
       @TestVisible String Phone;
       @TestVisible String Id_Cliente_Relate;
        
       @TestVisible List<Account_Misure_Sartoriali__c> misure;
       @TestVisible List<Ordine_Sartoria_Solomeo__c> ordini;
        
    }
    
    public static List<sObject> getAllAccountMisure(String idAccount,  List<String> childList){
        
        List<sObject> resultChild = new List<sObject>();
        
        if(childList != null){
            for(String child : childList){
                resultChild = GenericDao.getAllFieldsListResultById(child, 'Account__c', idAccount);
            }
        }
        
        return resultChild;
    }
    
    public static List<sObject> getAllAccountOrders(String idAccount,  List<String> childList){
        
        List<sObject> resultChild = new List<sObject>();
        
        if(childList != null){
            for(String child : childList){
                resultChild = GenericDao.getAllFieldsListResultById(child, 'Cliente__c', idAccount);
            }
        }
        
        return resultChild;
    }
}