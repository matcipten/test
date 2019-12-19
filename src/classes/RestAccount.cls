@RestResource(urlMapping='/Customer_v1.0/*')
global without sharing class RestAccount {

    @HttpPost
    global static ResponseWrapper doPost(Account customer) {
        return new RestAccountHandler().doPostHandler(customer);
    }

    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestAccountHandler().doGetHandler(RestContext.request, RestContext.response);
    }

    @HttpPut
    global static ResponseWrapper doPatch(Account customer) {
        return new RestAccountHandler().doPatchHandler(customer);
    }

    public static Map<String, Object> convertSlaveToMap(Slave_Data__c sd){
        Map<String,Object> fieldMap = sd.getPopulatedFieldsAsMap();
        Map<String, Object> m = new Map<String, Object>();

        System.debug('fieldMap ' + fieldMap);

        for(String key : fieldMap.keySet()){

           if(!(key.indexOf('__c') > 0) 
                || key == 'Account__c'
                || key == 'ID_DW_Master__c'
                || key == 'Id_Relate_Master__c'
                || key == 'Id_Xstore_Master__c'
                || key == 'Id_AS400_Master__c'
            ){
                continue;
            }
           
            String accountKey = key == 'FirstName__c' ? 'FirstName' : key;
            accountKey = key == 'LastName__c' ? 'LastName' : accountKey;
            accountKey = key == 'Fax__c' ? 'Fax' : accountKey;
            accountKey = key == 'Phone__c' ? 'Phone' : accountKey;
            accountKey = key == 'ShippingCity__c' ? 'ShippingCity' : accountKey;
            accountKey = key == 'ShippingCountry__c' ? 'ShippingCountry' : accountKey;
            accountKey = key == 'ShippingPostalCode__c' ? 'ShippingPostalCode' : accountKey;
            accountKey = key == 'ShippingState__c' ? 'ShippingState' : accountKey;
            accountKey = key == 'ShippingStreet__c' ? 'ShippingStreet' : accountKey;
            accountKey = key == 'PersonEmail__c' ? 'PersonEmail' : accountKey;
            accountKey = key == 'PersonMailingCity__c' ? 'PersonMailingCity' : accountKey;
            accountKey = key == 'PersonMailingCountry__c' ? 'PersonMailingCountry' : accountKey;
            accountKey = key == 'PersonMailingPostalCode__c' ? 'PersonMailingPostalCode' : accountKey;
            accountKey = key == 'PersonMailingState__c' ? 'PersonMailingState' : accountKey;
            accountKey = key == 'PersonMailingStreet__c' ? 'PersonMailingStreet' : accountKey;
            accountKey = key == 'PersonMobilePhone__c' ? 'PersonMobilePhone' : accountKey;
            accountKey = key == 'PersonOtherPhone__c' ? 'PersonOtherPhone' : accountKey;
            accountKey = key == 'PersonBirthdate__c' ? 'PersonBirthdate' : accountKey;
            accountKey = key == 'Id_Cliente_Salesforce__c' ? 'Id' : accountKey;


            System.debug('accountKey: ' +  accountKey + ' Key: ' + key);
            System.debug('Putting ' +  accountKey + ' to ' + fieldMap.get(key));

            m.put(accountKey, fieldMap.get(key));
        }

        return m;
    }

   public static Slave_Data__c copyFromAccountToSlave(Account a){
        Map<String,Object> fieldMap = a.getPopulatedFieldsAsMap();
        Slave_Data__c sd = new Slave_Data__c();

        for(String key : fieldMap.keySet()){
            if(key == 'Id'){
                continue;
            }

            String sdKey = key == 'FirstName' ? 'FirstName__c' : key;
            sdKey = key == 'LastName' ? 'LastName__c' : sdKey;
            sdKey = key == 'Fax' ? 'Fax__c' : sdKey;
            sdKey = key == 'Phone' ? 'Phone__c' : sdKey;
            sdKey = key == 'ShippingCity' ? 'ShippingCity__c' : sdKey;
            sdKey = key == 'ShippingCountry' ? 'ShippingCountry__c' : sdKey;
            sdKey = key == 'ShippingPostalCode' ? 'ShippingPostalCode__c' : sdKey;
            sdKey = key == 'ShippingState' ? 'ShippingState__c' : sdKey;
            sdKey = key == 'ShippingStreet' ? 'ShippingStreet__c' : sdKey;
            sdKey = key == 'PersonEmail' ? 'PersonEmail__c' : sdKey;
            sdKey = key == 'PersonMailingCity' ? 'PersonMailingCity__c' : sdKey;
            sdKey = key == 'PersonMailingCountry' ? 'PersonMailingCountry__c' : sdKey;
            sdKey = key == 'PersonMailingPostalCode' ? 'PersonMailingPostalCode__c' : sdKey;
            sdKey = key == 'PersonMailingState' ? 'PersonMailingState__c' : sdKey;
            sdKey = key == 'PersonMailingStreet' ? 'PersonMailingStreet__c' : sdKey;
            sdKey = key == 'PersonMobilePhone' ? 'PersonMobilePhone__c' : sdKey;
            sdKey = key == 'PersonOtherPhone' ? 'PersonOtherPhone__c' : sdKey;
            sdKey = key == 'PersonBirthdate' ? 'PersonBirthdate__c' : sdKey;

            sd.put(sdKey, fieldMap.get(key));
        }

        return sd;
    }

     public static SObject getMemberId(Id id){
        SObject a = [
                Select 
                m.Id,
                m.Id_Cliente__c,
                m.Id_Cliente_DW__c,
                m.Id_Cliente_xStore__c,
                m.Master_Record_Id__c
                From Account m
                WHERE m.Id = :id
            ];
            
        return a;
    }
    
    public static SObject getMember(String id){
        SObject a = (Account)GenericDao.getAllFieldsResultById('Account', 'Id', id);

        if(a == null){
            System.debug('Master not found. Searching for slave.');

            Sobject sd = GenericDao.getAllFieldsResultById('Slave_Data__c', 'Id_Cliente_Salesforce__c', id);

            System.debug('Slave is ' + sd);

            return sd;
        }

        return a;
    }
    
    public static SObject getMemberByExtIdAS400(String id){
        SObject a = (Account)GenericDao.getAllFieldsResultById('Account', 'Id_Cliente__c', id);

        if(a == null){
            System.debug('Master not found. Searching for slave.');

            Sobject sd = GenericDao.getAllFieldsResultById('Slave_Data__c', 'Id_Cliente__c', id);

            System.debug('Slave is ' + sd);

            return sd;
        }

        return a;
    }
    
    public static SObject getMemberByExtIdEcommerce(String id){
        SObject a = (Account)GenericDao.getAllFieldsResultById('Account', 'Id_Cliente_DW__c', id);

        if(a == null){
            System.debug('Master not found. Searching for slave.');

            Sobject sd = GenericDao.getAllFieldsResultById('Slave_Data__c', 'Id_Cliente_DW__c', id);

            System.debug('Slave is ' + sd);

            return sd;
        }

        return a;
    }
    
    public static SObject getMemberByExtIdXStore(String id){
         SObject a = (Account)GenericDao.getAllFieldsResultById('Account', 'Id_Cliente_xStore__c', id);

        if(a == null){
            System.debug('Master not found. Searching for slave.');

            Sobject sd = GenericDao.getAllFieldsResultById('Slave_Data__c', 'Id_Cliente_xStore__c', id);

            System.debug('Slave is ' + sd);

            return sd;
        }
        
        return a;
    }

    public static SObject getMemberByExtRelateId(String id){
         SObject a = (Account)GenericDao.getAllFieldsResultById('Account', 'Id_Cliente_Relate__c', id);

        if(a == null){
            System.debug('Master not found. Searching for slave.');

            Sobject sd = GenericDao.getAllFieldsResultById('Slave_Data__c', 'Id_Cliente_Relate__c', id);

            System.debug('Slave is ' + sd);

            return sd;
        }
        
        return a;
    }
    


    public class RestAccountHandler extends ProvaHandler{

        public Override Object get(RestRequest req,  RestResponse res){
            String reqUri = req.requestURI.substring(1);
            
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            String relatedResource = arrSize > 2 ? arr[2] : null;
            String idRelatedResource = arrSize > 3 ? arr[3] : null;
            Map<String, String> params = req.params;
            Map<String, Object> m = new Map<String, Object>();


            String ou = params.get('ou');
            SObject a = null;

            if(ou == 'e'){
                System.debug('Before RestAccount.getMemberByExtIdEcommerce:' + id);
                a = RestAccount.getMemberByExtIdEcommerce(id);
            } else if(ou == 'x'){
                System.debug('Before RestAccount.getMemberByExtIdXStore:' + id);
                
                

                a = RestAccount.getMemberByExtIdXStore(id);
                
                String idSF = params.get('idSF');
                System.debug('Before RestAccount.getMemberByidSF idSF:' + idSF);
                if(a == null && !String.isEmpty(idSF)){
                    a = RestAccount.getMember(idSF);
                }
                String secondaryId = params.get('secondaryId');
                System.debug('Before RestAccount.getMemberByExtIdXStore secondaryId:' + secondaryId);
                if(a == null && !String.isEmpty(secondaryId)){
                    a = RestAccount.getMemberByExtIdAS400(secondaryId);
                }
                /*String idDW = params.get('idDW');
                System.debug('Before RestAccount.getMemberByidDW idDW:' + idDW);
                if(a == null && !String.isEmpty(idDW)){
                    a = RestAccount.getMemberByExtIdEcommerce(idDW);
                }*/
                String idRelate = params.get('idRelate');
                System.debug('Before RestAccount.getMemberByidRelate idRelate:' + idRelate);
                if(a == null && !String.isEmpty(idRelate)){
                    a = RestAccount.getMemberByExtRelateId(idRelate);
                }

            } else if(ou == 'a'){
                System.debug('Before RestAccount.getMemberByExtIdAS400:' + id);            
                a = RestAccount.getMemberByExtIdAS400(id);
            } else{
                a = RestAccount.getMember(id);
            }

            if(a == null){
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Id');
            }

            String objectType = a.getSobjectType().getDescribe().getName();
            
            if(a != null && objectType == 'Account'){
                // CONVERT TO MAP
                m = a.getPopulatedFieldsAsMap();
            } else if (a != null && objectType == 'Slave_Data__c'){
                // CONVERT TO ACCOUNT-LIKE MAP
               m = convertSlaveToMap((Slave_Data__c)a);
            }

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
            Map<String, String> params = req.params;

            String ou = params.get('ou');
            String idm = params.get('idm');

            SObject a = null;

            if(ou == 'e'){
                a = RestAccount.getMemberByExtIdEcommerce(id);
            } else if(ou == 'x'){
                a = RestAccount.getMemberByExtIdXStore(id);
            } else if(ou == 'a'){
                a = RestAccount.getMemberByExtIdAS400(id);
            } else{
                a = RestAccount.getMember(id);
            }

            if(a == null){
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Id');
            }

            String objectType = a.getSobjectType().getDescribe().getName();


            if(a != null && objectType == 'Account'){
                obj.id = a.id;
                System.debug('Returning account:' + obj);
                
               // TEN@ 2017-12-20 (SALESFORCE-83)
               if(ou == 'x'){
               		CheckAddressOrientalCharacters(obj);
               }
               // TEN@ 2017-12-20 (SALESFORCE-83)
                

            } else if (a != null && objectType == 'Slave_Data__c'){
               Slave_Data__c sd = RestAccount.copyFromAccountToSlave((Account)obj);
                sd.Id_Cliente_Salesforce__c = id;
                sd.Id = a.id;
                obj = sd;
                //obj.id = id;
                System.debug('Returning Slave:' + obj);
            }

          return obj;
        }

        public Override ResponseWrapper afterUpdateResponse(RestRequest req,  RestResponse res, SObject obj){
            String reqUri = req.requestURI.substring(1);
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String id = arrSize > 1 ? arr[1] : null;
            Map<String, String> params = req.params;

            System.debug('Inside afterUpdateResponse');
            System.debug('Inside afterUpdateResponse: obj: ' + obj);
            System.debug('getSobjectType ' + obj.getSobjectType());
            System.debug('Id is ' + id);

            String ou = params.get('ou');

            SObject a = null;

            if(ou == 'e'){
                a = RestAccount.getMemberByExtIdEcommerce(id);
            } else if(ou == 'x'){
                a = RestAccount.getMemberByExtIdXStore(id);
            } else if(ou == 'a'){
                a = RestAccount.getMemberByExtIdAS400(id);
            } else{
                a = RestAccount.getMember(id);
            }

            String objectType = a.getSobjectType().getDescribe().getName();
            Map<String, Object> m = new Map<String, Object>();
            
            if(a != null && objectType == 'Account'){
                System.debug('Returning account:' + a);
                // CONVERT TO MAP
                m = a.getPopulatedFieldsAsMap();
            } else if (a != null && objectType == 'Slave_Data__c'){
                System.debug('Returning Slave:' + a);
                // CONVERT TO ACCOUNT-LIKE MAP
               m = convertSlaveToMap((Slave_Data__c)a);
            }

            return createSuccessResult(m);
        }

        public Override Boolean beforeInsert(SObject obj){
             obj.put('CurrencyISOCode', 'EUR');

             // Set the owner Id
            Map<String, String> params = RestContext.request.params;

            String ou = params.get('ou');

            System.debug('POST ou: ' + ou);
            
            System.debug('UserInfo.getProfileId(): ' + UserInfo.getProfileId());
            System.debug('CS BC_Ecommerce_ProfileId__c: ' + BC_Settings__c.getOrgDefaults().BC_Ecommerce_ProfileId__c);

            if(obj.get('LastName') == null){
                if(UserInfo.getProfileId() == BC_Settings__c.getOrgDefaults().BC_Ecommerce_ProfileId__c 
                    && obj.get('Id_Cliente_DW__c') == null){
                    obj.put('LastName', 'Newsletter');
                    obj.put('FirstName', 'Newsletter');
                } else {
                    obj.put('LastName', 'GUEST');
                }
            } 

           if(ou == 'x'){
               User u = GenericDao.getUserByCodiceBuotique((String)obj.get('Id_Location__c'));

               System.debug('POST user: ' + u) ;
               
               String ownerId = u != null ? u.Id : BC_Settings__c.getOrgDefaults().Default_Customer_OwnerId__c;

               System.debug('POST OwnerId: ' + ownerId) ;

               obj.put('OwnerId', ownerId);
               
               // TEN@ 2017-12-21 (SALESFORCE-83)
               CheckAddressOrientalCharacters(obj);
               // TEN@ 2017-12-21 (SALESFORCE-83)
               
            }

            // TEN@ 2018-05-29 (SALESFORCE-264)
            Profile__c custom_settings_profile = Profile__c.getInstance();
            if((String)obj.get('Id_Location__c') == '998'){
                obj.put('Associate_di_registrazione__c', custom_settings_profile.Id_Associate_Ecommerce_Europa_e_ROW__c);
            } else if ((String)obj.get('Id_Location__c') == '999'){
                obj.put('Associate_di_registrazione__c', custom_settings_profile.Id_Associate_Ecommerce_USA__c);
            } else {
                Associated__c ass = [ SELECT Id, Name, Id_Associate__c FROM Associated__c WHERE Id_Associate__c =: (String)obj.get('Id_Associate__c') LIMIT 1];
                obj.put('Associate_di_registrazione__c', ass.Id);
            }
            // TEN@ 2018-05-29 (SALESFORCE-264)

            return true;
        }

        public Override SObject afterInsert(SObject obj){

            obj = RestAccount.getMemberId(obj.id);

            return obj;
        }

        public Override String getObjectName(){
            return 'customer';
        }

		// TEN@ 2017-12-21 (SALESFORCE-83)
        public void CheckAddressOrientalCharacters(Sobject obj){
            
            //se presenti caratteri orientali nell'indirizzo salvo i dati relativi nei campi UTF8
            //(ex. EnglishLetters - みずずほダイレクト - 诶非)
             
            String InputString		= 	(String)obj.get('PersonMailingStreet') + ' ' + 
            							(String)obj.get('PersonMailingCity'); 
                       
			String regex 			= '[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff\uff66-\uff9f]';
			Pattern regexPattern 	= Pattern.compile(regex);
			Matcher regexMatcher 	= regexPattern.matcher(InputString);
			Pattern regexPattern_1 	= Pattern.compile('\\p{IsHan}');
			Matcher regexMatcher_1 	= regexPattern_1.matcher(InputString);

			if(regexMatcher.find() || regexMatcher_1.find()) {
   				system.debug('TEN@ oriental characters (true)');				
				obj.put('Indirizzo_UTF_8__c', (String)obj.get('PersonMailingStreet'));
				obj.put('Citta_UTF_8__c', (String)obj.get('PersonMailingCity'));
				obj.put('PersonMailingStreet', '');
				obj.put('PersonMailingCity', '');				
			}
			else{
				system.debug('TEN@ No oriental characters (false)');				 
			}
                        
        }
		// TEN@ 2017-12-21 (SALESFORCE-83)
		
    }

}