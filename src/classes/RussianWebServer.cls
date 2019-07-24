public class RussianWebServer {

    public static void RussianWebServerXMLInvocation(RussianWebServerLog__c log){
        try{
        log.ResubmitNumber__c = log.ResubmitNumber__c + 1;
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml; charset=UTF-8');
        req.setHeader('SOAPAction', 'blank');
        req.setEndpoint('https://srvesb.brunellocucinelli.com:8085/secured/dispatch/russia/CustomerServicesApi/addOrUpdateCustomer');
        req.setTimeout(10000); // timeout in milliseconds
        req.setBody(log.XMLRequest__c);
        Http http = new Http();             
        HTTPResponse res = http.send(req);
        system.debug('DEBUG@ RESPONSE: ' + res);
        system.debug('DEBUG@ RESPONSE BODY: ' + res.getBody());
        system.debug('DEBUG@ RESPONSE STATUS: ' + res.getStatus());
        system.debug('DEBUG@ RESPONSE STATUS CODE: ' + res.getStatusCode());
        log.HttpResponseCode__c = res.getStatusCode();
        log.XMLResponse__c = res.getBody();
        log.ErrorMessage__c = '';
        update log;
        }
        catch(Exception e){
            System.debug(e);
            log.ErrorMessage__c = e.getMessage();
            update log;
            
        }
    }    
public static void RussianWebServerInvocation(Account acc){
    RussianWebServerLog__c log = new RussianWebServerLog__c();
    
	log.Name = acc.Id;
    log.ResubmitNumber__c = 0;
	User user = [SELECT id,Alias FROM User WHERE Id=:UserInfo.getUserId()];
    
    try{
            String xml_storeId = (acc.Id_Location__c == null ? '' : acc.Id_Location__c);
            String xml_name = (acc.FirstName == null ? '' : acc.FirstName);
            String xml_lastName = (acc.LastName == null ? '' : acc.LastName);
            String xml_salutation = (acc.Salutation == null ? '' : acc.Salutation);
            String xml_personMailingStreet = (acc.PersonMailingStreet == null ? '' : acc.PersonMailingStreet);
            String xml_personMailingCity = (acc.PersonMailingCity == null ? '' : acc.PersonMailingCity);
            String xml_personMailingCountry = (acc.PersonMailingCountry == null ? '' : acc.PersonMailingCountry);
			String xml_personMailingPostalCode = (acc.PersonMailingPostalCode == null ? '' : acc.PersonMailingPostalCode);
            String xml_email = (acc.PersonEmail == null ? '' : acc.PersonEmail);
			String xml_phone = (acc.Phone == null ? '' : acc.Phone);
			String xml_sesso = (acc.Sesso__c == null ? '' : acc.Sesso__c);
			String xml_birthdate = (acc.PersonBirthdate == null ? '' : Datetime.newInstance(acc.PersonBirthdate, Time.newInstance(0,0,0,0)).format('yyyy-MM-dd'));
            String xml_language = (acc.Lingua__c == null ? '' : acc.Lingua__c);
            String xml_PhoneContact = (acc.Telefono__c == null || acc.Telefono__c == false ? 'false' : 'true');
			String xml_EmailContact = (acc.Email__c == null || acc.Email__c == false ? 'false' : 'true');
            String xml_PostalContact = (acc.Posta__c == null || acc.Posta__c == false ? 'false' : 'true');
			String xml_xStroreId = (acc.Id_Cliente_xStore__c == null ? '' : acc.Id_Cliente_xStore__c);
			String xml_occupation = (acc.Professione__c == null ? '' : acc.Professione__c);
            String xml_nationality = (acc.Nazionalita__c == null ? '' : acc.Nazionalita__c);
			String xml_marketingBC = (acc.Privacy1__c == null || acc.Privacy1__c == false ? 'FALSE' : 'TRUE'); 
            String xml_marketingBCGroup = (acc.Privacy2__c == null || acc.Privacy2__c == false ? 'FALSE' : 'TRUE');
            String xml_marketingProfile = (acc.Privacy3__c == null || acc.Privacy3__c == false ? 'FALSE' : 'TRUE');
            String xml_SMS = (acc.Social__c == null || acc.Social__c == false ? 'FALSE' : 'TRUE');
            String xml_istantMessage = (acc.Messaging__c == null || acc.Messaging__c == false ? 'FALSE' : 'TRUE');
			String xml_registrationDate= (acc.Data_Di_Registrazione__c == null ? '' : Datetime.newInstance(acc.Data_Di_Registrazione__c, Time.newInstance(0,0,0,0)).format('yyyy-MM-dd'));
			String xml_now = Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX');
            String xml_ageRange = (acc.Fascia_Di_Eta__c == null ? '' : acc.Fascia_Di_Eta__c);
            
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setHeader('Content-Type', 'text/xml; charset=UTF-8');
            req.setHeader('SOAPAction', 'blank');
            req.setEndpoint('https://srvesb.brunellocucinelli.com:8085/secured/dispatch/russia/CustomerServicesApi/addOrUpdateCustomer'); 
           	 
          String xml = '<?xml version="1.0" encoding="UTF-8"?>'+
            	'<S:Envelope xmlns:S="http://schemas.xmlsoap.org/soap/envelope/">'+
                '  <S:Body>'+
                	'<ns2:addOrUpdateCustomer xmlns:ns2="http://v2_3.customer.webservices.csx.dtv.com/">'+
                		'<customerData>'+
                			'<RetailStoreID>'+xml_storeId+'</RetailStoreID>'+
                			'<Instrument />'+
                			'<BusinessName>Brunello Cucinelli S.P.A.</BusinessName>'+
                			'<Prospect>false</Prospect>'+
                			'<LastUpdateInfo>'+
                				'<UpdateUserID>'+'SF - '+ user.Alias+'</UpdateUserID>'+
                				'<UpdateDate>'+xml_now+'</UpdateDate>'+
                			'</LastUpdateInfo>'+
                '        <Affiliation>'+
                '          <RetailStoreID>'+xml_storeId+'</RetailStoreID>'+
                '        </Affiliation>'+
                '        <EntityInformation>'+
                '          <Individual>'+
                '            <Name>'+
                '              <Name Location="First">'+xml_name+'</Name>'+
                '              <Name Location="Last">'+xml_lastName+'</Name>'+
                '            </Name>'+
                '            <Salutation>'+xml_salutation+'</Salutation>'+
                '            <ContactInformation>'+
                '              <Address ContactPreferenceCode="Y" PrimaryFlag="true" TypeCode="HOME">'+
                '                <AddressLine1>'+xml_personMailingStreet+'</AddressLine1>'+
                '                <AddressLine2>-</AddressLine2>'+
                '                <AddressLine3>-</AddressLine3>'+
                '                <AddressLine4>-</AddressLine4>'+
                '                <ApartmentNumber>-</ApartmentNumber>'+
                '                <City>'+xml_personMailingCity+'</City>'+
                '                <Country>'+xml_personMailingCountry+'</Country>'+
                '                <Territory></Territory>'+
                '                <PostalCode>'+xml_personMailingPostalCode+'</PostalCode>'+
                '              </Address>'+
                '              <EMail ContactPreferenceCode="N" PrimaryFlag="true" TypeCode="Home">'+
                '                <EMailAddress>'+xml_email+'</EMailAddress>'+
                '              </EMail>'+
                '              <Telephone ContactPreferenceCode="N" PrimaryFlag="true" TypeCode="HOME">'+
                '                <PhoneNumber>'+xml_phone+'</PhoneNumber>'+
                '              </Telephone>'+
                '            </ContactInformation>'+
                '            <PersonalSummary>'+
                '              <GenderType>'+xml_sesso+'</GenderType>'+
                '              <BirthDate>'+xml_birthdate+'</BirthDate>'+
                '              <Rent>false</Rent>'+
                '              <LanguageCode>'+xml_language+'</LanguageCode>'+
                '            </PersonalSummary>'+
                '          </Individual>'+
                '        </EntityInformation>'+
                '        <PersonalPreferences>'+
                '          <ContactPreference ContactType="Email" Permission="'+xml_EmailContact+'" />'+
                '          <ContactPreference ContactType="Phone" Permission="'+xml_PhoneContact+'" />'+
                '          <ContactPreference ContactType="Mail" Permission="'+xml_PostalContact+'" />'+
                '        </PersonalPreferences>'+
                '        <CustomAttribute name="OCCUPATION">'+
                '          <AttributeValue>'+xml_occupation+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="NATIONALITY">'+
                '          <AttributeValue>'+xml_nationality+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="DATE_RANGE">'+
                '          <AttributeValue>'+xml_ageRange+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="MARKETING_BC_SPA_FLAG">'+
                '          <AttributeValue>'+xml_marketingBC+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="PROFILING_FLAG">'+
                '          <AttributeValue>'+xml_marketingProfile+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="MARKETING_BC_GROUP_FLAG">'+
                '          <AttributeValue>'+xml_marketingBCGroup+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="PHONE_CONTACT_FLAG">'+
                '          <AttributeValue>'+xml_PhoneContact+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="EMAIL_FLAG">'+
                '          <AttributeValue>'+xml_EmailContact+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="PAPER_MAIL_FLAG">'+
                '          <AttributeValue>'+xml_PostalContact+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="SMS_FLAG">'+
                '          <AttributeValue>'+xml_SMS+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="INSTANT_MESSAGING_FLAG">'+
                '          <AttributeValue>'+xml_istantMessage+'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="LAST_UPDATE">'+
                '          <AttributeValue>'+ xml_registrationDate +'</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="PARTY_TYPE_CODE">'+
                '          <AttributeValue>CUSTOMER</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="ACTIVE_FLAG">'+
                '          <AttributeValue>true</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <CustomAttribute name="PROMPT_TO_JOIN_LOYALTY">'+
                '          <AttributeValue>true</AttributeValue>'+
                '        </CustomAttribute>'+
                '        <SignupDate>'+xml_registrationDate+'</SignupDate>'+
                '      </customerData>'+
                '      <securityUserId>100</securityUserId>'+
                '    </ns2:addOrUpdateCustomer>'+
                '  </S:Body>'+
                '</S:Envelope>';
            
        	log.XMLRequest__c = xml;
            req.setTimeout(10000); // timeout in milliseconds
            req.setBody(xml);
            Http http = new Http();             
            HTTPResponse res = http.send(req);
            system.debug('DEBUG@ RESPONSE: ' + res);
            system.debug('DEBUG@ RESPONSE BODY: ' + res.getBody());
            system.debug('DEBUG@ RESPONSE STATUS: ' + res.getStatus());
            system.debug('DEBUG@ RESPONSE STATUS CODE: ' + res.getStatusCode());
            
            
            log.HttpResponseCode__c = res.getStatusCode();
            log.XMLResponse__c = res.getBody();
        	insert log;
            
        }
        catch(Exception e){
            System.debug(e);
            log.ErrorMessage__c = e.getMessage();
            insert log;
            
        }
    }
}