public class RegistrationForm {
    
    //GENERATE PDF VARIABLE
    public static string PDFDatas {get; set;}
    public RegistrationForm(String contactCId){
        registerForm(contactCId);
    }
    
    
    public RegistrationForm(){
        String contactCId  =  ApexPages.CurrentPage().getParameters().get('ccId');
        registerForm(contactCId); 
    }
    public static void registerForm(String contactCId) {
        system.debug('Registration Form');
        //if(PDFDatas == null || PDFDatas == '') {
        if(!String.isBlank(contactCId)) {
            system.debug('Id:::: '+contactCId);
            list<Contact_Card__c> cc = [SELECT Id,htmlForPdf__c, Lingua__c, FirstName__c, LastName__c, Salutation__c, PersonMailingStreet__c, 
                                        PersonMailingCity__c, PersonMailingPostalCode__c, Phone__c, PersonMailingCountry__c, Nazionalita__c, 
                                        PersonEmail__c, PersonBirthdate__c, Sesso__c, Professione__c, Hobby__c, Privacy1__c,Privacy2__c,Privacy3__c, CreatedDate, Numero_Passaporto__c,
                                        Paese_di_emissione_passaporto__c,Data_di_emissione_passaporto__c,Ente_di_emissione_passaporto__c,PersonMailingState__c,Nome_UTF_8__c,Cognome_UTF_8__c,
                                        We_Chat_ID__c,Telefono__c,Email__c,WeChat__c,Posta__c,Messaging__c,Versione_DCC__c,PrivacyHeaderSignedText__c,LegalNoteSignedText1__c,LegalNoteSignedText2__c,LegalNoteSignedText3__c,
                                        Informativa_Body_SignedText__c,SignedLanguage__c,Informativa_Header_Label__c,
                                        //PALUMBO (START)
                                        BillingStreet__c,BillingState__c,BillingCity__c,BillingPostalCode__c,BillingCountry__c,OtherStreet__c,OtherState__c,OtherCity__c,
                                        OtherPostalCode__c,OtherCountry__c
                                        //PALUMBO (END)
                                        FROM Contact_Card__c WHERE Id = :contactCId LIMIT 1 ];
            list<Attachment> Firma = [SELECT Id, Name, ParentId, Parent.Type 
                                      FROM Attachment where Parent.Type = 'Contact_Card__c' AND parentId = :cc[0].id AND contenttype = 'image/png'];
            string locale = cc[0].Versione_DCC__c.substring(cc[0].Versione_DCC__c.indexOf('.')+1,cc[0].Versione_DCC__c.indexOf('.')+3);//Translation[0].Country_FRM__c;
            string HelpForLike;
            User userRecord = getUserInformation();
            string pdfLanguage = cc[0].SignedLanguage__c;
            
            if (pdfLanguage != null)
                HelpForLike = pdfLanguage+'_'+locale;
            else 
                HelpForLike = 'en'+'_'+locale;
            system.debug('HelpforLike:::: '+HelpForLike);
            system.debug('LINGUA:::: '+cc[0].Lingua__c);
            // VS - 11/05/2020 scommentare query e cancellare quella dopo in quanto non presente il campo Rich_Text_Registration__c
            // list<Translate__c> Translation = [SELECT Privacy_Yes_Label__c, Privacy_No_Label__c,First_Name_Label__c,Last_Name_Label__c, Salutation_Value__c,
            //                                   Street_Label__c, City_Label__c, CAP_Label__c, Country_Label__c, Phone_Label__c, Nationality_Label__c, 
            //                                   Birthdate_Label__c, Gender_Label__c, Profession_Label__c, Hobby_Label__c, Preferred_Language_Label__c, 
            //                                   Contact_Preferences_Label__c, Privacy_1_Label__c, Privacy_2_Label__c, Privacy_3_Label__c, Date_Label__c, Signature_Label__c,
            //                                   Language_Label__c, Email_Label__c, Salutation_Label__c, Passport_Section_Label__c, Numero_Passaporto_Label__c, Paese_di_emissione_passaporto_Label__c,
            //                                   Data_di_emissione_passaporto_Label__c,Ente_di_emissione_passaporto_Label__c, Country_FRM__c,State_Label__c,Local_First_Name_Label__c,Local_Last_Name_Label__c,
            //                                   We_Chat_ID_Label__c,Checkbox_Phone_Label__c,Checkbox_Email_Label__c,Checkbox_WeChat_Label__c,Checkbox_Mail_Label__c,
            //                                   Checkbox_Messaging_Label__c,Privacy_Header_Before_Link_Label__c,Privacy_Header_Link_Label__c,Privacy_Header_After_Link_Label__c,
            //                                   //PALUMBO (START)
            //                                   Button_Add_Address_Label__c, Billing_Address_Section_Label__c, Contact_Address_Section_Label__c, Other_Address_Section_Label__c,
            //                                   Street_Contact_Address_Label__c, City_Contact_Address_Label__c, CAP_Contact_Address_Label__c, Country_Contact_Address_Label__c,
            //                                   Street_Other_Address_Label__c, City_Other_Address_Label__c, State_Other_Address_Label__c, CAP_Other_Address_Label__c, 
            //                                   Country_Other_Address_Label__c, Rich_Text_Registration__c
            //                                   FROM Translate__c WHERE Name LIKE :HelpForLike];

            list<Translate__c> Translation = [SELECT Privacy_Yes_Label__c, Privacy_No_Label__c,First_Name_Label__c,Last_Name_Label__c, Salutation_Value__c,
                                              Street_Label__c, City_Label__c, CAP_Label__c, Country_Label__c, Phone_Label__c, Nationality_Label__c, 
                                              Birthdate_Label__c, Gender_Label__c, Profession_Label__c, Hobby_Label__c, Preferred_Language_Label__c, 
                                              Contact_Preferences_Label__c, Privacy_1_Label__c, Privacy_2_Label__c, Privacy_3_Label__c, Date_Label__c, Signature_Label__c,
                                              Language_Label__c, Email_Label__c, Salutation_Label__c, Passport_Section_Label__c, Numero_Passaporto_Label__c, Paese_di_emissione_passaporto_Label__c,
                                              Data_di_emissione_passaporto_Label__c,Ente_di_emissione_passaporto_Label__c, Country_FRM__c,State_Label__c,Local_First_Name_Label__c,Local_Last_Name_Label__c,
                                              We_Chat_ID_Label__c,Checkbox_Phone_Label__c,Checkbox_Email_Label__c,Checkbox_WeChat_Label__c,Checkbox_Mail_Label__c,
                                              Checkbox_Messaging_Label__c,Privacy_Header_Before_Link_Label__c,Privacy_Header_Link_Label__c,Privacy_Header_After_Link_Label__c,
                                              //PALUMBO (START)
                                              Button_Add_Address_Label__c, Billing_Address_Section_Label__c, Contact_Address_Section_Label__c, Other_Address_Section_Label__c,
                                              Street_Contact_Address_Label__c, City_Contact_Address_Label__c, CAP_Contact_Address_Label__c, Country_Contact_Address_Label__c,
                                              Street_Other_Address_Label__c, City_Other_Address_Label__c, State_Other_Address_Label__c, CAP_Other_Address_Label__c, 
                                              Country_Other_Address_Label__c, DateBirthday_Label__c, Month_Label__c,State_Contact_Address_Label__c
                                             FROM Translate__c WHERE Name LIKE :HelpForLike];
            system.debug('TRAN:::: '+Translation);
            system.debug('cc::: '+cc);
            system.debug('LOCALE::: '+locale);
            string datetimestr;
            string datetimestr2;
            integer length1;
            
            if(cc != null && cc.size() > 0 && cc[0].PersonBirthDate__c != null && locale == 'JP'){
                datetimestr = cc[0].CreatedDate.format('yyyy MMMMM dd');
                datetimestr2 = ((Datetime)cc[0].PersonBirthDate__c).format('yyyy MMMMM dd');
            }
            else if (cc != null && cc.size() > 0 && cc[0].PersonBirthDate__c != null && locale != 'JP'){
                 datetimestr = cc[0].CreatedDate.format('dd MMMMM yyyy');
                datetimestr2 = ((Datetime)cc[0].PersonBirthDate__c).format('dd MMMMM yyyy');
            }
            PDFDatas = cc[0].htmlForPdf__c.unescapeHtml4();
            
            PDFDatas = PDFDatas.replace('PreferredLanguagePlaceHolder', '<label>'+Translation[0].Preferred_Language_Label__c+' :  '+'</label><br>' +pdfLanguage);
            PDFDatas = PDFDatas.replacefirst('LanguagePlaceHolder','<label>'+ Translation[0].Language_Label__c+' :  '+'</label><br>' +pdfLanguage);
            PDFDatas = PDFDatas.replace('FirstNamePlaceHolder','<label>'+Translation[0].First_Name_Label__c+ ' :  '+'</label><br>' +cc[0].FirstName__c);
            PDFDatas = PDFDatas.replace('LastNamePlaceHolder','<label>'+ Translation[0].Last_Name_Label__c+' :  '+'</label><br>' +cc[0].LastName__c);
            if (locale == 'JP'|| locale == 'CN' || locale == 'RU' || locale == 'HK' || locale == 'MO' || cc[0].Lingua__c == 'ja'|| cc[0].Lingua__c == 'zhs' || cc[0].Lingua__c == 'zh' || cc[0].Lingua__c == 'ru' ){
                PDFDatas = PDFDatas.replace('LocalFNPlaceHolder','<label>'+Translation[0].Local_First_Name_Label__c+ ' :  '+'</label><br>' +cc[0].Nome_UTF_8__c);
                PDFDatas = PDFDatas.replace('LocalLNPlaceHolder','<label>'+ Translation[0].Local_Last_Name_Label__c+' :  '+'</label><br>' +cc[0].Cognome_UTF_8__c);
            }
            else{
                PDFDatas = PDFDatas.replace('LocalFNPlaceHolder','');
                PDFDatas = PDFDatas.replace('LocalLNPlaceHolder','');
            }
            PDFDatas = PDFDatas.replace('TitlePlaceHolder','<label>'+ Translation[0].Salutation_Label__c+' :  '+'</label><br>' +cc[0].Salutation__c);

             //PALUMBO (START)

            // CONTACT ADDRESS
            if (locale == 'JP'){
				PDFDatas = PDFDatas.replace('ContactAddressPlaceHolder','<label>'+ Translation[0].CAP_Contact_Address_Label__c+' :  '+'</label><br>' +cc[0].BillingPostalCode__c); 
				PDFDatas = PDFDatas.replace('ContactCityPlaceHolder','<label>'+ Translation[0].State_Contact_Address_Label__c+' :  '+'</label><br>' +cc[0].BillingState__c);
                PDFDatas = PDFDatas.replace('ContactPostalStatePlaceHolder','<label>'+ Translation[0].City_Contact_Address_Label__c+' :  ' +'</label><br>'+cc[0].BillingCity__c);

            }
            else{
                PDFDatas = PDFDatas.replace('ContactAddressPlaceHolder','<label>'+ Translation[0].Street_Contact_Address_Label__c+' :  '+'</label><br>' +cc[0].BillingStreet__c);
                PDFDatas = PDFDatas.replace('ContactCityPlaceHolder','<label>'+ Translation[0].City_Contact_Address_Label__c+' :  ' +'</label><br>'+cc[0].BillingCity__c);
                PDFDatas = PDFDatas.replace('ContactPostalCodePlaceHolder','<label>'+ Translation[0].CAP_Label__c+' :  '+'</label><br>' +cc[0].BillingPostalCode__c); 
            }
           
            if (locale == 'US')
                PDFDatas = PDFDatas.replace('ContactPostalStatePlaceHolder','<label>'+ Translation[0].State_Contact_Address_Label__c+' :  '+'</label><br>' +cc[0].BillingState__c);
            else if (locale == 'JP'){
				PDFDatas = PDFDatas.replace('ContactPostalCodePlaceHolder','<label>'+ Translation[0].Street_Contact_Address_Label__c+' :  '+'</label><br>' +cc[0].BillingStreet__c);

            }
            else{
                PDFDatas = PDFDatas.replace('<td class="field"> ContactPostalStatePlaceHolder </td>','');
            }

               
            PDFDatas = PDFDatas.replace('ContactCountryPlaceHolder','<label>'+ Translation[0].Country_Contact_Address_Label__c+' :  '+'</label><br>' +cc[0].BillingCountry__c);
            
            // OTHER CONTACT
            if (locale == 'JP'){
				PDFDatas = PDFDatas.replace('OtherAddressPlaceHolder','<label>'+ Translation[0].CAP_Other_Address_Label__c+' :  '+'</label><br>' +cc[0].OtherPostalCode__c); 
				PDFDatas = PDFDatas.replace('OtherCityPlaceHolder','<label>'+ Translation[0].State_Other_Address_Label__c+' :  '+'</label><br>' +cc[0].OtherState__c);
                PDFDatas = PDFDatas.replace('OtherPostalStatePlaceHolder','<label>'+ Translation[0].City_Other_Address_Label__c+' :  ' +'</label><br>'+cc[0].OtherCity__c);

            }
            else{
                PDFDatas = PDFDatas.replace('OtherAddressPlaceHolder','<label>'+ Translation[0].Street_Other_Address_Label__c+' :  '+'</label><br>' +cc[0].OtherStreet__c);
                PDFDatas = PDFDatas.replace('OtherCityPlaceHolder','<label>'+ Translation[0].City_Other_Address_Label__c+' :  ' +'</label><br>'+cc[0].OtherCity__c);
                PDFDatas = PDFDatas.replace('OtherPostalCodePlaceHolder','<label>'+ Translation[0].CAP_Other_Address_Label__c+' :  '+'</label><br>' +cc[0].OtherPostalCode__c); 
            }
           
            if (locale == 'US')
                PDFDatas = PDFDatas.replace('OtherPostalStatePlaceHolder','<label>'+ Translation[0].State_Other_Address_Label__c+' :  '+'</label><br>' +cc[0].OtherState__c);
            else if (locale == 'JP'){
				PDFDatas = PDFDatas.replace('OtherPostalCodePlaceHolder','<label>'+ Translation[0].Street_Other_Address_Label__c+' :  '+'</label><br>' +cc[0].OtherStreet__c);

            }
            else{
                PDFDatas = PDFDatas.replace('<td class="field"> OtherPostalStatePlaceHolder </td>','');
            }

               
            PDFDatas = PDFDatas.replace('OtherCountryPlaceHolder','<label>'+ Translation[0].Country_Other_Address_Label__c+' :  '+'</label><br>' +cc[0].OtherCountry__c);

            // BILLING ADDRESS
            if (locale == 'JP'){
				PDFDatas = PDFDatas.replace('AddressPlaceHolder','<label>'+ Translation[0].CAP_Label__c+' :  '+'</label><br>' +cc[0].PersonMailingPostalCode__c); 
				PDFDatas = PDFDatas.replace('CityPlaceHolder','<label>'+ Translation[0].State_Label__c+' :  '+'</label><br>' +cc[0].PersonMailingState__c);
                PDFDatas = PDFDatas.replace('PostalStatePlaceHolder','<label>'+ Translation[0].City_Label__c+' :  ' +'</label><br>'+cc[0].PersonMailingCity__c);

            }
            else{
                PDFDatas = PDFDatas.replace('AddressPlaceHolder','<label>'+ Translation[0].Street_Label__c+' :  '+'</label><br>' +cc[0].PersonMailingStreet__c);
                PDFDatas = PDFDatas.replace('CityPlaceHolder','<label>'+ Translation[0].City_Label__c+' :  ' +'</label><br>'+cc[0].PersonMailingCity__c);
                PDFDatas = PDFDatas.replace('PostalCodePlaceHolder','<label>'+ Translation[0].CAP_Label__c+' :  '+'</label><br>' +cc[0].PersonMailingPostalCode__c); 
            }
           
            if (locale == 'US')
                PDFDatas = PDFDatas.replace('PostalStatePlaceHolder','<label>'+ Translation[0].State_Label__c+' :  '+'</label><br>' +cc[0].PersonMailingState__c);
            else if (locale == 'JP'){
				PDFDatas = PDFDatas.replace('PostalCodePlaceHolder','<label>'+ Translation[0].Street_Label__c+' :  '+'</label><br>' +cc[0].PersonMailingStreet__c);

            }
            else{
                PDFDatas = PDFDatas.replace('<td class="field"> PostalStatePlaceHolder </td>','');
            }

               
            PDFDatas = PDFDatas.replace('CountryPlaceHolder','<label>'+ Translation[0].Country_Label__c+' :  '+'</label><br>' +cc[0].PersonMailingCountry__c);
            
            //PALUMBO (END)
         
            
            PDFDatas = PDFDatas.replace('ContactPreferencesPlaceHolder','<label>'+ Translation[0].Contact_Preferences_Label__c+'</label><br>');
            if (cc[0].Telefono__c == true){
                PDFDatas = PDFDatas.replace('TelCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_Phone_Label__c+' :  '+'</label> <img src="/img/checkbox_checked.gif"/> ');
            }
            else{
                PDFDatas = PDFDatas.replace('TelCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_Phone_Label__c+' :  '+'</label> <img src="/img/checkbox_unchecked.gif"/> ');
            }
            if (locale == 'CN' || cc[0].Lingua__c == 'zhs' || cc[0].Lingua__c == 'zh'){
                if (cc[0].WeChat__c == true){
                    PDFDatas = PDFDatas.replace('WeChatCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_WeChat_Label__c+' :  '+'</label> <img src="/img/checkbox_checked.gif"/> ');
                }
                else{
                    PDFDatas = PDFDatas.replace('WeChatCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_WeChat_Label__c+' :  '+'</label> <img src="/img/checkbox_unchecked.gif"/> ');
                }
            }
            else{
                PDFDatas = PDFDatas.replace('<td> WeChatCheckboxPlaceHolder </td>','');
            }
            if (cc[0].Email__c == true){
                PDFDatas = PDFDatas.replace('EmailCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_Email_Label__c+' :  '+'</label> <img src="/img/checkbox_checked.gif"/> ');
            }
            else{
                PDFDatas = PDFDatas.replace('EmailCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_Email_Label__c+' :  '+'</label> <img src="/img/checkbox_unchecked.gif"/> ');
            }
            if (cc[0].Posta__c == true){
                PDFDatas = PDFDatas.replace('PostaCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_Mail_Label__c+' :  '+'</label> <img src="/img/checkbox_checked.gif"/> ');
            }
            else{
                PDFDatas = PDFDatas.replace('PostaCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_Mail_Label__c+' :  '+'</label> <img src="/img/checkbox_unchecked.gif"/> ');
            }
            if (cc[0].Messaging__c == true){
                PDFDatas = PDFDatas.replace('MessCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_Messaging_Label__c+' :  '+'</label> <img src="/img/checkbox_checked.gif"/> ');
            }
            else{
                PDFDatas = PDFDatas.replace('MessCheckboxPlaceHolder','<label>'+ Translation[0].Checkbox_Messaging_Label__c+' :  '+'</label> <img src="/img/checkbox_unchecked.gif"/> ');
            }
            
            
            PDFDatas = PDFDatas.replace('PhonePlaceHolder','<label>'+ Translation[0].Phone_Label__c.substringBefore('(')+' :  '+'</label><br>' +cc[0].Phone__c);
            PDFDatas = PDFDatas.replace('NationalityPlaceHolder','<label>'+ Translation[0].Nationality_Label__c+' :  '+'</label><br>' +cc[0].Nazionalita__c);
            PDFDatas = PDFDatas.replace('EmailPlaceHolder','<label>'+ Translation[0].Email_Label__c+' :  '+'</label><br>' +cc[0].PersonEmail__c);
            if (locale == 'CN' || cc[0].Lingua__c == 'zh')
                PDFDatas = PDFDatas.replace('WeChatPlaceHolder','<label>'+ Translation[0].We_Chat_ID_Label__c+' :  '+'</label><br>' +cc[0].We_Chat_ID__c);
            else{
                PDFDatas = PDFDatas.replace('<td class="field"> WeChatPlaceHolder </td>','');
            }
            PDFDatas = PDFDatas.replace('DatePlaceHolder','<label>'+ Translation[0].Date_Label__c+' '+'</label><br>' +datetimestr);
            PDFDatas = PDFDatas.replace('DateofBirthPlaceHolder','<label>'+ Translation[0].Birthdate_Label__c+' :  '+'</label><br>' +datetimestr2 );
            
            PDFDatas = PDFDatas.replace(Translation[0].Date_Label__c+' ' +datetimestr+Translation[0].Birthdate_Label__c.substring(Translation[0].Date_Label__c.length(), Translation[0].Birthdate_Label__c.length() ), Translation[0].Birthdate_Label__c+' :  ' +datetimestr2);
            
            PDFDatas = PDFDatas.replace('GenderPlaceHolder','<label>'+ Translation[0].Gender_Label__c+' :  '+'</label><br>' +cc[0].Sesso__c);
            PDFDatas = PDFDatas.replace('ProfessionPlaceHolder', '<label>'+Translation[0].Profession_Label__c+' :  '+'</label><br>' +cc[0].Professione__c);
            PDFDatas = PDFDatas.replace('HobbyPlaceHolder', '<label>'+Translation[0].Hobby_Label__c+' :  '+'</label><br>' +cc[0].Hobby__c);
            //PDFDatas = PDFDatas.replace(Translation[0].Passport_Section_Label__c, '');
            // VS - 11/05/2020
            // PDFDatas = PDFDatas.replace('PassportNumberPlaceHolder', '<label>'+Translation[0].Numero_Passaporto_Label__c+' :  '+'</label><br>' +cc[0].Numero_Passaporto__c);
            // PDFDatas = PDFDatas.replace('PassportCPlaceHolder', '<label>'+Translation[0].Paese_di_emissione_passaporto_Label__c+' :  '+'</label><br>' +cc[0].Paese_di_emissione_passaporto__c);
            if (locale == 'RU'){
                PDFDatas = PDFDatas.replace('PassportIssuedFromPlaceHolder', '<label>'+Translation[0].Ente_di_emissione_passaporto_Label__c+' :  '+'</label><br>' +cc[0].Ente_di_emissione_passaporto__c);
                PDFDatas = PDFDatas.replace('PassportIssuedDPlaceHolder', '<label>'+Translation[0].Data_di_emissione_passaporto_Label__c+' :  '+'</label><br>' +cc[0].Data_di_emissione_passaporto__c);
            }
            else
            {
                PDFDatas = PDFDatas.replace('PassportIssuedFromPlaceHolder', '');
                PDFDatas = PDFDatas.replace('PassportIssuedDPlaceHolder', '');
            }
            
            PDFDatas = PDFDatas.replace('PrivacyHeaderPlaceHolder','<b>'+cc[0].PrivacyHeaderSignedText__c+'</b>');
            
            
            PDFDatas = PDFDatas.replace('LegalNotePlaceHolder1',''+cc[0].LegalNoteSignedText1__c );
            PDFDatas = PDFDatas.replace('LegalNotePlaceHolder2', ''+cc[0].LegalNoteSignedText2__c );
            PDFDatas = PDFDatas.replace('LegalNotePlaceHolder3', ''+cc[0].LegalNoteSignedText3__c );
            
            PDFDatas = PDFDatas.replace('<p class="field">SignaturePlaceHolder</p>', '<div class="labelSignature">' + Translation[0].Signature_Label__c +'</div> <br>' +'<img src="/servlet/servlet.FileDownload?file='+Firma[0].id+'"/> ');
            
            PDFDatas = PDFDatas.replace('InformativaPrivacyPlaceHolder', ''+'<span class="fieldbold">'+cc[0].Informativa_Header_Label__c+'</span> <br>'+cc[0].Informativa_Body_SignedText__c );
            
            
            PDFDatas = PDFDatas.replaceall('null', 'N/A');
        }
        
    }
    
    @AuraEnabled
    public static map<String,Translate__c> getTranslatorForm(String locale){
        Map<String,Translate__c> Mymap = new Map<String,Translate__c>();
        system.debug('LOCALE --->' + locale);
            // VS - 11/05/2020 scommentare query e cancellare quella dopo in quanto non presente il campo Rich_Text_Registration__c,Cancel_Heading__c
        // for(Translate__c obj : [SELECT Id, Name, Subheader_Label__c, Language_Label__c, Salutation_Label__c,
        //                         First_Name_Label__c, First_Name_Placeholder__c, Last_Name_Label__c, Last_Name_Placeholder__c,
        //                         Street_Label__c, Street_Placeholder__c, City_Label__c, City_Placeholder__c,Hobby_Values__c,
        //                         State_Label__c, State_Placeholder__c, CAP_Label__c, CAP_Placeholder__c,Gender_Values__c,
        //                         Country_Label__c, Country_Placeholder__c, Phone_Label__c, Phone_Placeholder__c,Profession_Values__c,
        //                         Mobile_Label__c, Mobile_Placeholder__c, Email_Label__c, Email_Placeholder__c, We_Chat_ID_Label__c, We_Chat_ID_Placeholder__c,
        //                         Checkbox_Phone_Label__c, Contact_Preferences_Label__c, Checkbox_Email_Label__c, Checkbox_Mail_Label__c, Checkbox_WeChat_Label__c,
        //                         Checkbox_Messaging_Label__c, Checkbox_Other_Placeholder__c, Birthdate_Label__c, Gender_Label__c, Nationality_Label__c, Preferred_Language_Label__c,
        //                         Privacy_Header_Label__c, Privacy_Header_Before_Link_Label__c, Privacy_Header_Link_Label__c,
        //                         Privacy_Header_After_Link_Label__c, Privacy_Yes_Label__c, Privacy_No_Label__c, Privacy_1_Label__c,
        //                         Privacy_2_Label__c, Privacy_2_Label_Department__c, Privacy_3_Label__c, Privacy_Footer_Label__c, Date_Label__c, Signature_Label__c,
        //                         Signature_Asterisco_Label__c, Button_Signature_Clear_Label__c, Button_Signature_Save_Label__c, Button_Form_Registration_Label__c,
        //                         Informativa_Header_Label__c, Informativa_Body_Rich_Label__c, Informativa_Body_Rich_Label_Department__c,
        //                         Profession_Label__c, Hobby_Label__c,  Passport_Section_Label__c, Numero_Passaporto_Label__c, Paese_di_emissione_passaporto_Label__c,
        //                         Local_First_Name_Label__c, Local_Last_Name_Label__c, Button_Back_Label__c,Versione_DCC__c,Richiedi_Firma__c,Success_Message_Label__c,Data_di_emissione_passaporto_Label__c,
        //                         Ente_di_emissione_passaporto_Label__c, Button_Generate_Barcode_Label__c,Salutation_Value__c,
        //                         //PALUMBO (START)
        //                         Button_Add_Address_Label__c, Billing_Address_Section_Label__c, Contact_Address_Section_Label__c, Other_Address_Section_Label__c,
        //                         Street_Contact_Address_Label__c, City_Contact_Address_Label__c, CAP_Contact_Address_Label__c, Country_Contact_Address_Label__c,
        //                         Street_Other_Address_Label__c, City_Other_Address_Label__c, State_Other_Address_Label__c, CAP_Other_Address_Label__c, 
        //                         Country_Other_Address_Label__c,State_Contact_Address_Label__c, Cancel_Heading__c, Create_Customer_Heading__c, Rich_Text_Registration__c, Create_Customer_Button__c, Label_Section_Passport__c, Submit_Button__c 
        //                         //PALUMBO (END)
        //                         FROM Translate__c WHERE Country_FRM__c = :locale]) {
        //                             Mymap.put(obj.Name, obj );
        //                         }
        
        for(Translate__c obj : [SELECT Id, Name, Subheader_Label__c, Language_Label__c, Salutation_Label__c,
                                First_Name_Label__c, First_Name_Placeholder__c, Last_Name_Label__c, Last_Name_Placeholder__c,
                                Street_Label__c, Street_Placeholder__c, City_Label__c, City_Placeholder__c,Hobby_Values__c,
                                State_Label__c, State_Placeholder__c, CAP_Label__c, CAP_Placeholder__c,Gender_Values__c,
                                Country_Label__c, Country_Placeholder__c, Phone_Label__c, Phone_Placeholder__c,Profession_Values__c,
                                Mobile_Label__c, Mobile_Placeholder__c, Email_Label__c, Email_Placeholder__c, We_Chat_ID_Label__c, We_Chat_ID_Placeholder__c,
                                Checkbox_Phone_Label__c, Contact_Preferences_Label__c, Checkbox_Email_Label__c, Checkbox_Mail_Label__c, Checkbox_WeChat_Label__c,
                                Checkbox_Messaging_Label__c, Checkbox_Other_Placeholder__c, Birthdate_Label__c, Gender_Label__c, Nationality_Label__c, Preferred_Language_Label__c,
                                Privacy_Header_Label__c, Privacy_Header_Before_Link_Label__c, Privacy_Header_Link_Label__c,
                                Privacy_Header_After_Link_Label__c, Privacy_Yes_Label__c, Privacy_No_Label__c, Privacy_1_Label__c,Privacy_1_Label_Department__c, 
                                Privacy_2_Label__c, Privacy_2_Label_Department__c, Privacy_3_Label__c, Privacy_Footer_Label__c, Date_Label__c, Signature_Label__c,
                                Signature_Asterisco_Label__c, Button_Signature_Clear_Label__c, Button_Signature_Save_Label__c, Button_Form_Registration_Label__c,
                                Informativa_Header_Label__c, Informativa_Body_Rich_Label__c, Informativa_Body_Rich_Label_Department__c,
                                Profession_Label__c, Hobby_Label__c,  Passport_Section_Label__c, Numero_Passaporto_Label__c, Paese_di_emissione_passaporto_Label__c,
                                Local_First_Name_Label__c, Local_Last_Name_Label__c, Button_Back_Label__c,Versione_DCC__c,Richiedi_Firma__c,Success_Message_Label__c,Data_di_emissione_passaporto_Label__c,
                                Ente_di_emissione_passaporto_Label__c, Button_Generate_Barcode_Label__c,Salutation_Value__c,
                                //PALUMBO (START)
                                Button_Add_Address_Label__c, Billing_Address_Section_Label__c, Contact_Address_Section_Label__c, Other_Address_Section_Label__c,
                                Street_Contact_Address_Label__c, City_Contact_Address_Label__c, CAP_Contact_Address_Label__c, Country_Contact_Address_Label__c,
                                Street_Other_Address_Label__c, City_Other_Address_Label__c, State_Other_Address_Label__c, CAP_Other_Address_Label__c, 
                                Country_Other_Address_Label__c,State_Contact_Address_Label__c, DateBirthday_Label__c, Month_Label__c
                                //PALUMBO (END)
                                FROM Translate__c WHERE Country_FRM__c = :locale]) {
                                    Mymap.put(obj.Name, obj );
                                }
        
        return Mymap;
    }
    
    @AuraEnabled
    public static Map < String, String > getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        Map < String, String > allOpts = new Map < String, String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        system.debug('values --->' + values);
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            if(fld =='Nazionalita__c') {
                allOpts.put(a.getLabel().touppercase(), a.getValue());
            }else{
                allOpts.put(a.getLabel(), a.getValue());
            }
            
        }
        system.debug('allOpts ---->' + allOpts);
        
        return allOpts;
    }
    
    @AuraEnabled
    public static String saveNewAccount(Account account, String sPad64) {
        system.debug('ACCOUNT : ' + account);
        returnData insertAccount;
        try{
            User user = getUserInformation();
            if (user.Area_Contact_Card__c == 'RU'){
                RussianWebServer.RussianWebServerInvocation(account);
            }
        }
        catch(Exception ex){
            System.debug('Error during Russian Web Service Invocation: ' + ex.getMessage());
        }
        try{
            Savepoint sp = Database.setSavepoint();
            System.debug('dopo setSavePoint');
            insertAccount = (returnData)JSON.deserializeStrict( insertAccount(account), returnData.class);
            System.debug('returnData1OK');
            returnData insertContactCard = (returnData)JSON.deserializeStrict( insertContactCard(account, insertAccount.Id), returnData.class);
            returnData uploadSignResponse = (returnData)JSON.deserializeStrict( uploadSign(sPad64.replace('data:image/png;base64,', ''), insertContactCard.Id), returnData.class);
            System.debug('returnData2OK');
            if(!insertAccount.success || !uploadSignResponse.success) {
                Database.rollback(sp);
                return 'false';
            }
            
            system.debug('insertAccount: ' + insertAccount);
            system.debug('uploadSignResponse: ' + uploadSignResponse);
            
            
        }catch(Exception ex) {
                        System.debug(ex.getMessage());
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
        }
        
        
        return JSON.serialize(insertAccount);
        
    }
    
    @AuraEnabled
    public static String updateNewAccount(Account account, String sPad64) {
        returnData insertAccount;
        system.debug('ACCOUNT UPDATE: ' + account);
        try{
            //Savepoint sp = Database.setSavepoint();
            insertAccount = (returnData)JSON.deserializeStrict( updateAccount(account), returnData.class);
            returnData insertContactCard = (returnData)JSON.deserializeStrict( insertContactCard(account, insertAccount.Id), returnData.class);
            returnData uploadSignResponse = (returnData)JSON.deserializeStrict( uploadSign(sPad64.replace('data:image/png;base64,', ''), insertContactCard.Id), returnData.class);
            
            /*
if(!insertAccount.success || !uploadSignResponse.success){
Database.rollback(sp);
return 'false';
}
*/
            
            system.debug('insertAccount: ' + insertAccount);
            system.debug('uploadSignResponse: ' + uploadSignResponse);
        }catch(Exception ex) {
            throw new AuraHandledException('Something went wrong: '+ ex.getMessage());
        }
        
        
        return JSON.serialize(insertAccount);
        
    }
    
    @AuraEnabled
    public static User getUserInformation() {
        return [SELECT Id, Name, Nation_Contact_Card__c,Area_Contact_Card__c, Language_Contact_Card__c, Department__c, Codice_Boutique__c, Canale_di_Vendita__c FROM User WHERE Id =: UserInfo.getuserid() ];
    }
    @AuraEnabled
    public static Account getAccount(Id AccountId) {
        Account acc = new Account();
        try{
            system.debug('AccountId: ' + AccountId);
            
            if(AccountId != null ) {
                acc =  [SELECT Id, Salutation, FirstName, LastName, PersonMailingStreet, PersonMailingCountry, PersonMailingPostalCode, PersonMailingCity, PersonMailingState,
                        Nome_UTF_8__c,Cognome_UTF_8__c,Indirizzo_UTF_8__c,Citta_UTF_8__c,Messaging__c,Numero_Passaporto__c,
                        PersonEmail, We_Chat_ID__c, Phone, PersonMobilePhone, PersonBirthdate, Sesso__c, Nazionalita__c, Lingua__c, Telefono__c, Email__c, WeChat__c, Posta__c,
                        Other__c, Other_text__c, Privacy1__c, Privacy2__c, Privacy3__c,Professione__c, Hobby__c,Paese_di_emissione_passaporto__c,Versione_DCC__c,DCC__c,Ente_di_emissione_passaporto__c,
                        Data_di_emissione_passaporto__c,SignedLanguage__c,
                        // PALUMBO (START)
                        BillingStreet, BillingCountry,BillingPostalCode,BillingCity,BillingState,PersonOtherStreet,PersonOtherCity,PersonOtherState,PersonOtherPostalCode,
                        PersonOtherCountry, BillingAddress, PersonOtherAddress
                        // PALUMBO (END)
                        FROM Account WHERE Id =: AccountId ];
            }
            if(acc.PersonMailingStreet == null || acc.PersonMailingStreet =='') {
                if(acc.Indirizzo_UTF_8__c !=  null  ||  acc.Indirizzo_UTF_8__c != '' ) {
                    acc.PersonMailingStreet = acc.Indirizzo_UTF_8__c;
                }
            }
            if(acc.PersonMailingCity == null || acc.PersonMailingCity =='') {
                if(acc.Citta_UTF_8__c !=  null  ||  acc.Citta_UTF_8__c != '' ) {
                    acc.PersonMailingCity = acc.Citta_UTF_8__c;
                }
            }
            if(acc.PersonMailingState == null || acc.PersonMailingState =='') {
                if(acc.Province_UTF_8__c !=  null  ||  acc.Province_UTF_8__c != '' ) {
                    acc.PersonMailingState = acc.Province_UTF_8__c;
                }
            }
            if(acc.PersonMailingPostalCode == null || acc.PersonMailingPostalCode =='') {
                if(acc.Zip_Code_UTF_8__c !=  null  ||  acc.Zip_Code_UTF_8__c != '' ) {
                    acc.PersonMailingPostalCode = acc.Zip_Code_UTF_8__c;
                }
            }
            system.debug('acc : ' + acc);
        } Catch(Exception ex){
            system.debug('Exception  : '+ ex.getMessage());
        }
        
        return acc;
    }
    
    public Static String insertAccount(Account acc){
        
        System.debug('--- INSERT ---');
        
        User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
        Location__c loc = new Location__c();
        if([SELECT Id, Name, Id_Location_Micros__c FROM Location__c WHERE Id_Location_Micros__c=: user.Codice_Boutique__c].size() != 0) {
            loc = [SELECT Id, Name, Id_Location_Micros__c FROM Location__c WHERE Id_Location_Micros__c=: user.Codice_Boutique__c];
        }
        Associated__c ass = new Associated__c();
        // VS - 08/06/2020 -  SALESFORCE-868
        // if(user.Nome_Profilo__c == 'BC - Associate') {
        if(user.Codice_Associate__c != null && user.Codice_Associate__c != '') {
            system.debug('VS dentro if campi user');
            System.debug('user.Codice_Associate__c '+user.Codice_Associate__c);
            System.debug('user.Codice_Boutique__c '+user.Codice_Boutique__c);
            if([SELECT Id, Id_Associate__c FROM Associated__c WHERE Id_Associate__c =: user.Codice_Associate__c].size() != 0) {
                ass = [SELECT Id, Id_Associate__c FROM Associated__c WHERE Id_Associate__c =: user.Codice_Associate__c AND Id_Location_Micros__c =: user.Codice_Boutique__c];
            }
        }
        system.debug('VS fuori if campi user');
        // VS - 08/06/2020 -  SALESFORCE-868
        returnData ret = new returnData();
        ret.success = true;
        ret.message = 'Account create successfully';
        Account newPersonAccount = new Account();
        try{
            newPersonAccount              = acc;
            newPersonAccount.Creato_da_Scheda_Digitale__c = true;
            
            //Akshay aggiunto un campo in salvatagio per verificare i account viene salvato da RegistrationForm
            newPersonAccount.DCC__c                          = true;
            
            
            newPersonAccount.First_ID_Location__c    = user.Codice_Boutique__c;
            if (loc != null) {
                newPersonAccount.First_Location__c       = loc.Id;
                newPersonAccount.First_Location_Name__c  = loc.Name;
                newPersonAccount.Location__c             = loc.Id;
            }
            
            newPersonAccount.Id_Location__c          = user.Codice_Boutique__c;
            if (ass != null) {
                newPersonAccount.Associate_di_registrazione__c = ass.Id;
                newPersonAccount.Id_Associate__c               = ass.Id_Associate__c;
                newPersonAccount.Associate__c                  = ass.Id;
            }
            
            if(user.Nome_Profilo__c == 'BC - Boutique' && !String.isBlank(user.Codice_Boutique__c) && String.isBlank(user.Codice_Associate__c)) {
                Location__c loc2 = [SELECT Store_Manager_Id__c FROM Location__c WHERE Id_Location_Micros__c=: user.Codice_Boutique__c];
                newPersonAccount.Associate_Registrazione_ID__c= loc2.Store_Manager_Id__c ;
            }else{
                newPersonAccount.Associate_Registrazione_ID__c= user.Codice_Associate__c;
            }
            newPersonAccount.customer_origin__c	= 'DCC customer';
            
            if(user.Nome_Profilo__c == 'BC - Associate') {
                List<User> userLeader = [SELECT Id, Codice_Boutique__c FROM User WHERE Nome_Profilo__c = 'BC - Boutique' AND Codice_Boutique__c =: user.Codice_Boutique__c];
                if(userLeader.size() > 0) {
                    System.debug('USER LEADER TROVATI: ' + userLeader.size());
                    newPersonAccount.OwnerId = userLeader[0].Id;
                } else {
                    System.debug('USER LEADER NON TROVATI SALVO OWNER ID CON QUELLO DELL\' ASSOCIATE');
                }
            }
            
            newPersonAccount.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();
            newPersonAccount.Data_Di_Registrazione__c             = Date.today();
            newPersonAccount.Versione_DCC__c = getDCCVersion();
            CheckAddressOrientalCharacters(newPersonAccount);
            
            insert newPersonAccount;
            
            system.debug('newPersonAccount: ' + newPersonAccount);
            system.debug('newPersonAccount: ' + newPersonAccount.First_ID_Location__c);
            system.debug('newPersonAccount: ' + newPersonAccount.First_Location__c);
            system.debug('newPersonAccount: ' + newPersonAccount.First_Location_Name__c);
            
            system.debug('user.Codice_Boutique__c: ' + user.Codice_Boutique__c);
            system.debug('loc.Id: ' + loc.Id);
            system.debug('loc.Name: ' + loc.Name);
            
            ret.Id = newPersonAccount.Id;
            
        } catch(Exception e) {
            ret.success = false;
            ret.message = e.getMessage();
            return null;
            
        }
        
        return JSON.serialize(ret);
    }
    
    public Static String updateAccount(Account acc){
        
        System.debug('--- UPDATE ---');
        
        returnData ret = new returnData();
        ret.success = true;
        ret.message = 'Account create successfully';
        Account newPersonAccount = new Account();
        Account accOld = [SELECT Id, Privacy1__c, Privacy2__c, Privacy3__c
                            FROM Account
                            WHERE Id=:acc.Id];
        try{
            newPersonAccount              = acc;
            //ValSchi - 10/04/2020 - issue 833 - aggiunto controllo sul cambio della privacy per aggiornare data 
            if(acc.Privacy1__c != accOld.Privacy1__c || acc.Privacy2__c != accOld.Privacy2__c || acc.Privacy3__c != accOld.Privacy3__c){
                newPersonAccount.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();
            }
                
            //Akshay aggiunto un campo in salvatagio per verificare i account viene salvato da RegistrationForm
            newPersonAccount.DCC__c                          = true;
            
            System.debug('--- DCCVersion ---' + getDCCVersion());
            newPersonAccount.Versione_DCC__c = getDCCVersion();
            
            CheckAddressOrientalCharacters(newPersonAccount);
            
            
            update newPersonAccount;
            
            ret.Id = newPersonAccount.Id;
            
        } catch(Exception e) {
            ret.success = false;
            ret.message = e.getMessage();
            return null;
            
        }
        
        return JSON.serialize(ret);
    }
    
    public static Decimal getVersionFromTranslate(String country){
        List<Translate__c> translate = [SELECT Id,N_versione__c FROM Translate__c WHERE Country_FRM__c = :country];
        return translate[0].N_versione__c;	
    }
    public static String getVersionNoteFromTranslate(String country){
        List<Translate__c> translate = [SELECT Id,Note_versionamento__c FROM Translate__c WHERE Country_FRM__c = :country];
        return translate[0].Note_versionamento__c;	
    }
    public static Translate__c getCurrentTranslate(String name){
        // VS - 11/05/2020 scommentare query e cancellare quella dopo in quanto non presente il campo Rich_Text_Registration__c,Cancel_Heading__c 
        // list<Translate__c> Translation = [SELECT Privacy_Yes_Label__c, Privacy_No_Label__c,First_Name_Label__c,Last_Name_Label__c,Salutation_Value__c,
        //                                   Street_Label__c, City_Label__c, CAP_Label__c, Country_Label__c, Phone_Label__c, Nationality_Label__c, 
        //                                   Birthdate_Label__c, Gender_Label__c, Profession_Label__c, Hobby_Label__c, Preferred_Language_Label__c, 
        //                                   Contact_Preferences_Label__c, Privacy_1_Label__c, Privacy_2_Label__c, Privacy_3_Label__c, Date_Label__c, Signature_Label__c,
        //                                   Language_Label__c, Email_Label__c, Salutation_Label__c, Passport_Section_Label__c, Numero_Passaporto_Label__c, Paese_di_emissione_passaporto_Label__c,
        //                                   Data_di_emissione_passaporto_Label__c,Ente_di_emissione_passaporto_Label__c, Country_FRM__c,State_Label__c,Local_First_Name_Label__c,Local_Last_Name_Label__c,
        //                                   We_Chat_ID_Label__c,Checkbox_Phone_Label__c,Checkbox_Email_Label__c,Checkbox_WeChat_Label__c,Checkbox_Mail_Label__c,
        //                                   Checkbox_Messaging_Label__c,Privacy_Header_Before_Link_Label__c,Privacy_Header_Link_Label__c,Privacy_Header_After_Link_Label__c,Informativa_Body_Rich_Label__c,Informativa_Header_Label__c,
        //                                   Privacy_2_Label_Department__c,Informativa_Body_Rich_Label_Department__c,Salutation__c, Cancel_Heading__c, Create_Customer_Heading__c, Rich_Text_Registration__c, Create_Customer_Button__c, Label_Section_Passport__c, Submit_Button__c
        //                                   FROM Translate__c WHERE Name LIKE :name];

        list<Translate__c> Translation = [SELECT Privacy_Yes_Label__c, Privacy_No_Label__c,First_Name_Label__c,Last_Name_Label__c,Salutation_Value__c,
                                          Street_Label__c, City_Label__c, CAP_Label__c, Country_Label__c, Phone_Label__c, Nationality_Label__c, 
                                          Birthdate_Label__c, Gender_Label__c, Profession_Label__c, Hobby_Label__c, Preferred_Language_Label__c, 
                                          Contact_Preferences_Label__c, Privacy_1_Label__c, Privacy_2_Label__c, Privacy_3_Label__c, Date_Label__c, Signature_Label__c,
                                          Language_Label__c, Email_Label__c, Salutation_Label__c, Passport_Section_Label__c, Numero_Passaporto_Label__c, Paese_di_emissione_passaporto_Label__c,
                                          Data_di_emissione_passaporto_Label__c,Ente_di_emissione_passaporto_Label__c, Country_FRM__c,State_Label__c,Local_First_Name_Label__c,Local_Last_Name_Label__c,
                                          We_Chat_ID_Label__c,Checkbox_Phone_Label__c,Checkbox_Email_Label__c,Checkbox_WeChat_Label__c,Checkbox_Mail_Label__c,
                                          Checkbox_Messaging_Label__c,Privacy_Header_Before_Link_Label__c,Privacy_Header_Link_Label__c,Privacy_Header_After_Link_Label__c,Informativa_Body_Rich_Label__c,Informativa_Header_Label__c,
                                          Privacy_2_Label_Department__c,Informativa_Body_Rich_Label_Department__c,Salutation__c
                                          FROM Translate__c WHERE Name LIKE :name];
        return Translation[0];
    }
    public static String getDCCVersion(){
        User userRecord = getUserInformation();
        String returnVersion = '';
        Decimal translateVersion = getVersionFromTranslate(userRecord.Area_Contact_Card__c);
        String areaContactCard = userRecord.Area_Contact_Card__c;
        String nationContactCard = userRecord.Nation_Contact_Card__c;
        String sellingChannel = userRecord.Canale_di_Vendita__c;
        if (translateVersion != null)
            returnVersion += translateVersion;
        returnVersion += '.';
        if (areaContactCard != null)
            returnVersion += areaContactCard;
        returnVersion += '.';
        if (nationContactCard != null)
            returnVersion += nationContactCard;
        returnVersion += '.';
        if (sellingChannel != null)
            returnVersion += sellingChannel;
        return returnVersion;
    }
    public Static String insertContactCard(Account acc, String Id){
        
        System.debug('--- INSERT CONTACTCARD ---');
        
        returnData ret = new returnData();
        ret.success = true;
        ret.message = 'Contact card Object create successfully';
        Contact_Card__c newContactCard = new Contact_Card__c();
        try{
            User userRecord = getUserInformation();
            Translate__c currentTranslate = getCurrentTranslate(acc.SignedLanguage__c+'_'+userRecord.Area_Contact_Card__c);
            newContactCard.Customer_ID__c               = Id;
            newContactCard.Salutation__c                = acc.Salutation;
            newContactCard.FirstName__c                 = acc.FirstName;
            newContactCard.LastName__c                  = acc.LastName;
            newContactCard.PersonMailingStreet__c       = acc.PersonMailingStreet;
            newContactCard.PersonMailingCountry__c      = acc.PersonMailingCountry;
            newContactCard.PersonMailingState__c        = acc.PersonMailingState;
            newContactCard.PersonMailingPostalCode__c   = acc.PersonMailingPostalCode;
            newContactCard.PersonMailingCity__c         = acc.PersonMailingCity;
            newContactCard.PersonEmail__c               = acc.PersonEmail;
            newContactCard.We_Chat_ID__c                = acc.We_Chat_ID__c;
            newContactCard.Phone__c                     = acc.Phone;
            newContactCard.PersonMobilePhone__c         = acc.PersonMobilePhone;
            newContactCard.PersonBirthdate__c           = acc.PersonBirthdate;
            newContactCard.Sesso__c                     = acc.Sesso__c;
            newContactCard.Nazionalita__c               = acc.Nazionalita__c;
            if (acc.Lingua__c != null)
                newContactCard.Lingua__c                    = acc.Lingua__c;
            else
                newContactCard.Lingua__c = 'en';
            newContactCard.Telefono__c                  = acc.Telefono__c;
            newContactCard.Email__c                     = acc.Email__c;
            newContactCard.WeChat__c                    = acc.WeChat__c;
            newContactCard.Posta__c                     = acc.Posta__c;
            newContactCard.Other__c                     = acc.Other__c;
            newContactCard.Other_text__c                = acc.Other_text__c;
            newContactCard.Privacy1__c                  = acc.Privacy1__c;
            newContactCard.Privacy2__c                  = acc.Privacy2__c;
            newContactCard.Privacy3__c                  = acc.Privacy3__c;
            newContactCard.Privacy3__c                  = acc.Privacy3__c;
            newContactCard.Messaging__c                  = acc.Messaging__c;
            newContactCard.Professione__c               = acc.Professione__c;
            newContactCard.Hobby__c                 		= acc.Hobby__c;
            newContactCard.Paese_di_emissione_passaporto__c = acc.Paese_di_emissione_passaporto__c;
            newContactCard.Numero_Passaporto__c  			= acc.Numero_Passaporto__c;
            newContactCard.Privacy_Registration_Date__c = Date.today();
            newContactCard.Versione_DCC__c = acc.Versione_DCC__c;
            newContactCard.Nome_UTF_8__c	= acc.Nome_UTF_8__c;
            newContactCard.Cognome_UTF_8__c = acc.Cognome_UTF_8__c;
            newContactCard.Ente_di_emissione_passaporto__c = acc.Ente_di_emissione_passaporto__c;
            newContactCard.Data_di_emissione_passaporto__c = acc.Data_di_emissione_passaporto__c;
            
            newContactCard.Note_versionamento__c = getVersionNoteFromTranslate(userRecord.Area_Contact_Card__c);
            if (acc.SignedLanguage__c != null && acc.SignedLanguage__c != ''){
            newContactCard.PrivacyHeaderSignedText__c = currentTranslate.Privacy_Header_Before_Link_Label__c+' '+ currentTranslate.Privacy_Header_Link_Label__c+' '+ currentTranslate.Privacy_Header_After_Link_Label__c;
            if (acc.Privacy1__c)
                newContactCard.LegalNoteSignedText1__c = '' + currentTranslate.Privacy_Yes_label__c+''+' '+currentTranslate.Privacy_1_Label__c;
            else
                newContactCard.LegalNoteSignedText1__c = '' + currentTranslate.Privacy_no_label__c+''+' '+currentTranslate.Privacy_1_Label__c;
            if (userRecord.Canale_di_Vendita__c == 'Department'){
                if (acc.Privacy2__c)
                    newContactCard.LegalNoteSignedText2__c = '' + currentTranslate.Privacy_Yes_label__c+''+' '+currentTranslate.Privacy_2_Label_Department__c;
                else
                    newContactCard.LegalNoteSignedText2__c = '' + currentTranslate.Privacy_no_label__c+''+' '+currentTranslate.Privacy_2_Label_Department__c;
            }
            else{
                if (acc.Privacy2__c)
                    newContactCard.LegalNoteSignedText2__c = '' + currentTranslate.Privacy_Yes_label__c+''+' '+currentTranslate.Privacy_2_Label__c;
                else
                    newContactCard.LegalNoteSignedText2__c = '' + currentTranslate.Privacy_no_label__c+''+' '+currentTranslate.Privacy_2_Label__c;
            }
            if (acc.Privacy3__c)
                newContactCard.LegalNoteSignedText3__c = '' + currentTranslate.Privacy_Yes_label__c+''+' '+currentTranslate.Privacy_3_Label__c;
            else
                newContactCard.LegalNoteSignedText3__c = '' + currentTranslate.Privacy_no_label__c+''+' '+currentTranslate.Privacy_3_Label__c;
            
            if (userRecord.Canale_di_Vendita__c == 'Department')
            	newContactCard.Informativa_Body_SignedText__c = currentTranslate.Informativa_Body_Rich_Label_Department__c;
            else
            	newContactCard.Informativa_Body_SignedText__c = currentTranslate.Informativa_Body_Rich_Label__c;
                
            newContactCard.SignedLanguage__c = acc.SignedLanguage__c;
			newContactCard.Informativa_Header_Label__c = currentTranslate.Informativa_Header_Label__c;
            }

            //PALUMBO (START)
            newContactCard.BillingStreet__c = acc.BillingStreet;
            newContactCard.BillingState__c = acc.BillingState;
            newContactCard.BillingCity__c = acc.BillingCity;
            newContactCard.BillingPostalCode__c = acc.BillingPostalCode;
            newContactCard.BillingCountry__c = acc.BillingCountry;
            newContactCard.OtherStreet__c = acc.PersonOtherStreet;
            newContactCard.OtherState__c = acc.PersonOtherState;
            newContactCard.OtherCity__c = acc.PersonOtherCity;
            newContactCard.OtherPostalCode__c = acc.PersonOtherPostalCode;
            newContactCard.OtherCountry__c = acc.PersonOtherCountry;
            
            
            insert newContactCard;
            
            ret.Id = newContactCard.Id;
            
        } catch(Exception e) {
            ret.success = false;
            ret.message = e.getMessage();
            System.debug(e);
            return null;
            
        }
        
        return JSON.serialize(ret);
    }
    
    public Static String uploadSign(String b64SignData, String Id){
        
        System.debug('--- UPLOAD SIGN ---');
        
        returnData ret = new returnData();
        ret.success = true;
        ret.message = 'Signature uploaded successfully';
        try{
            Blob signature = EncodingUtil.base64Decode(b64SignData);
            Attachment att = new Attachment();
            att.body = signature;
            att.ContentType = 'image/png';
            att.name = 'sign_' + Id + '_' + Datetime.now().format('MM_dd') + '.png';
            att.IsPrivate = false;
            att.ParentId = Id;
            insert att;
            
            ret.Id = att.Id;
            /*
ContentVersion cv = new ContentVersion();
cv.VersionData = signature;
cv.Title = 'sign_' + Id + '_' + Datetime.now().format('MM_dd') + '.png';
cv.PathOnClient = 'sign_' + Id + '_' + Datetime.now().format('MM_dd') + '.png';
cv.AccountFile__c = Id;  //This is the library
insert cv;

Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;

//Create ContentDocumentLink
ContentDocumentLink cDe = new ContentDocumentLink();
cDe.ContentDocumentId = conDoc;
cDe.LinkedEntityId = Id; // you can use objectId,GroupId etc
cDe.ShareType = 'I'; // Inferred permission, checkout description of ContentDocumentLink object for more details
cDe.Visibility = 'AllUsers';
insert cDe;
*/
            
        }catch(Exception e) {
            ret.success = false;
            ret.message = e.getMessage();
            system.debug('Exception: ' + e.getMessage());
        }
        
        return JSON.serialize(ret);
    }

    //AT 12/02/2020 web service callout for TaX free
    @AuraEnabled
    public static void makeCalloutForTaxFree(String passportNumber, String countryIso){
         system.debug('Akshay@ passportNumber  : ' + passportNumber);
         system.debug('Akshay@ countryIso  : ' + countryIso);
        try{
            if(passportNumber !='' && countryIso != ''){
                // Http http = new Http();
                // HttpRequest request = new HttpRequest();   
                // // makeCalloutForTaxFreerequest.setEndpoint('https://46.30.169.235:8085/secured/dispatch/customers/globalblue/gettraveler');
                // //request.setEndpoint('https://172.16.3.135:8085/secured/dispatch/customers/globalblue/gettraveler');
                // // request.setEndpoint('https://46.30.169.234:8085/secured/dispatch/customers/globalblue/gettraveler');
                // //test global blu 28/07
                // // request.setEndpoint('https://devesb.dev.brunellocucinelli.it:8085/secured/dispatch/customers/globalblue/gettraveler');

                // request.setEndpoint('https://putsreq.com/wYqdH8dSlNQZKw0DaBda');
                // // request.setClientCertificateName('srvesb');
                // // request.setClientCertificate('MIIDpzCCAo+gAwIBAgIESroAhzANBgkqhkiG9w0BAQsFADCBgzELMAkGA1UEBhMC' +
                // //                             'SVQxEDAOBgNVBAgTB1BlcnVnaWExEDAOBgNVBAcTB1NvbG9tZW8xIjAgBgNVBAoT' +
                // //                             'GUJydW5lbGxvIEN1Y2luZWxsaSBzLnAuYS4xDzANBgNVBAsTBnNydmVzYjEbMBkG' +
                // //                             'A1UEAxMSQnJ1bmVsbG8gQ3VjaW5lbGxpMB4XDTE2MDkxNDEwMDM0NVoXDTIyMDMw' +
                // //                             'NzEwMDM0NVowgYMxCzAJBgNVBAYTAklUMRAwDgYDVQQIEwdQZXJ1Z2lhMRAwDgYD' +
                // //                             'VQQHEwdTb2xvbWVvMSIwIAYDVQQKExlCcnVuZWxsbyBDdWNpbmVsbGkgcy5wLmEu' +
                // //                             'MQ8wDQYDVQQLEwZzcnZlc2IxGzAZBgNVBAMTEkJydW5lbGxvIEN1Y2luZWxsaTCC' +
                // //                             'ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAI4ULaux7juiK6T+Mp/I6VQS' +
                // //                             'X/LDoX3ZBM9jqeVms2pqMb39kzDcPu87NE/Mjdl01QvOUVShxx49HGo/A55OKnRs' +
                // //                             'Inw7STTiECojikKbFGTYNg9BVzxx2ki8LtSPrxJFJv+iH8DrxdezehrxkVmEDlwy' +
                // //                             'hsQICe2EyTFbVx1ItRthDKkBkxsmyViUiYUhq148QHlsO7mVzh6852NiNnW0WEaq' +
                // //                             '3LqBU4F+UXG8pcSvV+gAQPaDrEbDCZvW1qdjlKTLioBtOe3pJxCpYRMe4IqYvhNx' +
                // //                             'chMWVDvurhY6X1OoCqt12ei5SDiHj+SS8RsTlEfeKyWScjxlampmyX4/4XaiwiUC' +
                // //                             'AwEAAaMhMB8wHQYDVR0OBBYEFJ1NfFx7vWVDVOyDUnY4bS/31NPcMA0GCSqGSIb3' +
                // //                             'DQEBCwUAA4IBAQAcI8eRYuQjg40YQemY9FUOywkzppc0bH9KYyT94Na2Z/Yhr7o8' +
                // //                             'IUf1x1Z9orKma/iurVHUQxumu2gUoHUCAJro0Was//ynHEypDCGOjgprdYdOtICm' +
                // //                             '+q9N9xUfRKn7zGmuHoIBo5k0ZTNWQqKmqXyxCgdAT3Uo2eAb9DhBE0ZtFw6CEF9g' +
                // //                             'gWt4m2f7KIbfSy1YCyY72lI2I0eCTtj1k4TOR2gPhdRZLCsD/o15EKgWhH03gvcP' +
                // //                             'bhxnuUMua1G6S3f9I9DVvtbnIuuBvEN2GD2AuJVBjZIpcXwvYMuocazqf2fTNE+n' +
                // //                             'e3Q8jmMmZNwF5GbomwOffWtQbF5pDz+QGG/p','DaInserireLaChiave');
                // request.setMethod('POST');
                // request.setHeader('Content-Type', 'application/json'); //;charset=UTF-8
                // request.setHeader('Content-Length', '<calculated when request is sent>');
                // request.setHeader('Host', '<calculated when request is sent>');
                // // Set the body as a JSON object
                // request.setBody('{"passportNumber__c":"'+passportNumber+'","countryCode__c":"'+countryIso+'"}');
                // system.debug('Request : ' + request);
                // HttpResponse response = http.send(request);
                // // Parse the JSON response
                // System.debug();
                // if (response.getStatusCode() != 201) {
                //     System.debug('The status code returned was not expected: ' +
                //                  response.getStatusCode() + ' ' + response.getStatus());
                // } else {
                //     System.debug(response.getBody());
                // }

                    String jsonString  = '{ "countryCode__c" : "US", "passportNumber__c": "US5555" }';

                HttpRequest req = new HttpRequest();                            
            // req.setEndpoint(endPointIntegrazioneInfoStore);
            // req.setEndpoint('https://putsreq.com/wYqdH8dSlNQZKw0DaBda'); // https://salesforce-test.warranthub.it/api/test   
            req.setEndpoint('https://devesb.dev.brunellocucinelli.it:8085/secured/dispatch/customers/globalblue/gettraveler');

            req.setMethod('POST');
            req.setHeader('Content-type', 'application/json');
            // req.setHeader('Content-Length', '<calculated when request is sent>');
            // req.setHeader('Host', '<calculated when request is sent>');
            req.setBody(jsonString);

            //Execute web service call here 
            Http http = new Http();               
            HTTPResponse res = http.send(req);

            //Helpful debug messages 
            System.debug(res.toString()); 
            System.debug('STATUS: '+res.getStatus()); 
            System.debug('STATUS_CODE: '+res.getStatusCode()); 
            System.debug ('HTTPResponse Body: '+ res.getBody());

            Map<String, Object> resBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            }
            
        }Catch(Exception ex){
            system.debug('Exception : ' + ex.getMessage());
            system.debug('Exception : ' + ex.getLineNumber());
        }
        

    }
    
    
    // Akshay@
    public static void CheckAddressOrientalCharacters(Account acc){
        //controlla lingua per (cinese, giapponese, russo)
        //se presenti caratteri orientali nell'indirizzo salvo i dati relativi nei campi UTF8
        //(ex. EnglishLetters - みずずほダイレクト - 诶非)
        
        String InputString      =   acc.PersonMailingStreet+ ' ' +
            acc.PersonMailingCity + ' ' + acc.PersonMailingState;
        
        
        
        String regex            = '[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff\uff66-\uff9f\u0500-\u052F\u0400-\u04FF]';
        Pattern regexPattern    = Pattern.compile(regex);
        Matcher regexMatcher    = regexPattern.matcher(InputString);
        Pattern regexPattern_1  = Pattern.compile('\\p{IsHan}');
        Matcher regexMatcher_1  = regexPattern_1.matcher(InputString);
        
        
        if(regexMatcher.find() || regexMatcher_1.find()) {
            system.debug('Akshay@ oriental characters (true)');
            // acc.Indirizzo_UTF_8__c = acc.PersonMailingStreet;
            // acc.Citta_UTF_8__c  =   acc.PersonMailingCity + acc.PersonMailingState;
            acc.Indirizzo_UTF_8__c = acc.PersonMailingStreet;
            acc.Citta_UTF_8__c = acc.PersonMailingCity;
            acc.Province_UTF_8__c = acc.PersonMailingState;
            acc.Zip_Code_UTF_8__c = acc.PersonMailingPostalCode;
            acc.PersonMailingStreet = '';
            acc.PersonMailingCity  = '';
            acc.PersonMailingState = '';
            acc.PersonMailingPostalCode= '';
        }
        else{
            system.debug('Akshay@ No oriental characters (false)');
        }
        
    }
    // Akshay@

    //PALUMBO (START)
    // @AuraEnabled
    // public static Boolean checkNationUser(String nation){
    //     List<DCC_Visibility__mdt> dccVisibility = [SELECT Label, IsValid__c FROM DCC_Visibility__mdt WHERE IsValid__c = true AND Label =: nation];
    //     return dccVisibility.size() > 0;
    // }
    //PALUMBO (END)
    
    @AuraEnabled
    public static boolean checkFirmeContactCard(Id customerID){
        List<Attachment> listAtt= [SELECT Id
                    FROM Attachment
                    WHERE Parent.Type='Contact_Card__c' AND Name Like 'sign_%' AND ParentId IN (SELECT id FROM Contact_Card__c WHERE Customer_ID__c =: customerID)
                    ORDER BY CreatedDate Desc
                    LIMIT 1];
        Boolean check= false;
        if(listAtt.size()>0){
            check=true;
        }
            
        System.debug('VS check firme: '+check);
        return check;
    }
    
    
    public class returnData {
        @auraEnabled  Boolean success {get; set;}
        @auraEnabled  String message {get; set;}
        @auraEnabled  String Id {get; set;}
    }
    
    
    
}