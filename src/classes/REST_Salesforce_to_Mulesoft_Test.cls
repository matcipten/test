@isTest
public class REST_Salesforce_to_Mulesoft_Test {

    public class MockHttpResponseGeneratorPos implements HttpCalloutMock {
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest req) {
            // Optionally, only send a mock response for a specific endpoint
            // and method.
            // System.assertEquals('http://example.com/example/test', req.getEndpoint());
            // System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(200);
            return res;
        }
    }

    public class MockHttpResponseGeneratorNeg implements HttpCalloutMock {
        // Implement this interface method
        public HTTPResponse respond(HTTPRequest req) {
            // Optionally, only send a mock response for a specific endpoint
            // and method.
            // System.assertEquals('http://example.com/example/test', req.getEndpoint());
            // System.assertEquals('GET', req.getMethod());
            
            // Create a fake response
            
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"example":"test"}');
            res.setStatusCode(404);
            return res;
        }
    }
    
    @isTest
    public static void testPOSTPos(){
        Mulesoft_Endpoint__c cs = new Mulesoft_Endpoint__c();
        cs.Endpoint__c = 'http://example.com/example/test';
        cs.Username__c = 'testun';
        cs.Password__c = 'testpw';
        cs.LIMIT__c='200';
        insert cs;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorPos());

        Account acc = new Account();
        
        acc.Id_Cliente_xStore__c = 'TEST';
        acc.Id_Cliente_Relate__c = 'TEST';
        acc.Id_Cliente__c = 'TEST';
        acc.Id_Cliente_DW__c = 'TEST';
        acc.Id_Cliente_MDM__c = 'TEST';
        acc.FirstName = 'TEST';
        acc.LastName = 'TEST';
        acc.Nome_UTF_8__c = 'TEST';
        acc.Cognome_UTF_8__c = 'TEST';
        acc.PersonMailingCountry = 'TEST';
        acc.PersonMailingStreet = 'TEST';
        acc.PersonMailingPostalCode = 'TEST';
        acc.PersonMailingCity = 'TEST';
        acc.PersonMailingState = 'TEST';
        acc.BillingCountry = 'TEST';
        acc.BillingStreet = 'TEST';
        acc.BillingPostalCode = 'TEST';
        acc.BillingCity = 'TEST';
        acc.BillingState = 'TEST';
        acc.PersonOtherCountry = 'TEST';
        acc.PersonOtherStreet = 'TEST';
        acc.PersonOtherPostalCode = 'TEST';
        acc.PersonOtherCity = 'TEST';
        acc.PersonOtherState = 'TEST';
        acc.ShippingCountry = 'TEST';
        acc.ShippingStreet = 'TEST';
        acc.ShippingPostalCode = 'TEST';
        acc.ShippingCity = 'TEST';
        acc.ShippingState = 'TEST';
        acc.Citta_UTF_8__c = 'TEST';
        acc.Indirizzo_UTF_8__c = 'TEST';
        acc.Natura_Giuridica__c = 'TEST';
        acc.PersonBirthdate = Date.today();
        acc.Nazionalita__c = 'TEST';
        acc.Data_Di_Registrazione__c = Date.today();
        acc.Data_Annullamento__c = Date.today();
        acc.Data_Registrazione_Newsletter__c = Date.today();
        acc.Data_Cancellazione_Newsletter__c = Date.today();
        acc.PersonEmail = 'test@test.com';
        acc.Email_Ecommerce__c = 'test@test.com';
        acc.Phone = 'TEST';
        acc.PersonOtherPhone = 'TEST';
        acc.PersonMobilePhone = 'TEST';
        acc.Fax = 'TEST';
        acc.Categoria_Cliente__c = 'TEST';
        acc.Categoria_Cliente_Proposta__c = 'TEST';
        acc.Sesso__c = 'TEST';
        acc.Fascia_Di_Eta__c = 'TEST';
        acc.Id_Location__c = 'TEST';
        acc.Professione__c = 'TEST';
        acc.Id_Associate__c = 'TEST';
        // acc.Id_Cliente_Salesforce__c = 'TEST';
        // acc.RecordTypeID = 'TEST';
        acc.Salutation = 'TEST';
        acc.customer_origin__c = 'Newsletter';
        acc.Hobby__c = 'Travel';
        acc.Numero_Passaporto__c = 'TEST';
        acc.Data_di_emissione_passaporto__c = Date.today();
        acc.Ente_di_emissione_passaporto__c = 'TEST';
        acc.Paese_di_emissione_passaporto__c = 'TEST';
        acc.Privacy1__c = true;
        acc.Privacy2__c = false;
        acc.Privacy3__c = true;
        acc.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();
        acc.PersonHasOptedOutOfEmail = false;
        acc.Registrazione_Al_Sito__c = true;
        acc.Telefono__c = false;
        acc.Email__c = true;
        acc.Posta__c = false;
        acc.Messaging__c = true;
        acc.WeChat__c = false;
        acc.Newsletter__c = true;
        acc.Country_Newsletter__c = 'IT';
        acc.Stato_Newsletter__c = 'NY';
        acc.Preferenza_newsletter__c = 'TEST';
        acc.Lingua__c = 'TEST';
        acc.First_ID_Location__c = 'TEST';
        acc.First_Location__c = 'TEST';
        // acc.Associate_di_registrazione__c = 'TEST';
        // acc.Associate_Registrazione_ID__c = 'TEST';
        acc.Cellulare__c = false;
        acc.Social__c = true;
        acc.Telefono_Lavoro__c = false;
        insert acc;
        String body = REST_Salesforce_to_Mulesoft.buildPayload(acc.id);
        REST_Salesforce_to_Mulesoft.doPost(body);
    }

    @isTest
    public static void testPOSTNeg(){
        Mulesoft_Endpoint__c cs = new Mulesoft_Endpoint__c();
        cs.Endpoint__c = 'http://example.com/example/test';
        cs.Username__c = 'testun';
        cs.Password__c = 'testpw';
        cs.LIMIT__c='200';
        insert cs;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorNeg());
        // String body ='{"PayLoad": {}}';
        Account acc = new Account();
        
        acc.Id_Cliente_xStore__c = 'TEST';
        acc.Id_Cliente_Relate__c = 'TEST';
        acc.Id_Cliente__c = 'TEST';
        acc.Id_Cliente_DW__c = 'TEST';
        acc.Id_Cliente_MDM__c = 'TEST';
        acc.FirstName = 'TEST';
        acc.LastName = 'TEST';
        acc.Nome_UTF_8__c = 'TEST';
        acc.Cognome_UTF_8__c = 'TEST';
        acc.PersonMailingCountry = 'TEST';
        acc.PersonMailingStreet = 'TEST';
        acc.PersonMailingPostalCode = 'TEST';
        acc.PersonMailingCity = 'TEST';
        acc.PersonMailingState = 'TEST';
        acc.BillingCountry = 'TEST';
        acc.BillingStreet = 'TEST';
        acc.BillingPostalCode = 'TEST';
        acc.BillingCity = 'TEST';
        acc.BillingState = 'TEST';
        acc.PersonOtherCountry = 'TEST';
        acc.PersonOtherStreet = 'TEST';
        acc.PersonOtherPostalCode = 'TEST';
        acc.PersonOtherCity = 'TEST';
        acc.PersonOtherState = 'TEST';
        acc.ShippingCountry = 'TEST';
        acc.ShippingStreet = 'TEST';
        acc.ShippingPostalCode = 'TEST';
        acc.ShippingCity = 'TEST';
        acc.ShippingState = 'TEST';
        acc.Citta_UTF_8__c = 'TEST';
        acc.Indirizzo_UTF_8__c = 'TEST';
        acc.Natura_Giuridica__c = 'TEST';
        acc.PersonBirthdate = Date.today();
        acc.Nazionalita__c = 'TEST';
        acc.Data_Di_Registrazione__c = Date.today();
        acc.Data_Annullamento__c = Date.today();
        acc.Data_Registrazione_Newsletter__c = Date.today();
        acc.Data_Cancellazione_Newsletter__c = Date.today();
        acc.PersonEmail = 'test@test.com';
        acc.Email_Ecommerce__c = 'test@test.com';
        acc.Phone = 'TEST';
        acc.PersonOtherPhone = 'TEST';
        acc.PersonMobilePhone = 'TEST';
        acc.Fax = 'TEST';
        acc.Categoria_Cliente__c = 'TEST';
        acc.Categoria_Cliente_Proposta__c = 'TEST';
        acc.Sesso__c = 'TEST';
        acc.Fascia_Di_Eta__c = 'TEST';
        acc.Id_Location__c = 'TEST';
        acc.Professione__c = 'TEST';
        acc.Id_Associate__c = 'TEST';
        // acc.Id_Cliente_Salesforce__c = 'TEST';
        // acc.RecordTypeID = 'TEST';
        acc.Salutation = 'TEST';
        acc.customer_origin__c = 'Newsletter';
        acc.Hobby__c = 'Travel';
        acc.Numero_Passaporto__c = 'TEST';
        acc.Data_di_emissione_passaporto__c = Date.today();
        acc.Ente_di_emissione_passaporto__c = 'TEST';
        acc.Paese_di_emissione_passaporto__c = 'TEST';
        acc.Privacy1__c = true;
        acc.Privacy2__c = false;
        acc.Privacy3__c = true;
        acc.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();
        acc.PersonHasOptedOutOfEmail = false;
        acc.Registrazione_Al_Sito__c = true;
        acc.Telefono__c = false;
        acc.Email__c = true;
        acc.Posta__c = false;
        acc.Messaging__c = true;
        acc.WeChat__c = false;
        acc.Newsletter__c = true;
        acc.Country_Newsletter__c = 'IT';
        acc.Stato_Newsletter__c = 'NY';
        acc.Preferenza_newsletter__c = 'TEST';
        acc.Lingua__c = 'TEST';
        acc.First_ID_Location__c = 'TEST';
        acc.First_Location__c = 'TEST';
        // acc.Associate_di_registrazione__c = 'TEST';
        // acc.Associate_Registrazione_ID__c = 'TEST';
        acc.Cellulare__c = false;
        acc.Social__c = true;
        acc.Telefono_Lavoro__c = false;
        insert acc;
        String body = REST_Salesforce_to_Mulesoft.buildPayload(acc.id);

        REST_Salesforce_to_Mulesoft.doPost(body);
    }


    @isTest
    public static void testPUTPos(){
        Mulesoft_Endpoint__c cs = new Mulesoft_Endpoint__c();
        cs.Endpoint__c = 'http://example.com/example/test';
        cs.Username__c = 'testun';
        cs.Password__c = 'testpw';
        cs.LIMIT__c='200';
        insert cs;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorPos());
        Account acc = new Account();
        
        acc.Id_Cliente_xStore__c = 'TEST';
        acc.Id_Cliente_Relate__c = 'TEST';
        acc.Id_Cliente__c = 'TEST';
        acc.Id_Cliente_DW__c = 'TEST';
        acc.Id_Cliente_MDM__c = 'TEST';
        acc.FirstName = 'TEST';
        acc.LastName = 'TEST';
        acc.Nome_UTF_8__c = 'TEST';
        acc.Cognome_UTF_8__c = 'TEST';
        acc.PersonMailingCountry = 'TEST';
        acc.PersonMailingStreet = 'TEST';
        acc.PersonMailingPostalCode = 'TEST';
        acc.PersonMailingCity = 'TEST';
        acc.PersonMailingState = 'TEST';
        acc.BillingCountry = 'TEST';
        acc.BillingStreet = 'TEST';
        acc.BillingPostalCode = 'TEST';
        acc.BillingCity = 'TEST';
        acc.BillingState = 'TEST';
        acc.PersonOtherCountry = 'TEST';
        acc.PersonOtherStreet = 'TEST';
        acc.PersonOtherPostalCode = 'TEST';
        acc.PersonOtherCity = 'TEST';
        acc.PersonOtherState = 'TEST';
        acc.ShippingCountry = 'TEST';
        acc.ShippingStreet = 'TEST';
        acc.ShippingPostalCode = 'TEST';
        acc.ShippingCity = 'TEST';
        acc.ShippingState = 'TEST';
        acc.Citta_UTF_8__c = 'TEST';
        acc.Indirizzo_UTF_8__c = 'TEST';
        acc.Natura_Giuridica__c = 'TEST';
        acc.PersonBirthdate = Date.today();
        acc.Nazionalita__c = 'TEST';
        acc.Data_Di_Registrazione__c = Date.today();
        acc.Data_Annullamento__c = Date.today();
        acc.Data_Registrazione_Newsletter__c = Date.today();
        acc.Data_Cancellazione_Newsletter__c = Date.today();
        acc.PersonEmail = 'test@test.com';
        acc.Email_Ecommerce__c = 'test@test.com';
        acc.Phone = 'TEST';
        acc.PersonOtherPhone = 'TEST';
        acc.PersonMobilePhone = 'TEST';
        acc.Fax = 'TEST';
        acc.Categoria_Cliente__c = 'TEST';
        acc.Categoria_Cliente_Proposta__c = 'TEST';
        acc.Sesso__c = 'TEST';
        acc.Fascia_Di_Eta__c = 'TEST';
        acc.Id_Location__c = 'TEST';
        acc.Professione__c = 'TEST';
        acc.Id_Associate__c = 'TEST';
        // acc.Id_Cliente_Salesforce__c = 'TEST';
        // acc.RecordTypeID = 'TEST';
        acc.Salutation = 'TEST';
        acc.customer_origin__c = 'Newsletter';
        acc.Hobby__c = 'Travel';
        acc.Numero_Passaporto__c = 'TEST';
        acc.Data_di_emissione_passaporto__c = Date.today();
        acc.Ente_di_emissione_passaporto__c = 'TEST';
        acc.Paese_di_emissione_passaporto__c = 'TEST';
        acc.Privacy1__c = true;
        acc.Privacy2__c = false;
        acc.Privacy3__c = true;
        acc.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();
        acc.PersonHasOptedOutOfEmail = false;
        acc.Registrazione_Al_Sito__c = true;
        acc.Telefono__c = false;
        acc.Email__c = true;
        acc.Posta__c = false;
        acc.Messaging__c = true;
        acc.WeChat__c = false;
        acc.Newsletter__c = true;
        acc.Country_Newsletter__c = 'IT';
        acc.Stato_Newsletter__c = 'NY';
        acc.Preferenza_newsletter__c = 'TEST';
        acc.Lingua__c = 'TEST';
        acc.First_ID_Location__c = 'TEST';
        acc.First_Location__c = 'TEST';
        // acc.Associate_di_registrazione__c = 'TEST';
        // acc.Associate_Registrazione_ID__c = 'TEST';
        acc.Cellulare__c = false;
        acc.Social__c = true;
        acc.Telefono_Lavoro__c = false;
        insert acc;
        String body = REST_Salesforce_to_Mulesoft.buildPayload(acc.id);        
        REST_Salesforce_to_Mulesoft.doPut(body);
    }

    @isTest
    public static void testPUTNeg(){
        Mulesoft_Endpoint__c cs = new Mulesoft_Endpoint__c();
        cs.Endpoint__c = 'http://example.com/example/test';
        cs.Username__c = 'testun';
        cs.Password__c = 'testpw';
        cs.LIMIT__c='200';
        insert cs;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGeneratorNeg());
        Account acc = new Account();
        
        acc.Id_Cliente_xStore__c = 'TEST';
        acc.Id_Cliente_Relate__c = 'TEST';
        acc.Id_Cliente__c = 'TEST';
        acc.Id_Cliente_DW__c = 'TEST';
        acc.Id_Cliente_MDM__c = 'TEST';
        acc.FirstName = 'TEST';
        acc.LastName = 'TEST';
        acc.Nome_UTF_8__c = 'TEST';
        acc.Cognome_UTF_8__c = 'TEST';
        acc.PersonMailingCountry = 'TEST';
        acc.PersonMailingStreet = 'TEST';
        acc.PersonMailingPostalCode = 'TEST';
        acc.PersonMailingCity = 'TEST';
        acc.PersonMailingState = 'TEST';
        acc.BillingCountry = 'TEST';
        acc.BillingStreet = 'TEST';
        acc.BillingPostalCode = 'TEST';
        acc.BillingCity = 'TEST';
        acc.BillingState = 'TEST';
        acc.PersonOtherCountry = 'TEST';
        acc.PersonOtherStreet = 'TEST';
        acc.PersonOtherPostalCode = 'TEST';
        acc.PersonOtherCity = 'TEST';
        acc.PersonOtherState = 'TEST';
        acc.ShippingCountry = 'TEST';
        acc.ShippingStreet = 'TEST';
        acc.ShippingPostalCode = 'TEST';
        acc.ShippingCity = 'TEST';
        acc.ShippingState = 'TEST';
        acc.Citta_UTF_8__c = 'TEST';
        acc.Indirizzo_UTF_8__c = 'TEST';
        acc.Natura_Giuridica__c = 'TEST';
        acc.PersonBirthdate = Date.today();
        acc.Nazionalita__c = 'TEST';
        acc.Data_Di_Registrazione__c = Date.today();
        acc.Data_Annullamento__c = Date.today();
        acc.Data_Registrazione_Newsletter__c = Date.today();
        acc.Data_Cancellazione_Newsletter__c = Date.today();
        acc.PersonEmail = 'test@test.com';
        acc.Email_Ecommerce__c = 'test@test.com';
        acc.Phone = 'TEST';
        acc.PersonOtherPhone = 'TEST';
        acc.PersonMobilePhone = 'TEST';
        acc.Fax = 'TEST';
        acc.Categoria_Cliente__c = 'TEST';
        acc.Categoria_Cliente_Proposta__c = 'TEST';
        acc.Sesso__c = 'TEST';
        acc.Fascia_Di_Eta__c = 'TEST';
        acc.Id_Location__c = 'TEST';
        acc.Professione__c = 'TEST';
        acc.Id_Associate__c = 'TEST';
        // acc.Id_Cliente_Salesforce__c = 'TEST';
        // acc.RecordTypeID = 'TEST';
        acc.Salutation = 'TEST';
        acc.customer_origin__c = 'Newsletter';
        acc.Hobby__c = 'Travel';
        acc.Numero_Passaporto__c = 'TEST';
        acc.Data_di_emissione_passaporto__c = Date.today();
        acc.Ente_di_emissione_passaporto__c = 'TEST';
        acc.Paese_di_emissione_passaporto__c = 'TEST';
        acc.Privacy1__c = true;
        acc.Privacy2__c = false;
        acc.Privacy3__c = true;
        acc.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();
        acc.PersonHasOptedOutOfEmail = false;
        acc.Registrazione_Al_Sito__c = true;
        acc.Telefono__c = false;
        acc.Email__c = true;
        acc.Posta__c = false;
        acc.Messaging__c = true;
        acc.WeChat__c = false;
        acc.Newsletter__c = true;
        acc.Country_Newsletter__c = 'IT';
        acc.Stato_Newsletter__c = 'NY';
        acc.Preferenza_newsletter__c = 'TEST';
        acc.Lingua__c = 'TEST';
        acc.First_ID_Location__c = 'TEST';
        acc.First_Location__c = 'TEST';
        // acc.Associate_di_registrazione__c = 'TEST';
        // acc.Associate_Registrazione_ID__c = 'TEST';
        acc.Cellulare__c = false;
        acc.Social__c = true;
        acc.Telefono_Lavoro__c = false;
        insert acc;
        String body = REST_Salesforce_to_Mulesoft.buildPayload(acc.id);
        // String body ='{"PayLoad": {}}';
        REST_Salesforce_to_Mulesoft.doPut(body);
    }


    

}