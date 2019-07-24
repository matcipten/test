public class RegistrationForm {
    
    @AuraEnabled
    public static map<String,Translate__c> getTranslatorForm(String locale){
        Map<String,Translate__c> Mymap = new Map<String,Translate__c>();
        system.debug('LOCALE --->' + locale);
        for(Translate__c obj : [SELECT Id, Name, Subheader_Label__c, Language_Label__c, Salutation_Label__c,
                                First_Name_Label__c, First_Name_Placeholder__c, Last_Name_Label__c, Last_Name_Placeholder__c,
                                Street_Label__c, Street_Placeholder__c, City_Label__c, City_Placeholder__c,Hobby_Values__c,
                                State_Label__c, State_Placeholder__c, CAP_Label__c, CAP_Placeholder__c,Gender_Values__c,
                                Country_Label__c, Country_Placeholder__c, Phone_Label__c, Phone_Placeholder__c,Profession_Values__c,
                                Mobile_Label__c, Mobile_Placeholder__c, Email_Label__c, Email_Placeholder__c, We_Chat_ID_Label__c, We_Chat_ID_Placeholder__c,
                                Checkbox_Phone_Label__c, Contact_Preferences_Label__c, Checkbox_Email_Label__c, Checkbox_Mail_Label__c, Checkbox_WeChat_Label__c,
                                Checkbox_Messaging_Label__c, Checkbox_Other_Placeholder__c, Birthdate_Label__c, Gender_Label__c, Nationality_Label__c, Preferred_Language_Label__c,
                                Privacy_Header_Label__c, Privacy_Header_Before_Link_Label__c, Privacy_Header_Link_Label__c,
                                Privacy_Header_After_Link_Label__c, Privacy_Yes_Label__c, Privacy_No_Label__c, Privacy_1_Label__c,
                                Privacy_2_Label__c, Privacy_2_Label_Department__c, Privacy_3_Label__c, Privacy_Footer_Label__c, Date_Label__c, Signature_Label__c,
                                Signature_Asterisco_Label__c, Button_Signature_Clear_Label__c, Button_Signature_Save_Label__c, Button_Form_Registration_Label__c,
                                Informativa_Header_Label__c, Informativa_Body_Rich_Label__c, Informativa_Body_Rich_Label_Department__c,
                                Profession_Label__c, Hobby_Label__c,  Passport_Section_Label__c, Numero_Passaporto_Label__c, Paese_di_emissione_passaporto_Label__c,
                                Local_First_Name_Label__c, Local_Last_Name_Label__c, Button_Back_Label__c,Versione_DCC__c,Richiedi_Firma__c,Success_Message_Label__c,Data_di_emissione_passaporto_Label__c,
                                Ente_di_emissione_passaporto_Label__c
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
            if (user.Nation_Contact_Card__c == 'RU'){
           RussianWebServer.RussianWebServerInvocation(account);
            }
        }
        catch(Exception ex){
            System.debug('Error during Russian Web Service Invocation: ' + ex.getMessage());
        }
        try{
            Savepoint sp = Database.setSavepoint();
            insertAccount = (returnData)JSON.deserializeStrict( insertAccount(account), returnData.class);
            returnData insertContactCard = (returnData)JSON.deserializeStrict( insertContactCard(account, insertAccount.Id), returnData.class);
            returnData uploadSignResponse = (returnData)JSON.deserializeStrict( uploadSign(sPad64.replace('data:image/png;base64,', ''), insertContactCard.Id), returnData.class);
            
            if(!insertAccount.success || !uploadSignResponse.success) {
                Database.rollback(sp);
                return 'false';
            }
            
            system.debug('insertAccount: ' + insertAccount);
            system.debug('uploadSignResponse: ' + uploadSignResponse);
            
            
        }catch(Exception ex) {
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
        return [SELECT Id, Name, Nation_Contact_Card__c, Language_Contact_Card__c, Department__c, Codice_Boutique__c, Canale_di_Vendita__c FROM User WHERE Id =: UserInfo.getuserid() ];
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
                        Data_di_emissione_passaporto__c
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
        if(user.Nome_Profilo__c == 'BC - Associate') {
            if([SELECT Id, Id_Associate__c FROM Associated__c WHERE Id_Associate__c =: user.Codice_Associate__c].size() != 0) {
                ass = [SELECT Id, Id_Associate__c FROM Associated__c WHERE Id_Associate__c =: user.Codice_Associate__c AND Id_Location_Micros__c =: user.Codice_Boutique__c];
            }
        }
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
        try{
            newPersonAccount              = acc;
            
            newPersonAccount.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();
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
    public static String getDCCVersion(){
        User userRecord = getUserInformation();
        String returnVersion = '';
        Decimal translateVersion = getVersionFromTranslate(userRecord.Nation_Contact_Card__c);
        String nationContactCard = userRecord.Nation_Contact_Card__c;
        String sellingChannel = userRecord.Canale_di_Vendita__c;
		if (translateVersion != null)
            returnVersion += translateVersion;
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
            newContactCard.Lingua__c                    = acc.Lingua__c;
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
            User userRecord = getUserInformation();
            newContactCard.Note_versionamento__c = getVersionNoteFromTranslate(userRecord.Nation_Contact_Card__c);
            
            insert newContactCard;
            
            ret.Id = newContactCard.Id;
            
        } catch(Exception e) {
            ret.success = false;
            ret.message = e.getMessage();
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
    
    
    // Akshay@
    public static void CheckAddressOrientalCharacters(Account acc){
        //controlla lingua per (cinese, giapponese, russo)
        //se presenti caratteri orientali nell'indirizzo salvo i dati relativi nei campi UTF8
        //(ex. EnglishLetters - みずずほダイレクト - 诶非)
        
        String InputString      =   acc.PersonMailingStreet+ ' ' +
            acc.PersonMailingCity;
        
        
        
        String regex            = '[\u3040-\u30ff\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff\uff66-\uff9f\u0500-\u052F\u0400-\u04FF]';
        Pattern regexPattern    = Pattern.compile(regex);
        Matcher regexMatcher    = regexPattern.matcher(InputString);
        Pattern regexPattern_1  = Pattern.compile('\\p{IsHan}');
        Matcher regexMatcher_1  = regexPattern_1.matcher(InputString);
        
        if(regexMatcher.find() || regexMatcher_1.find()) {
            system.debug('Akshay@ oriental characters (true)');
            acc.Indirizzo_UTF_8__c = acc.PersonMailingStreet;
            acc.Citta_UTF_8__c  =   acc.PersonMailingCity;
            acc.PersonMailingStreet = '';
            acc.PersonMailingCity  = '';
        }
        else{
            system.debug('Akshay@ No oriental characters (false)');
        }
        
    }
    // Akshay@
    
    
    
    public class returnData {
        @auraEnabled  Boolean success {get; set;}
        @auraEnabled  String message {get; set;}
        @auraEnabled  String Id {get; set;}
    }
    
    
    
}