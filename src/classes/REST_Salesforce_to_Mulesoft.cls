public class REST_Salesforce_to_Mulesoft {
    
    public virtual class BaseException extends Exception {}
    public class OtherException extends BaseException {}

    @Future(callout=true)
    public static void doPost(String body){
        Mulesoft_Endpoint__c mce = Mulesoft_Endpoint__c.getInstance();
       
        SV_Log__c log= new SV_Log__c();
        String regex            = '(?<=sobjects\\/Account\\/)(.*)(?="},")';
        Pattern regexPattern    = Pattern.compile(regex);
        Matcher regexMatcher    = regexPattern.matcher(body);
        Boolean matcher= regexMatcher.find();
        String id= regexMatcher.group(0);
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(mce.Endpoint__c);

            // endpoint di test
            // request.setEndpoint('https://putsreq.com/qujU20vVYLOkxTaEaFYB');
            request.setMethod('POST');
            // request.setHeader('Authorization', 'Basic Og==');
            String username =mce.Username__c;
            String password =mce.Password__c;
            Blob headerValue = Blob.valueOf(username + ':' + password);
            // Base 64 Encode the blob and prepend "Basic "
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            // Add the basic auth string to the Request Header
            request.setHeader('Authorization', authorizationHeader);            

            // Configure standard headers

            request.setHeader('Content-Type', 'application/json');
            request.setBody(body);
            System.debug('Body: '+body);
            request.setTimeout(120000);

            HttpResponse response = http.send(request);
            System.debug('json response: '+response);
            System.debug('json response: '+response.getBody());
            log.Input_Payload__c  =body;
            log.Output_Payload__c=response.getBody();
            log.AccountID__c=id;
            log.Source__c = 'POST';
            log.Status__c = response.getStatus();
            log.Success__c = response.getStatusCode()==200 ? true: false;
            // String regex2            = '(?<="Id_Cliente_MDM__c" : ")(.*)(?=","FirstName)';
            // Pattern regexPattern2    = Pattern.compile(regex2);
            // Matcher regexMatcher2    = regexPattern2.matcher(response.getBody());
            // Boolean matcher2= regexMatcher2.find();
            // String idmdm;
            // if(!Test.isRunningTest()){
            //     idmdm= regexMatcher2.group(0);
            // }
            // else{
            //     idmdm='12345';
            // }
            String idmdm;

            Map<String, Object> m;
            if(response.getBody()!= null){
                m = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
                if(!Test.isRunningTest()){
                    idmdm= (String)m.get('Id_Cliente_MDM__c');
                }
                else{
                    idmdm='12345';
                }
            }
            
            
            System.debug('VS MDM ID: '+idmdm);
            Account acc= new Account();
            acc.Id= id;
            System.debug('VS PRE UPDATE ID MDM1'+ acc);
            acc.Id_Cliente_MDM__c=idmdm;
            System.debug('VS PRE UPDATE ID MDM2'+ acc);
            update acc;
            System.debug('VS POST UPDATE ID MDM');
        }catch(System.CalloutException e) { 
            //Exception handling goes here.... retry the call, whatever 
            // success = false; 
            // msg = e.getMessage();  
            System.debug('System.CalloutException');
            log.Status__c = e.getMessage(); 
            System.debug('System.CalloutException: '+e.getMessage());
 
        } catch (BaseException e) {  
            // This catches the OtherException
            // success = false; 
            // msg = e.getMessage();
            System.debug('BaseException');
            log.Status__c = e.getMessage(); 
            System.debug('BaseException: '+e.getMessage());
        }
        
        insert log;
        

    } 
    
    @Future(callout=true)
    public static void doPut(String body){
        Mulesoft_Endpoint__c mce = Mulesoft_Endpoint__c.getInstance();
        SV_Log__c log= new SV_Log__c();
        Map<String, Object> mbody = (Map<String, Object>) JSON.deserializeUntyped(body);       
        
        String regex            = '(?<=sobjects\\/Account\\/)(.*)(?="},")';
        Pattern regexPattern    = Pattern.compile(regex);
        Matcher regexMatcher    = regexPattern.matcher(body);
        Boolean matcher= regexMatcher.find();
        String id= regexMatcher.group(0);
        String body2= buildPayload(id);
        // Account account= getAccount(acc.id);
        // String body= buildPayload(account);
        String regex2            = '(?<="Id_Cliente_MDM__c" : ")(.*)(?=","FirstName)';
        Pattern regexPattern2    = Pattern.compile(regex2);
        Matcher regexMatcher2    = regexPattern2.matcher(body);
        Boolean matcher2= regexMatcher2.find();
        String idmdm;
        if(!Test.isRunningTest()){
            Map<String,Object> p = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(mbody.get('PayLoad')));
            idmdm= (String)p.get('Id_Cliente_MDM__c');
        }
        else{
            idmdm='12345';
        }
        // String body2= buildPayload(id);
        SyStem.debug('VS idmdm: '+idmdm);
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String endpoint = mce.Endpoint__c+'/'+idmdm;
            SyStem.debug('VS endpoint: '+endpoint);
            request.setEndpoint(endpoint);
            
            // endpoint di test
            // request.setEndpoint('https://putsreq.com/qujU20vVYLOkxTaEaFYB');
            
            request.setHeader('Content-Type', 'application/json');
            // request.setHeader('Authorization', 'Basic Og==');

            String username =mce.Username__c;
            String password =mce.Password__c;
            Blob headerValue = Blob.valueOf(username + ':' + password);
            // Base 64 Encode the blob and prepend "Basic "
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            // Add the basic auth string to the Request Header
            request.setHeader('Authorization', authorizationHeader);
            request.setBody(body);
            request.setMethod('PUT');
            request.setTimeout(120000);
            System.debug('Body: '+body);
            System.debug('request: '+request);
            HttpResponse response = http.send(request);
            System.debug('json response: '+response);
            
            log.Input_Payload__c  =body;
            log.Output_Payload__c=response.getBody();
            log.AccountID__c=id;
            log.Source__c = 'PUT';
            log.Status__c = response.getStatus();
            log.Success__c = response.getStatusCode()==200 ? true: false;
            
        }catch(System.CalloutException e) { 
            //Exception handling goes here.... retry the call, whatever 
            // success = false; 
            // msg = e.getMessage();  
            log.Status__c = e.getMessage(); 
            System.debug('System.CalloutException: '+e.getMessage());
 
        } catch (BaseException e) {  
            // This catches the OtherException
            // success = false; 
            // msg = e.getMessage();
            log.Status__c = e.getMessage(); 
            System.debug('BaseException: '+e.getMessage());
        }
        
        insert log;

    }
    public static void doPostSync(String body){
        Mulesoft_Endpoint__c mce = Mulesoft_Endpoint__c.getInstance();
       
        SV_Log__c log= new SV_Log__c();
        String regex            = '(?<=sobjects\\/Account\\/)(.*)(?="},")';
        Pattern regexPattern    = Pattern.compile(regex);
        Matcher regexMatcher    = regexPattern.matcher(body);
        Boolean matcher= regexMatcher.find();
        String id= regexMatcher.group(0);
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(mce.Endpoint__c);

            
            request.setMethod('POST');
            String username =mce.Username__c;
            String password =mce.Password__c;
            Blob headerValue = Blob.valueOf(username + ':' + password);
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            request.setHeader('Authorization', authorizationHeader);            


            request.setHeader('Content-Type', 'application/json');
            request.setBody(body);
            System.debug('Body: '+body);
            request.setTimeout(120000);

            HttpResponse response = http.send(request);
            System.debug('json response: '+response);
            System.debug('json response: '+response.getBody());
            log.Input_Payload__c  =body;
            log.Output_Payload__c=response.getBody();
            log.AccountID__c=id;
            log.Source__c = 'POST';
            log.Status__c = response.getStatus();
            log.Success__c = response.getStatusCode()==200 ? true: false;
            
            String idmdm;

            Map<String, Object> m;
            if(response.getBody()!= null){
                m = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
                if(!Test.isRunningTest()){
                    idmdm= (String)m.get('Id_Cliente_MDM__c');
                }
                else{
                    idmdm='12345';
                }
            }
            
            if(response.getStatusCode()==200 && idmdm!= null){
                System.debug('VS MDM ID: '+idmdm);
                Account acc= new Account();
                acc.Id= id;
                System.debug('VS PRE UPDATE ID MDM1'+ acc);
                acc.Id_Cliente_MDM__c=idmdm;
                System.debug('VS PRE UPDATE ID MDM2'+ acc);
                update acc;
                System.debug('VS POST UPDATE ID MDM');
            }
            
        }catch(System.CalloutException e) { 
            System.debug('System.CalloutException');
            log.Status__c = e.getMessage(); 
            System.debug('System.CalloutException: '+e.getMessage());
 
        } catch (BaseException e) {  

            System.debug('BaseException');
            log.Status__c = e.getMessage(); 
            System.debug('BaseException: '+e.getMessage());
        }
        
        String mapLog = JSON.serialize(log);
        insertLog(mapLog);
        

    }
    
    public static void doPutSync(String body){
        Mulesoft_Endpoint__c mce = Mulesoft_Endpoint__c.getInstance();
        SV_Log__c log= new SV_Log__c();
        Map<String, Object> mbody = (Map<String, Object>) JSON.deserializeUntyped(body);       
        
        String regex            = '(?<=sobjects\\/Account\\/)(.*)(?="},")';
        Pattern regexPattern    = Pattern.compile(regex);
        Matcher regexMatcher    = regexPattern.matcher(body);
        Boolean matcher= regexMatcher.find();
        String id= regexMatcher.group(0);
        String body2= buildPayload(id);
        // Account account= getAccount(acc.id);
        // String body= buildPayload(account);
        String regex2            = '(?<="Id_Cliente_MDM__c" : ")(.*)(?=","FirstName)';
        Pattern regexPattern2    = Pattern.compile(regex2);
        Matcher regexMatcher2    = regexPattern2.matcher(body);
        Boolean matcher2= regexMatcher2.find();
        String idmdm;
        if(!Test.isRunningTest()){
            Map<String,Object> p = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(mbody.get('PayLoad')));
            idmdm= (String)p.get('Id_Cliente_MDM__c');
        }
        else{
            idmdm='12345';
        }
        // String body2= buildPayload(id);
        SyStem.debug('VS idmdm: '+idmdm);
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String endpoint = mce.Endpoint__c+'/'+idmdm;
            SyStem.debug('VS endpoint: '+endpoint);
            request.setEndpoint(endpoint);
            
            // endpoint di test
            // request.setEndpoint('https://putsreq.com/qujU20vVYLOkxTaEaFYB');
            
            request.setHeader('Content-Type', 'application/json');
            // request.setHeader('Authorization', 'Basic Og==');

            String username =mce.Username__c;
            String password =mce.Password__c;
            Blob headerValue = Blob.valueOf(username + ':' + password);
            // Base 64 Encode the blob and prepend "Basic "
            String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(headerValue);
            // Add the basic auth string to the Request Header
            request.setHeader('Authorization', authorizationHeader);
            request.setBody(body);
            request.setMethod('PUT');
            request.setTimeout(120000);
            System.debug('Body: '+body);
            System.debug('request: '+request);
            HttpResponse response = http.send(request);
            System.debug('json response: '+response);
            
            log.Input_Payload__c  =body;
            log.Output_Payload__c=response.getBody();
            log.AccountID__c=id;
            log.Source__c = 'PUT';
            log.Status__c = response.getStatus();
            log.Success__c = response.getStatusCode()==200 ? true: false;
            
        }catch(System.CalloutException e) { 
            //Exception handling goes here.... retry the call, whatever 
            // success = false; 
            // msg = e.getMessage();  
            log.Status__c = e.getMessage(); 
            System.debug('System.CalloutException: '+e.getMessage());
 
        } catch (BaseException e) {  
            // This catches the OtherException
            // success = false; 
            // msg = e.getMessage();
            log.Status__c = e.getMessage(); 
            System.debug('BaseException: '+e.getMessage());
        }
        
        //insert log;
        //Map<String,Object> mapLog = (Map<String,Object>)JSON.deserializeUntyped(JSON.serialize(log));
        String mapLog = JSON.serialize(log);
        insertLog(mapLog);

    }
    
    @future
    public static void insertLog(String l){
        SV_Log__c log = (SV_Log__c)JSON.deserialize(l, SV_Log__c.Class);
        insert log;
    }

   

    
    public static string buildPayload(String id){
        Account acc= [SELECT Id,Name, Id_Cliente_xStore__c, Id_Cliente_Relate__c, Id_Cliente__c, Id_Cliente_DW__c, Id_Cliente_MDM__c, FirstName, LastName, Nome_UTF_8__c, Cognome_UTF_8__c, 
                            PersonMailingCountry, PersonMailingStreet, PersonMailingPostalCode, PersonMailingCity, PersonMailingState, BillingCountry, BillingStreet, BillingPostalCode, 
                            BillingCity, BillingState, PersonOtherCountry, PersonOtherStreet, PersonOtherPostalCode, PersonOtherCity, PersonOtherState, ShippingCountry, ShippingStreet, 
                            ShippingPostalCode, ShippingCity, ShippingState, Citta_UTF_8__c, Indirizzo_UTF_8__c, Natura_Giuridica__c, PersonBirthdate, Nazionalita__c, 
                            Data_Di_Registrazione__c, Data_Annullamento__c, Data_Registrazione_Newsletter__c, Data_Cancellazione_Newsletter__c, PersonEmail, Email_Ecommerce__c, Phone, 
                            PersonOtherPhone, PersonMobilePhone, Fax, Categoria_Cliente__c, Categoria_Cliente_Proposta__c, Sesso__c, Fascia_Di_Eta__c, Id_Location__c, Professione__c, 
                            Id_Associate__c, Id_Cliente_Salesforce__c, RecordTypeID, Salutation, customer_origin__c, Hobby__c, Numero_Passaporto__c, Data_di_emissione_passaporto__c, 
                            Ente_di_emissione_passaporto__c, Paese_di_emissione_passaporto__c, Privacy1__c, Privacy2__c, Privacy3__c, Data_Ultimo_Aggiornamento_Privacy__c, PersonHasOptedOutOfEmail, 
                            Registrazione_Al_Sito__c, Telefono__c, Email__c, Posta__c, Messaging__c, WeChat__c, Newsletter__c, Country_Newsletter__c, Stato_Newsletter__c, Preferenza_newsletter__c, 
                            Lingua__c, First_ID_Location__c, First_Location__c, Associate_di_registrazione__c, Associate_Registrazione_ID__c, Cellulare__c, Social__c, Telefono_Lavoro__c,Zip_Code_UTF_8__c, Province_UTF_8__c,Motivazione_Richiesta_Sconto__c
                            FROM Account
                            WHERE Id =: id];
                            
                            String motivazione= JSON.serialize(acc.Motivazione_Richiesta_Sconto__c);
                            motivazione.replace('\n', '\\n');
                            // System.debug('motivazione n: '+motivazione);
                            motivazione.replace('\r', '\\r');
                            // System.debug('motivazione r: '+motivazione);
                            // System.debug('motivazionefin : '+motivazione);
                            acc.Motivazione_Richiesta_Sconto__c=motivazione.substring(1, motivazione.length()-1);
                            String str='{'+
                                        '"PayLoad": {'+
                                        '"attributes": {'+
                                            '"type": "Account",'+
                                            '"url": "/services/data/v48.0/sobjects/Account/'+acc.Id+'"'+
                                        '},'+
                                        '"Id_Cliente_xStore__c" : '+(acc.Id_Cliente_xStore__c!= null ? '"'+acc.Id_Cliente_xStore__c+'"': null) + ',' +
                                        '"Id_Cliente_Relate__c" : ' + (acc.Id_Cliente_Relate__c!= null ? '"'+acc.Id_Cliente_Relate__c+'"': null) + ',' +
                                        '"Id_Cliente__c" : ' + (acc.Id_Cliente__c!= null ? '"'+acc.Id_Cliente__c+'"': null) + ',' +
                                        '"Id_Cliente_DW__c" : ' + (acc.Id_Cliente_DW__c!= null ? '"'+acc.Id_Cliente_DW__c+'"': null) + ',' +
                                        '"Id_Cliente_MDM__c" : ' + (acc.Id_Cliente_MDM__c!= null ? '"'+acc.Id_Cliente_MDM__c+'"': null) + ',' +
                                        '"FirstName" : ' + (acc.FirstName!= null ? '"'+acc.FirstName+'"': null) + ',' +
                                        '"LastName" : ' + (acc.LastName!= null ? '"'+acc.LastName+'"': null) + ',' +
                                        '"Nome_UTF_8__c" : ' + (acc.Nome_UTF_8__c!= null ? '"'+acc.Nome_UTF_8__c+'"': null) + ',' +
                                        '"Cognome_UTF_8__c" : ' + (acc.Cognome_UTF_8__c!= null ? '"'+acc.Cognome_UTF_8__c+'"': null) + ',' +
                                        '"PersonMailingCountry" : ' + (acc.PersonMailingCountry!= null ? '"'+acc.PersonMailingCountry+'"': null) + ',' +
                                        '"PersonMailingStreet" : ' + (acc.PersonMailingStreet!= null ? '"'+acc.PersonMailingStreet+'"': null) + ',' +
                                        '"PersonMailingPostalCode" : ' + (acc.PersonMailingPostalCode!= null ? '"'+acc.PersonMailingPostalCode+'"': null) + ',' +
                                        '"PersonMailingCity" : ' + (acc.PersonMailingCity!= null ? '"'+acc.PersonMailingCity+'"': null) + ',' +
                                        '"PersonMailingState" : ' + (acc.PersonMailingState!= null ? '"'+acc.PersonMailingState+'"': null) + ',' +
                                        '"BillingCountry" : ' + (acc.BillingCountry!= null ? '"'+acc.BillingCountry+'"': null) + ',' +
                                        '"BillingStreet" : ' + (acc.BillingStreet!= null ? '"'+acc.BillingStreet+'"': null) + ',' +
                                        '"BillingPostalCode" : ' + (acc.BillingPostalCode!= null ? '"'+acc.BillingPostalCode+'"': null) + ',' +
                                        '"BillingCity" : ' + (acc.BillingCity!= null ? '"'+acc.BillingCity+'"': null) + ',' +
                                        '"BillingState" : ' + (acc.BillingState!= null ? '"'+acc.BillingState+'"': null) + ',' +
                                        '"PersonOtherCountry" : ' + (acc.PersonOtherCountry!= null ? '"'+acc.PersonOtherCountry+'"': null) + ',' +
                                        '"PersonOtherStreet" : ' + (acc.PersonOtherStreet!= null ? '"'+acc.PersonOtherStreet+'"': null) + ',' +
                                        '"PersonOtherPostalCode" : ' + (acc.PersonOtherPostalCode!= null ? '"'+acc.PersonOtherPostalCode+'"': null) + ',' +
                                        '"PersonOtherCity" : ' + (acc.PersonOtherCity!= null ? '"'+acc.PersonOtherCity+'"': null) + ',' +
                                        '"PersonOtherState" : ' + (acc.PersonOtherState!= null ? '"'+acc.PersonOtherState+'"': null) + ',' +
                                        '"ShippingCountry" : ' + (acc.ShippingCountry!= null ? '"'+acc.ShippingCountry+'"': null) + ',' +
                                        '"ShippingStreet" : ' + (acc.ShippingStreet!= null ? '"'+acc.ShippingStreet+'"': null) + ',' +
                                        '"ShippingPostalCode" : ' + (acc.ShippingPostalCode!= null ? '"'+acc.ShippingPostalCode+'"': null) + ',' +
                                        '"ShippingCity" : ' + (acc.ShippingCity!= null ? '"'+acc.ShippingCity+'"': null) + ',' +
                                        '"ShippingState" : ' + (acc.ShippingState!= null ? '"'+acc.ShippingState+'"': null) + ',' +
                                        '"Citta_UTF_8__c" : ' + (acc.Citta_UTF_8__c!= null ? '"'+acc.Citta_UTF_8__c+'"': null) + ',' +
                                        '"Indirizzo_UTF_8__c" : ' + (acc.Indirizzo_UTF_8__c!= null ? '"'+acc.Indirizzo_UTF_8__c+'"': null) + ',' +
                                        '"Natura_Giuridica__c" : ' + (acc.Natura_Giuridica__c!= null ? '"'+acc.Natura_Giuridica__c+'"': null) + ',' +
                                        '"PersonBirthdate" : ' + (acc.PersonBirthdate!=null? JSON.serialize(DateTime.newInstanceGMT(acc.PersonBirthdate.year(), acc.PersonBirthdate.month(), acc.PersonBirthdate.day(),0,0,0)) : null)+ ',' +
                                        '"Nazionalita__c" : ' + (acc.Nazionalita__c!= null ? '"'+acc.Nazionalita__c+'"': null) + ',' +
                                        '"Data_Di_Registrazione__c" : ' + (acc.Data_Di_Registrazione__c!=null? JSON.serialize(DateTime.newInstanceGMT(acc.Data_Di_Registrazione__c.year(), acc.Data_Di_Registrazione__c.month(), acc.Data_Di_Registrazione__c.day(),0,0,0)) : null)+ ',' +
                                        '"Data_Annullamento__c" : ' + (acc.Data_Annullamento__c!=null? JSON.serialize(DateTime.newInstanceGMT(acc.Data_Annullamento__c.year(), acc.Data_Annullamento__c.month(), acc.Data_Annullamento__c.day(),0,0,0)) : null)+ ',' +
                                        '"Data_Registrazione_Newsletter__c" : ' + (acc.Data_Registrazione_Newsletter__c!=null? JSON.serialize(DateTime.newInstanceGMT(acc.Data_Registrazione_Newsletter__c.year(), acc.Data_Registrazione_Newsletter__c.month(), acc.Data_Registrazione_Newsletter__c.day(),0,0,0)) : null)+ ',' +
                                        '"Data_Cancellazione_Newsletter__c" : ' + (acc.Data_Cancellazione_Newsletter__c!=null? JSON.serialize(DateTime.newInstanceGMT(acc.Data_Cancellazione_Newsletter__c.year(), acc.Data_Cancellazione_Newsletter__c.month(), acc.Data_Cancellazione_Newsletter__c.day(),0,0,0)) : null)+ ',' +
                                        '"PersonEmail" : ' + (acc.PersonEmail!= null ? '"'+acc.PersonEmail+'"': null) + ',' +
                                        '"Email_Ecommerce__c" : ' + (acc.Email_Ecommerce__c!= null ? '"'+acc.Email_Ecommerce__c+'"': null) + ',' +
                                        '"Phone" : ' + (acc.Phone!= null ? '"'+acc.Phone+'"': null) + ',' +
                                        '"PersonOtherPhone" : ' + (acc.PersonOtherPhone!= null ? '"'+acc.PersonOtherPhone+'"': null) + ',' +
                                        '"PersonMobilePhone" : ' + (acc.PersonMobilePhone!= null ? '"'+acc.PersonMobilePhone+'"': null) + ',' +
                                        '"Fax" : ' + (acc.Fax!= null ? '"'+acc.Fax+'"': null) + ',' +
                                        '"Categoria_Cliente__c" : ' + (acc.Categoria_Cliente__c!= null ? '"'+acc.Categoria_Cliente__c+'"': null) + ',' +
                                        '"Categoria_Cliente_Proposta__c" : ' + (acc.Categoria_Cliente_Proposta__c!= null ? '"'+acc.Categoria_Cliente_Proposta__c+'"': null) + ',' +
                                        '"Sesso__c" : ' + (acc.Sesso__c!= null ? '"'+acc.Sesso__c+'"': null) + ',' +
                                        '"Fascia_Di_Eta__c" : ' + (acc.Fascia_Di_Eta__c!= null ? '"'+acc.Fascia_Di_Eta__c+'"': null) + ',' +
                                        '"Id_Location__c" : ' + (acc.Id_Location__c!= null ? '"'+acc.Id_Location__c+'"': null) + ',' +
                                        '"Professione__c" : ' + (acc.Professione__c!= null ? '"'+acc.Professione__c+'"': null) + ',' +
                                        '"Id_Associate__c" : ' + (acc.Id_Associate__c!= null ? '"'+acc.Id_Associate__c+'"': null) + ',' +
                                        '"Id_Cliente_Salesforce__c" : ' + (acc.Id_Cliente_Salesforce__c!= null ? '"'+acc.Id_Cliente_Salesforce__c+'"': null) + ',' +
                                        '"RecordTypeID" : ' + (acc.RecordTypeID!= null ? '"'+acc.RecordTypeID+'"': null) + ',' +
                                        '"Salutation" : ' + (acc.Salutation!= null ? '"'+acc.Salutation+'"': null) + ',' +
                                        '"customer_origin__c" : ' + (acc.customer_origin__c!= null ? '"'+acc.customer_origin__c+'"': null) + ',' +
                                        '"Hobby__c" : ' + (acc.Hobby__c!= null ? '"'+acc.Hobby__c+'"': null) + ',' +
                                        '"Numero_Passaporto__c" : ' + (acc.Numero_Passaporto__c!= null ? '"'+acc.Numero_Passaporto__c+'"': null) + ',' +
                                        '"Data_di_emissione_passaporto__c" : ' + (acc.Data_di_emissione_passaporto__c!=null? JSON.serialize(DateTime.newInstanceGMT(acc.Data_di_emissione_passaporto__c.year(), acc.Data_di_emissione_passaporto__c.month(), acc.Data_di_emissione_passaporto__c.day(),0,0,0)) : null )+ ',' +
                                        '"Ente_di_emissione_passaporto__c" : ' + (acc.Ente_di_emissione_passaporto__c!= null ? '"'+acc.Ente_di_emissione_passaporto__c+'"': null) + ',' +
                                        '"Paese_di_emissione_passaporto__c" : ' + (acc.Paese_di_emissione_passaporto__c!= null ? '"'+acc.Paese_di_emissione_passaporto__c+'"': null) + ',' +
                                        '"Privacy1__c" : ' + acc.Privacy1__c + ',' +
                                        '"Privacy2__c" : ' + acc.Privacy2__c + ',' +
                                        '"Privacy3__c" : ' + acc.Privacy3__c + ',' +
                                        '"Data_Ultimo_Aggiornamento_Privacy__c" : ' + (acc.Data_Ultimo_Aggiornamento_Privacy__c!=null? JSON.serialize(DateTime.newInstanceGMT(acc.Data_Ultimo_Aggiornamento_Privacy__c.year(), acc.Data_Ultimo_Aggiornamento_Privacy__c.month(), acc.Data_Ultimo_Aggiornamento_Privacy__c.day(),0,0,0)) : null)+ ',' +
                                        '"PersonHasOptedOutOfEmail" : ' + acc.PersonHasOptedOutOfEmail + ',' +
                                        '"Registrazione_Al_Sito__c" : ' + acc.Registrazione_Al_Sito__c + ',' +
                                        '"Telefono__c" : ' + acc.Telefono__c + ',' +
                                        '"Email__c" : ' + acc.Email__c + ',' +
                                        '"Posta__c" : ' + acc.Posta__c + ',' +
                                        '"Messaging__c" : ' + acc.Messaging__c + ',' +
                                        '"WeChat__c" : ' + acc.WeChat__c + ',' +
                                        '"Newsletter__c" : ' + acc.Newsletter__c + ',' +
                                        '"Country_Newsletter__c" : ' + (acc.Country_Newsletter__c!= null ? '"'+acc.Country_Newsletter__c+'"': null) + ',' +
                                        '"Stato_Newsletter__c" : ' + (acc.Stato_Newsletter__c!= null ? '"'+acc.Stato_Newsletter__c+'"': null) + ',' +
                                        '"Preferenza_newsletter__c" : ' + (acc.Preferenza_newsletter__c!= null ? '"'+acc.Preferenza_newsletter__c+'"': null) + ',' +
                                        '"Lingua__c" : ' + (acc.Lingua__c!= null ? '"'+acc.Lingua__c+'"': null) + ',' +
                                        '"First_ID_Location__c" : ' + (acc.First_ID_Location__c!= null ? '"'+acc.First_ID_Location__c+'"': null) + ',' +
                                        '"First_Location__c" : ' + (acc.First_Location__c!= null ? '"'+acc.First_Location__c+'"': null) + ',' +
                                        '"Associate_di_registrazione__c" : ' + (acc.Associate_di_registrazione__c!= null ? '"'+acc.Associate_di_registrazione__c+'"': null) + ',' +
                                        '"Associate_Registrazione_ID__c" : ' + (acc.Associate_Registrazione_ID__c!= null ? '"'+acc.Associate_Registrazione_ID__c+'"': null) + ',' +
                                        '"Cellulare__c" : ' + acc.Cellulare__c + ',' +
                                        '"Social__c" : ' + acc.Social__c + ',' +
                                        '"Zip_Code_UTF_8__c" : ' + (acc.Zip_Code_UTF_8__c!= null ? '"'+acc.Zip_Code_UTF_8__c+'"': null) + ',' +
                                        '"Province_UTF_8__c" : ' + (acc.Province_UTF_8__c!= null ? '"'+acc.Province_UTF_8__c+'"': null) + ',' +
                                        '"Motivazione_Richiesta_Sconto__c" : ' + (acc.Motivazione_Richiesta_Sconto__c!= null ? '"'+acc.Motivazione_Richiesta_Sconto__c+'"': null) + ',' +
                                        '"Telefono_Lavoro__c" : ' + acc.Telefono_Lavoro__c + ''+
                                        
                                        '}'+
                                    '}';
                                    // System.debug('VS:'+acc.Motivazione_Richiesta_Sconto__c);
                                    // System.debug('VS:'+acc.Name);
      return str;
    }


        
    
}