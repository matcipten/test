public with sharing class OnAccountTriggerHandler {
    
    // public static Set<Id> accountIDSet= new Set<Id>();
    public static Set<Id> SetOfIDs = new Set<Id>();
    private static boolean run = true;
    public static Map<ID,Boolean> mapOfAccounts = new Map<ID,Boolean>();

    public static void CreateSlaveAssociation(list<Account> oldAccount){
        set<string> AccountIds                  = new set<string>();
        map<string, Account> MapAccount         = new map<string, Account>();
        list<Slave_Data__c> ListSlave           = new list<Slave_Data__c>();
        list<Map_Slave__c> ListMapSlaveToDelete = new list<Map_Slave__c>();
        set<string> MasterAccountIds            = new set<string>();
        
        
        // Ciclo tutte le anagrafiche cancellate      
        for(Account a:oldAccount){
            // Popolo un set di id da utilizzare come filtro nella query per recuperare i master record
            AccountIds.add(a.id);
            // Popolo la mappa con i dati delle anagrafiche cancellate
            MapAccount.put(a.id,a);
        
        }
        // Query per recuprerare gli id delle anagrafiche a partire 
        // dall'oggetto Map_Slave__c che la deduplica a correlato ai master
        list<Map_Slave__c> listMapSlave = [ select  Id_Account__c, 
                                                    Account__c 
                                            from Map_Slave__c 
                                            where Id_Account__c IN:AccountIds];

        String profile_name = [SELECT Id, name FROM Profile WHERE Id =: UserInfo.getProfileId()].Name;

        for(Map_Slave__c m:listMapSlave){
        
            if(MapAccount.containsKey(m.Id_Account__c)){
                // Creo il nuovo record con i dati dello slave correlato al master
                Slave_Data__c sd                        = new Slave_Data__c();
                sd.Account__c                           = m.Account__c;
                sd.Name                                 = (MapAccount.get(m.Id_Account__c).FirstName + ' ' + MapAccount.get(m.Id_Account__c).LastName).left(80);
                sd.Id_Cliente_xStore__c                 = MapAccount.get(m.Id_Account__c).Id_Cliente_xStore__c;
                sd.Id_Cliente_Relate__c                 = MapAccount.get(m.Id_Account__c).Id_Cliente_Relate__c;
                sd.Id_Cliente__c                        = MapAccount.get(m.Id_Account__c).Id_Cliente__c;
                sd.Id_Cliente_DW__c                     = MapAccount.get(m.Id_Account__c).Id_Cliente_DW__c;
                sd.Id_Cliente_Salesforce__c             = MapAccount.get(m.Id_Account__c).Id_Cliente_Salesforce__c;
                sd.FirstName__c                         = MapAccount.get(m.Id_Account__c).FirstName;
                sd.LastName__c                          = MapAccount.get(m.Id_Account__c).LastName;
                sd.Nome_UTF_8__c                        = MapAccount.get(m.Id_Account__c).Nome_UTF_8__c;
                sd.Cognome_UTF_8__c                     = MapAccount.get(m.Id_Account__c).Cognome_UTF_8__c;
                sd.PersonMailingCountry__c              = MapAccount.get(m.Id_Account__c).PersonMailingCountry;
                sd.PersonMailingStreet__c               = MapAccount.get(m.Id_Account__c).PersonMailingStreet;
                sd.PersonMailingPostalCode__c           = MapAccount.get(m.Id_Account__c).PersonMailingPostalCode;
                sd.PersonMailingCity__c                 = MapAccount.get(m.Id_Account__c).PersonMailingCity;
                sd.PersonMailingState__c                = MapAccount.get(m.Id_Account__c).PersonMailingState;
                sd.ShippingCountry__c                   = MapAccount.get(m.Id_Account__c).ShippingCountry;
                sd.ShippingStreet__c                    = MapAccount.get(m.Id_Account__c).ShippingStreet;
                sd.ShippingPostalCode__c                = MapAccount.get(m.Id_Account__c).ShippingPostalCode;
                sd.ShippingCity__c                      = MapAccount.get(m.Id_Account__c).ShippingCity;
                sd.ShippingState__c                     = MapAccount.get(m.Id_Account__c).ShippingState;
                sd.Citta_UTF_8__c                       = MapAccount.get(m.Id_Account__c).Citta_UTF_8__c;
                sd.Indirizzo_UTF_8__c                   = MapAccount.get(m.Id_Account__c).Indirizzo_UTF_8__c;
                sd.Natura_Giuridica__c                  = MapAccount.get(m.Id_Account__c).Natura_Giuridica__c;
                sd.PersonBirthdate__c                   = MapAccount.get(m.Id_Account__c).PersonBirthdate;
                sd.Nazionalita__c                       = MapAccount.get(m.Id_Account__c).Nazionalita__c;
                sd.Data_Di_Registrazione__c             = MapAccount.get(m.Id_Account__c).Data_Di_Registrazione__c;
                sd.Data_Annullamento__c                 = MapAccount.get(m.Id_Account__c).Data_Annullamento__c;
                sd.Data_Registrazione_Newsletter__c     = MapAccount.get(m.Id_Account__c).Data_Registrazione_Newsletter__c;
                sd.Data_Cancellazione_Newsletter__c     = MapAccount.get(m.Id_Account__c).Data_Cancellazione_Newsletter__c;
                sd.PersonEmail__c                       = MapAccount.get(m.Id_Account__c).PersonEmail;
                sd.Email_Ecommerce__c                   = MapAccount.get(m.Id_Account__c).Email_Ecommerce__c;
                sd.Phone__c                             = MapAccount.get(m.Id_Account__c).Phone;
                sd.PersonOtherPhone__c                  = MapAccount.get(m.Id_Account__c).PersonOtherPhone;
                sd.PersonMobilePhone__c                 = MapAccount.get(m.Id_Account__c).PersonMobilePhone;
                sd.Fax__c                               = MapAccount.get(m.Id_Account__c).Fax;
                sd.Categoria_Cliente__c                 = MapAccount.get(m.Id_Account__c).Categoria_Cliente__c;
                sd.Sesso__c                             = MapAccount.get(m.Id_Account__c).Sesso__c;
                sd.Fascia_Di_Eta__c                     = MapAccount.get(m.Id_Account__c).Fascia_Di_Eta__c;
                sd.Id_Location__c                       = MapAccount.get(m.Id_Account__c).Id_Location__c;
                sd.Professione__c                       = MapAccount.get(m.Id_Account__c).Professione__c;
                sd.Id_Associate__c                      = MapAccount.get(m.Id_Account__c).Id_Associate__c;              
                sd.Cellulare__c                         = MapAccount.get(m.Id_Account__c).Cellulare__c;
                sd.Email__c                             = MapAccount.get(m.Id_Account__c).Email__c;
                sd.Newsletter__c                        = MapAccount.get(m.Id_Account__c).Newsletter__c;
                sd.Preferenza_newsletter__c             = MapAccount.get(m.Id_Account__c).Preferenza_newsletter__c;
                sd.Privacy_1__c                         = MapAccount.get(m.Id_Account__c).Privacy_1__c;
                sd.Telefono__c                          = MapAccount.get(m.Id_Account__c).Telefono__c;
                sd.Telefono_Lavoro__c                   = MapAccount.get(m.Id_Account__c).Telefono_Lavoro__c;
                sd.Country_Newsletter__c                = MapAccount.get(m.Id_Account__c).Country_Newsletter__c;                
                sd.Master_Slave__c                      = MapAccount.get(m.Id_Account__c).Master_Slave__c;
                sd.Contact_ID__c                        = MapAccount.get(m.Id_Account__c).Contact_ID__pc;
                sd.Id_Cliente_MDM__c                        = MapAccount.get(m.Id_Account__c).Id_Cliente_MDM__c;
                
                //VS - problema dedup da mdm
                if(profile_name == 'BC - Mulesoft EE (API only)'){
                    sd.Deduplica_Mulesoft__c = true;
                }

                ListSlave.add(sd);
                ListMapSlaveToDelete.add(m);                
                MasterAccountIds.add(m.Account__c);
            }
        
        }
        
        system.debug('SV');
        if(ListSlave.size()>0){         
            // inserisco i dati degli slave
            insert ListSlave;
        
        }
      
        if(ListMapSlaveToDelete.size()>0){          
            // Cancello i record di Map_Slave__c che non servono in quanto 
            // l'anagrafica slave è stata cancellata a fronte del merge
            delete ListMapSlaveToDelete;
        
        }   
        
    }

    public static void CreateSlaveMap(list<Account> newAccount){
 
        list<Map_Slave__c> ListMapSlave = new list<Map_Slave__c>();
               
        for(Account a:newAccount){
            // creo per ogni nuova anagrafica il corrispettivo record 
            // Map_Slave__c che verrà utilizzato a fronte di una deduplica
            Map_Slave__c ms     = new Map_Slave__c();
            ms.Name             = a.Id;
            ms.Account__c       = a.Id;
            ms.Id_Account__c    = a.Id;
                    
            ListMapSlave.add(ms);
        
        }

        if(ListMapSlave.size()>0){          
        
            insert ListMapSlave;
        
        }

    }

    @future(Callout=true)
    public static void sendRequestToRelate(Set<Id> accountId, String status, String stroldMap){
        
        system.debug('DEBUG@ IS accountId: ' + accountId);
        
        Map<String, SObject> oldMap = new Map<String, SObject>();
        if(stroldMap != null){
            oldMap = (Map<String, SObject>)
                JSON.deserialize(stroldMap, Map<String, SObject>.class);
        }
        
        system.debug('DEBUG@ IS oldMap: ' + oldMap);
        
        boolean IsSandbox;
        
        User user = [SELECT id,Nation_Contact_Card__c, Codice_Boutique__c, Codice_Associate__c, FirstName, LastName, Alias FROM User WHERE Id=:UserInfo.getUserId()];
        
        List<organization> lstOrganization = [Select id,instanceName,isSandbox from Organization];
        if(lstOrganization.size()>0) {
            if(lstOrganization[0].isSandbox) {
                system.debug('DEBUG@ IS SANDBOX');
                IsSandbox = true;
            } else {
                system.debug('DEBUG@ IS PRODUCTION');
                IsSandbox = false;
            }
        }
                
        List<Account> newAccount = new List<Account>();
        for(String id : accountId){
            newAccount.add((Account)GenericDao.getAllFieldsResultById('Account', 'Id', id));
        }
                
        //ToDo set acc --> Account
        for (Account acc : newAccount){

            system.debug('DEBUG@ REQUEST ACC: ' + acc);
            system.debug('DEBUG@ REQUEST XML ACC ID: ' + acc.Id);
            
            Web_Service_Log__c relateResponse = new Web_Service_Log__c();
            relateResponse.Timestamp__c = System.now();

            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setHeader('Content-Type', 'text/xml; charset=UTF-8');
            req.setHeader('SOAPAction', 'blank');

            if(IsSandbox){
                //DEV                
                system.debug('DEBUG@ DEV ENDPOINT');
                req.setEndpoint('https://dev-relate.dev.brunellocucinelli.it:8443/soap/BCG/v2_3/CustomerServices');                
                system.debug('DEBUG@ DEV CERTIFICATE');                
               req.setClientCertificate( 
                   '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', 'kstr20140407.srvrlt');
            }
            else{
                //PROD
                system.debug('DEBUG@ PRODUCTION ENDPOINT');
                req.setEndpoint('https://srv-relate.brunellocucinelli.it:8443/soap/BCG/v2_3/CustomerServices');                
                system.debug('DEBUG@ PRODUCTION CERTIFICATE');              
                req.setClientCertificate( 
                   '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', 'kstr20140407.srvrlt');
            }

            String IdClienteAS400 = '';
            String IdClientexStore = '';
            String IdClienteRelate = '';
            String AlternateKeyAS400_ID = '';
            String AlternateKeyRelate = '';
            String AlternateKeyXSTORE_ID = '';
            String PersonBirthdate ='';
            String PrimaryHomePhone = 'false';
            String PrimaryMobilePhone = 'false';
            String CurrentUserCode = 'SF';
            String CategoriaCliente = '';
            String AttributeCategoriaCliente = '';
            String CurrentDatePrivacy = '';
            String UTF8Name = '';
            String UTF8Surname = '';
               
            if(!string.isEmpty(acc.Id_Cliente__c)){
                IdClienteAS400= acc.Id_Cliente__c;
                AlternateKeyAS400_ID =  '<AlternateKey TypeCode="AS400_ID"><AlternateID>' +
                                        IdClienteAS400 + 
                                        '</AlternateID></AlternateKey>';
            }
           
            if(!string.isEmpty(acc.Id_Cliente_Relate__c)){
                IdClienteRelate= acc.Id_Cliente_Relate__c;
                AlternateKeyRelate = '<AlternateKey TypeCode="XSTORE_CUST_ID"><AlternateID>' + 
                                        IdClienteRelate + 
                                        '</AlternateID></AlternateKey>'; 
            }

            if(!string.isEmpty(acc.Id_Cliente_xStore__c)){
                IdClientexStore= acc.Id_Cliente_xStore__c;
                AlternateKeyXSTORE_ID = '<AlternateKey TypeCode="XSTORE_ID"><AlternateID>' + 
                                        IdClientexStore + 
                                        '</AlternateID></AlternateKey>'; 
            }

            if(!string.isEmpty(acc.Categoria_Cliente__c)){
                CategoriaCliente= acc.Categoria_Cliente__c;
                AttributeCategoriaCliente = '<CustomAttribute name="CUSTOMER_GROUPS">'+
                                                '<AttributeValue>' + CategoriaCliente + '</AttributeValue>'+
                                            '</CustomAttribute>'; 
            }
            
            if(!string.isEmpty(acc.Categoria_Cliente__c)){
                CategoriaCliente= acc.Categoria_Cliente__c;
                AttributeCategoriaCliente = '<CustomAttribute name="CUSTOMER_GROUPS">'+
                                                '<AttributeValue>' + CategoriaCliente + '</AttributeValue>'+
                                            '</CustomAttribute>'; 
            }
            
            if(!string.isEmpty(acc.Phone)){
                PrimaryHomePhone = 'true';
            }
            else if(!string.isEmpty(acc.PersonMobilePhone)){
                PrimaryMobilePhone = 'true';
            }

            /*
            if(!string.isEmpty(user.Codice_Associate__c)){
                CurrentUserCode = user.Codice_Associate__c;
            }
            */
            
            if(acc.Data_Ultimo_Aggiornamento_Privacy__c != null){
                CurrentDatePrivacy = '<CustomAttribute name="LAST_UPDATE">'+
                           '<AttributeValue>' + FormatDateToRelate(acc.Data_Ultimo_Aggiornamento_Privacy__c) + '</AttributeValue>'+
                        '</CustomAttribute>';               
            }

            
            String xml_firstName = (status == 'U') ? setValueForRelate(acc.FirstName, (String)oldMap.get(acc.Id).get('FirstName')) : checkStringValue(acc.FirstName);
            String xml_lastName = (status == 'U') ? setValueForRelate(acc.LastName, (String)oldMap.get(acc.Id).get('LastName')) : checkStringValue(acc.LastName);
            //MC- 2019.02.22
            String xml_firstName2 = (status == 'U') ? setValueForRelate(acc.Nome_UTF_8__c, (String)oldMap.get(acc.Id).get('Nome_UTF_8__c')) : checkStringValue(acc.Nome_UTF_8__c);
            String xml_lastName2 = (status == 'U') ? setValueForRelate(acc.Cognome_UTF_8__c, (String)oldMap.get(acc.Id).get('Cognome_UTF_8__c')) : checkStringValue(acc.Cognome_UTF_8__c);
            //MC-
            String xml_personMailingStreet = (status == 'U') ? setValueForRelate(acc.PersonMailingStreet, (String)oldMap.get(acc.Id).get('PersonMailingStreet')) : checkStringValue(acc.PersonMailingStreet);
            String xml_personMailingCity = (status == 'U') ? setValueForRelate(acc.PersonMailingCity, (String)oldMap.get(acc.Id).get('PersonMailingCity')) : checkStringValue(acc.PersonMailingCity);
            String xml_personMailingCountry = (status == 'U') ? setValueForRelate(acc.PersonMailingCountry, (String)oldMap.get(acc.Id).get('PersonMailingCountry')) : checkStringValue(acc.PersonMailingCountry);
            String xml_personMailingState = (status == 'U') ? setValueForRelate(acc.PersonMailingState, (String)oldMap.get(acc.Id).get('PersonMailingState')) : checkStringValue(acc.PersonMailingState);
            String xml_personMailingPostalCode = (status == 'U') ? setValueForRelate(acc.PersonMailingPostalCode, (String)oldMap.get(acc.Id).get('PersonMailingPostalCode')) : checkStringValue(acc.PersonMailingPostalCode);
            String xml_personEmail = (status == 'U') ? setValueForRelate(acc.PersonEmail, (String)oldMap.get(acc.Id).get('PersonEmail')) : checkStringValue(acc.PersonEmail);
            String xml_phone = (status == 'U') ? setValueForRelate(acc.Phone, (String)oldMap.get(acc.Id).get('Phone')) : checkStringValue(acc.Phone);
            String xml_personMobilePhone = (status == 'U') ? setValueForRelate(acc.PersonMobilePhone, (String)oldMap.get(acc.Id).get('PersonMobilePhone')) : checkStringValue(acc.PersonMobilePhone);
			
             if(xml_personMailingStreet == '' || xml_personMailingStreet == null)
                xml_personMailingStreet = '-';
            if(xml_personMailingCity == '' || xml_personMailingCity == null)
                xml_personMailingCity = '-';
            if(xml_personMailingState == '' || xml_personMailingState == null)
                xml_personMailingState = '-';

            system.debug('DEBUG@ Id Cliente AS400: ' + IdClienteAS400);
            system.debug('DEBUG@ Id Cliente Relate: ' + IdClienteRelate);
            system.debug('DEBUG@ Id Cliente xStore: ' + IdClientexStore);
            
            String xml = 
            '<?xml version="1.0" encoding="UTF-8"?>'+
            '<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'+
               '<env:Header />'+
               '<env:Body>'+
                 '<m:addOrUpdateCustomer xmlns:m="http://v2_3.customer.webservices.csx.dtv.com/">'+
                     '<customerData>'+
                        '<RetailStoreID>' + checkStringValue(acc.First_ID_Location__c) + '</RetailStoreID>'+
                        '<Instrument />'+
                        '<CustomerID>' + IdClienteRelate + '</CustomerID>'+
                        '<OrgName />'+
                        '<CustOrgTypcode />'+
                        '<EmployeeID />'+
                        '<BusinessName />'+
                        '<CustomerClass />'+
                        '<Source />'+
                        '<Prospect>false</Prospect>'+
                        '<CustomerNumber/>'+
                        '<CustomerReference />'+
                        '<LastUpdateInfo>'+
                           '<UpdateUserID>' + CurrentUserCode + ' - ' + checkStringValue(user.Alias) + '</UpdateUserID>'+
                           '<UpdateDate>' + System.now() + '</UpdateDate>'+
                        '</LastUpdateInfo>'+                
                        '<Affiliation>'+
                            '<RetailStoreID>' + checkStringValue(acc.Id_Location__c) + '</RetailStoreID>'+
                        '</Affiliation>'+                                
                        '<EntityInformation>'+
                           '<Individual>'+
                              '<Name>'+
                                 '<Name Location="First">' + xml_firstName + '</Name>'+
                                 '<Name Location="Last">' + xml_lastName + '</Name>'+
                                 '<Name Location="First2">' + xml_firstName2 + '</Name>'+
                                 '<Name Location="Last2">' + xml_lastName2 + '</Name>'+
                              '</Name>'+
                              '<Suffix />'+
                              '<SortingName>' + xml_firstName + ' ' + 
                                              xml_lastName + 
                              '</SortingName>'+
                              '<NickName />'+
                              '<Salutation>' + checkStringValue(acc.Salutation) + '</Salutation>'+
                              '<ContactInformation>'+
                                 '<Address PrimaryFlag="true">'+
                                    '<AddressLine1>' + xml_personMailingStreet + '</AddressLine1>'+
                                    '<AddressLine2 />'+
                                    '<AddressLine3 />'+
                                    '<AddressLine4 />'+
                                    '<ApartmentNumber />'+
                                    '<City>' + xml_personMailingCity + '</City>'+
                                    '<Country>'+ xml_personMailingCountry + '</Country>'+
                                    '<Territory>' + xml_personMailingState + '</Territory>'+
                                    '<PostalCode>' + xml_personMailingPostalCode + '</PostalCode>'+
                                 '</Address>'+
                                 '<EMail PrimaryFlag="true">'+
                                    '<EMailAddress>' + xml_personEmail + '</EMailAddress>'+
                                 '</EMail>'+
                                 '<Telephone TypeCode="HOME" PrimaryFlag="' + PrimaryHomePhone + '">'+
                                    '<PhoneNumber>' + xml_phone + '</PhoneNumber>'+
                                    '<Extension />'+
                                 '</Telephone>'+                
                                 '<Telephone TypeCode="MOBILE" PrimaryFlag="' + PrimaryMobilePhone + '">'+
                                    '<PhoneNumber>' + xml_personMobilePhone + '</PhoneNumber>'+
                                    '<Extension />'+
                                 '</Telephone>'+                                                
                              '</ContactInformation>'+
                              '<PersonalSummary>'+
                                 '<GenderType>' + checkStringValue(acc.Sesso__c) + '</GenderType>'+
                                 '<BirthDate>' + FormatDateToRelate(acc.PersonBirthdate) + '</BirthDate>'+
                                 '<MaritalStatusCode />'+
                                 '<Ethnicity />'+
                                 '<Rent>false</Rent>'+
                                 '<LanguageCode>' + checkStringValue(acc.Lingua__c) + '</LanguageCode>'+
                              '</PersonalSummary>'+
                              '<SocioEconomicProfile>'+
                                 '<AnnualIncomeAmount />'+
                                 '<NetWorth />'+
                                 '<HighestEducationalLevelName />'+
                              '</SocioEconomicProfile>'+
                           '</Individual>'+
                        '</EntityInformation>'+
                        '<PersonalPreferences />'+
                        
                        AlternateKeyAS400_ID +
                        AlternateKeyRelate + 
                        AlternateKeyXSTORE_ID + 
                        
                        '<AlternateKey TypeCode="BCG_ID_CUST_SALESFORCE">'+
                           '<AlternateID>' + acc.Id + '</AlternateID>'+
                        '</AlternateKey>'+                                
                        '<CustomAttribute name="PRIVACY">'+
                           '<AttributeValue>false</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="MARKETING_BC_SPA_FLAG">'+
                           '<AttributeValue>' + acc.Privacy1__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="MARKETING_BC_GROUP_FLAG">'+
                           '<AttributeValue>' + acc.Privacy2__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="PROFILING_FLAG">'+
                           '<AttributeValue>' + acc.Privacy3__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="PHONE_CONTACT_FLAG">'+
                           '<AttributeValue>' + acc.Telefono__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="EMAIL_FLAG">'+
                           '<AttributeValue>' + acc.Email__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="PAPER_MAIL_FLAG">'+
                           '<AttributeValue>' + acc.Posta__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="SMS_FLAG">'+
                           '<AttributeValue>' + acc.Social__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="INSTANT_MESSAGING_FLAG">'+
                           '<AttributeValue>' + acc.Messaging__c + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        //MC-
                        '<CustomAttribute name="PASSPORT_NUMBER">'+
                           '<AttributeValue>' + checkStringValue(acc.Numero_Passaporto__c) + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        '<CustomAttribute name="PASSPORT_ISO_CODE">'+
                           '<AttributeValue>' + checkStringValue(acc.Paese_di_emissione_passaporto__c) + '</AttributeValue>'+
                        '</CustomAttribute>'+
                        //MC-
                CurrentDatePrivacy
                + 
                        '<CustomAttribute name="NATIONALITY">'+
                           '<AttributeValue>' + checkStringValue(acc.Nazionalita__c) + '</AttributeValue>'+
                        '</CustomAttribute>'+                                
                        '<CustomAttribute name="OCCUPATION">'+
                           '<AttributeValue>' + checkStringValue(acc.Professione__c) + '</AttributeValue>'+
                        '</CustomAttribute>'+  
                        '<CustomAttribute name="DATE_RANGE">'+
                           '<AttributeValue>' + checkStringValue(acc.Fascia_Di_Eta__c) + '</AttributeValue>'+
                        '</CustomAttribute>'+ 
                
                        AttributeCategoriaCliente +

                /*               
                        '<CustomAttribute name="?????">'+
                           '<AttributeValue>' + acc.WeChat__c + '</AttributeValue>'+
                        '</CustomAttribute>'+ 
                        '<CustomAttribute name="?????">'+
                           '<AttributeValue>' + acc.We_Chat_ID__c + '</AttributeValue>'+
                        '</CustomAttribute>'+ 
                        '<CustomAttribute name="?????">'+
                           '<AttributeValue>' + acc.Other__c + '</AttributeValue>'+
                        '</CustomAttribute>'+                 
                        '<CustomAttribute name="?????">'+
                           '<AttributeValue>' + acc.Other_text__c + '</AttributeValue>'+
                        '</CustomAttribute>'+                  
*/                                
                '</customerData>'+
                     '<securityUserId>100</securityUserId>'+
                  '</m:addOrUpdateCustomer>'+
               '</env:Body>'+
            '</env:Envelope>';
            
            system.debug('DEBUG@ REQUEST XML BODY: ' + xml);
            req.setTimeout(6000); // timeout in milliseconds
            req.setBody(xml);
            system.debug('DEBUG@ REQUEST BODY: ' + req.getBody());

            Http http = new Http();             
            HTTPResponse res = http.send(req);
            system.debug('DEBUG@ RESPONSE: ' + res);
            system.debug('DEBUG@ RESPONSE BODY: ' + res.getBody());
            system.debug('DEBUG@ RESPONSE STATUS: ' + res.getStatus());
            system.debug('DEBUG@ RESPONSE STATUS CODE: ' + res.getStatusCode());
            
            relateResponse.Record_id__c = acc.Id;
            relateResponse.Endpoint__c = req.getEndpoint();
            relateResponse.Result_Code__c = String.valueOf(res.getStatusCode());
            relateResponse.Result_Detail__c = res.getBody();
            relateResponse.Request__c = xml;
            
        Account a = [SELECT Id,Id_Cliente_Relate__c FROM Account WHERE Id =: acc.Id];
            if (a.Id_Cliente_Relate__c == '' || a.Id_Cliente_Relate__c == null){
            DOM.Document document = new DOM.Document();
            document.load(res.getBody());
			
                for (DOM.XmlNode node : document.getRootElement().getChildren())
                {
                    DOM.XmlNode response = node.getChildElement('addOrUpdateCustomerResponse', 'http://v2_3.customer.webservices.csx.dtv.com/');
                    if (response != null){   
                        for (DOM.XmlNode node2 : response.getChildren())
                        {
                            if (node2 != null && node2.getName() == 'customerId')
                            {
                                system.debug('RELATE_ID = ' + node2.getText());
                                a.Id_Cliente_Relate__c = node2.getText();
                                update a;
                            }
                        }
                    }
                }
            }    
            
            insert relateResponse;
            
            system.debug('DEBUG@ relateResponse: ' + relateResponse);
                               
        }

    }

    public static string checkStringValue(string s) {       
        string result = '';        
        if(!string.isEmpty(s)){
            result = s;
        }
        return result;
    }

    public static string FormatDateToRelate(date d) {       
        string result = '';        
        if(d!=null){
            Datetime dt = datetime.newInstance(d.year(), d.month(), d.day());
            result = dt.format('yyyy-MM-dd');
            }
        return result;
    }
    
    public static string setValueForRelate(string newVal, string oldVal) {       
        string result = '';        
        System.debug('newVal: ' + newVal);
        System.debug('oldVal: ' + oldVal);
        if(String.isNotBlank(oldVal) && String.isBlank(newVal)){
            result = '-';
        } else {
            if(newVal == null){
                result = '';
            } else {
                result = newVal;
            }
            
        }
        System.debug('result: ' + result);
        return result;
    }
    
    // String id
    public static boolean runOnce(){
        // if(!SetOfAccounts.contains(id)){
        //     SetOfAccounts.add(id);
            if(run){
                run=false;
                return true;
            }else{
                return run;
            }
        

        // if(!mapOfAccounts.containsKey(id)){
        //     mapOfAccounts.put(id,false);
        // }else{
        //     mapOfAccounts.put(id,true);
        // }
        // System.debug('Id: '+id);
        // System.debug('Map: '+mapOfAccounts);
        // System.debug('Map value: '+mapOfAccounts.get(id));
        // return mapOfAccounts.get(id);
    }
    
    
 
	
  
}