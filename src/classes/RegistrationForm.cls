public class RegistrationForm {
    
    @AuraEnabled
    public static map<String,Translate__c> getTranslatorForm(){
        Map<String,Translate__c> Mymap = new Map<String,Translate__c>();

        for(Translate__c obj : [SELECT Id, Name, Subheader_Label__c, Language_Label__c, Salutation_Label__c, 
                                    First_Name_Label__c, First_Name_Placeholder__c, Last_Name_Label__c, Last_Name_Placeholder__c,
                                    Street_Label__c, Street_Placeholder__c, City_Label__c, City_Placeholder__c,
                                    State_Label__c, State_Placeholder__c, CAP_Label__c, CAP_Placeholder__c,
                                    Country_Label__c, Country_Placeholder__c, Phone_Label__c, Phone_Placeholder__c,
                                    Mobile_Label__c, Mobile_Placeholder__c, Email_Label__c, Email_Placeholder__c, We_Chat_ID_Label__c, We_Chat_ID_Placeholder__c,
                                    Checkbox_Phone_Label__c, Contact_Preferences_Label__c, Checkbox_Email_Label__c, Checkbox_Mail_Label__c, Checkbox_WeChat_Label__c,
                                    Checkbox_Other_Label__c, Checkbox_Other_Placeholder__c, Birthdate_Label__c, Gender_Label__c, Nationality_Label__c, Preferred_Language_Label__c,
                                    Privacy_Header_Label__c, Privacy_Header_Before_Link_Label__c, Privacy_Header_Link_Label__c, 
                                    Privacy_Header_After_Link_Label__c, Privacy_Yes_Label__c, Privacy_No_Label__c, Privacy_1_Label__c,
                                    Privacy_2_Label__c, Privacy_2_Label_Department__c, Privacy_3_Label__c, Privacy_Footer_Label__c, Date_Label__c, Signature_Label__c,
                                    Signature_Asterisco_Label__c, Button_Signature_Clear_Label__c, Button_Signature_Save_Label__c, Button_Form_Registration_Label__c,
                                    Informativa_Header_Label__c, Informativa_Body_Rich_Label__c, Informativa_Body_Rich_Label_Department__c FROM Translate__c]) {
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
            allOpts.put(a.getLabel(), a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        
        return allOpts;
    }
    
    @AuraEnabled
    public static String saveNewAccount(Account account, String sPad64) {
        
        system.debug('ACCOUNT : ' + account);
        
        Savepoint sp = Database.setSavepoint();
        returnData insertAccount = (returnData)JSON.deserializeStrict( insertAccount(account), returnData.class);
        returnData insertContactCard = (returnData)JSON.deserializeStrict( insertContactCard(account, insertAccount.Id), returnData.class);
        returnData uploadSignResponse = (returnData)JSON.deserializeStrict( uploadSign(sPad64.replace('data:image/png;base64,', ''), insertContactCard.Id), returnData.class);
        
        if(!insertAccount.success || !uploadSignResponse.success){
            Database.rollback(sp);
            return 'false';
        }
        
        system.debug('insertAccount: ' + insertAccount);
        system.debug('uploadSignResponse: ' + uploadSignResponse);
        
        return 'true';
        
    }

    @AuraEnabled
    public static String updateNewAccount(Account account, String sPad64) {
        
        system.debug('ACCOUNT UPDATE: ' + account);
        
        //Savepoint sp = Database.setSavepoint();
        returnData insertAccount = (returnData)JSON.deserializeStrict( updateAccount(account), returnData.class);
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
        
        return 'true';
        
    }

    @AuraEnabled
    public static User getUserInformation() {
        return  [SELECT Id, Name, Nation_Contact_Card__c, Language_Contact_Card__c, Department__c FROM User WHERE Id =: UserInfo.getuserid() ];
    }

    @AuraEnabled
    public static Account getAccount(Id AccountId) {
        system.debug('AccountId: ' + AccountId);
        return  [SELECT Id, Salutation, FirstName, LastName, PersonMailingStreet, PersonMailingCountry, PersonMailingPostalCode, PersonMailingCity, PersonMailingState,
                        PersonEmail, We_Chat_ID__c, Phone, PersonMobilePhone, PersonBirthdate, Sesso__c, Nazionalita__c, Lingua__c, Telefono__c, Email__c, WeChat__c, Posta__c, 
                        Other__c, Other_text__c, Privacy1__c, Privacy2__c, Privacy3__c FROM Account WHERE Id =: AccountId ];
    }
    
    public  Static String insertAccount(Account acc){

        System.debug('--- INSERT ---');

        User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c FROM User WHERE Id=:UserInfo.getUserId()];
        Location__c loc = new Location__c();
        if([SELECT Id, Name, Id_Location_Micros__c FROM Location__c WHERE Id_Location_Micros__c=: user.Codice_Boutique__c].size() != 0) {
            loc = [SELECT Id, Name, Id_Location_Micros__c FROM Location__c WHERE Id_Location_Micros__c=: user.Codice_Boutique__c];
        }
        Associated__c ass = new Associated__c();
        if([SELECT Id, Id_Associate__c FROM Associated__c WHERE Id_Associate__c =: user.Codice_Associate__c].size() != 0) {
            ass = [SELECT Id, Id_Associate__c FROM Associated__c WHERE Id_Associate__c =: user.Codice_Associate__c];
        }
        returnData ret = new returnData();
        ret.success = true;
        ret.message = 'Account create successfully';
        Account newPersonAccount = new Account();
        try{
            
            newPersonAccount.Creato_da_Scheda_Digitale__c = true;
            newPersonAccount.Salutation              = acc.Salutation;
            newPersonAccount.FirstName               = acc.FirstName;
            newPersonAccount.LastName                = acc.LastName;
            newPersonAccount.PersonMailingStreet     = acc.PersonMailingStreet;
            newPersonAccount.PersonMailingCountry    = acc.PersonMailingCountry;
            newPersonAccount.PersonMailingState    	 = acc.PersonMailingState;
            newPersonAccount.PersonMailingPostalCode = acc.PersonMailingPostalCode;
            newPersonAccount.PersonMailingCity       = acc.PersonMailingCity;
            newPersonAccount.PersonEmail             = acc.PersonEmail;
            newPersonAccount.We_Chat_ID__c           = acc.We_Chat_ID__c;
            newPersonAccount.Phone                   = acc.Phone;
            newPersonAccount.PersonMobilePhone       = acc.PersonMobilePhone;
            newPersonAccount.PersonBirthdate         = acc.PersonBirthdate;
            newPersonAccount.Sesso__c                = acc.Sesso__c;
            newPersonAccount.Nazionalita__c          = acc.Nazionalita__c;
            newPersonAccount.Lingua__c               = acc.Lingua__c;
            newPersonAccount.Telefono__c             = acc.Telefono__c;
            newPersonAccount.Email__c                = acc.Email__c;
            newPersonAccount.WeChat__c               = acc.WeChat__c;
            newPersonAccount.Posta__c                = acc.Posta__c;
            newPersonAccount.Other__c                = acc.Other__c;
            newPersonAccount.Other_text__c               = acc.Other_text__c;
            newPersonAccount.Privacy1__c             = acc.Privacy1__c;
            newPersonAccount.Privacy2__c             = acc.Privacy2__c;
            newPersonAccount.Privacy3__c             = acc.Privacy3__c;
            newPersonAccount.First_ID_Location__c    = user.Codice_Boutique__c;
            if (loc != null){
                newPersonAccount.First_Location__c       = loc.Id;
                newPersonAccount.First_Location_Name__c  = loc.Name; 
            }
            newPersonAccount.Id_Location__c          = user.Codice_Boutique__c;
            if (ass != null){
                newPersonAccount.Associate_di_registrazione__c = ass.Id;
                newPersonAccount.Id_Associate__c            = ass.Id_Associate__c;
                newPersonAccount.Associate__c               = ass.Id;
            }            
            newPersonAccount.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();

            insert newPersonAccount;

            system.debug('newPersonAccount: ' + newPersonAccount);
            system.debug('newPersonAccount: ' + newPersonAccount.First_ID_Location__c);
            system.debug('newPersonAccount: ' + newPersonAccount.First_Location__c);
            system.debug('newPersonAccount: ' + newPersonAccount.First_Location_Name__c);

            system.debug('user.Codice_Boutique__c: ' + user.Codice_Boutique__c);
            system.debug('loc.Id: ' + loc.Id);
            system.debug('loc.Name: ' + loc.Name);
            
            ret.Id = newPersonAccount.Id;
            
        } catch(Exception e){
            ret.success = false;
            ret.message = e.getMessage();           
            return null;
            
        }    
        
        return JSON.serialize(ret);
    }

     public  Static String updateAccount(Account acc){

        System.debug('--- UPDATE ---');

       returnData ret = new returnData();
        ret.success = true;
        ret.message = 'Account create successfully';
        Account newPersonAccount = [SELECT Id, Salutation, FirstName, LastName, PersonMailingStreet, PersonMailingCountry, PersonMailingPostalCode, PersonMailingCity, 
                                    PersonEmail, We_Chat_ID__c, Phone, PersonMobilePhone, PersonBirthdate, Sesso__c, Lingua__c, Telefono__c, Email__c, WeChat__c, Posta__c, Privacy1__c, Privacy2__c, 
                                    Privacy3__c FROM Account WHERE Id =: acc.Id ];
        try{
            newPersonAccount.Salutation              = acc.Salutation;
            newPersonAccount.FirstName               = acc.FirstName;
            newPersonAccount.LastName                = acc.LastName;
            newPersonAccount.PersonMailingStreet     = acc.PersonMailingStreet;
            newPersonAccount.PersonMailingCountry    = acc.PersonMailingCountry;
            newPersonAccount.PersonMailingState    	 = acc.PersonMailingState;
            newPersonAccount.PersonMailingPostalCode = acc.PersonMailingPostalCode;
            newPersonAccount.PersonMailingCity       = acc.PersonMailingCity;
            newPersonAccount.PersonEmail             = acc.PersonEmail;
            newPersonAccount.We_Chat_ID__c           = acc.We_Chat_ID__c;
            newPersonAccount.Phone                   = acc.Phone;
            newPersonAccount.PersonMobilePhone       = acc.PersonMobilePhone;
            newPersonAccount.PersonBirthdate         = acc.PersonBirthdate;
            newPersonAccount.Sesso__c                = acc.Sesso__c;
            newPersonAccount.Nazionalita__c          = acc.Nazionalita__c;
            newPersonAccount.Lingua__c               = acc.Lingua__c;
            newPersonAccount.Telefono__c             = acc.Telefono__c;
            newPersonAccount.Email__c                = acc.Email__c;
            newPersonAccount.WeChat__c               = acc.WeChat__c;
            newPersonAccount.Posta__c                = acc.Posta__c;
            newPersonAccount.Other__c                = acc.Other__c;
            newPersonAccount.Other_text__c               = acc.Other_text__c;
            newPersonAccount.Privacy1__c             = acc.Privacy1__c;
            newPersonAccount.Privacy2__c             = acc.Privacy2__c;
            newPersonAccount.Privacy3__c             = acc.Privacy3__c;
            newPersonAccount.Data_Ultimo_Aggiornamento_Privacy__c = Date.today();

            update newPersonAccount;
            
            ret.Id = newPersonAccount.Id;
            
        } catch(Exception e){
            ret.success = false;
            ret.message = e.getMessage();           
            return null;
            
        }    
        
        return JSON.serialize(ret);
    }

    public  Static String insertContactCard(Account acc, String Id){
        
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
            newContactCard.PersonMailingState__c    	= acc.PersonMailingState;
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
            newContactCard.Privacy_Registration_Date__c = Date.today();

            insert newContactCard;
            
            ret.Id = newContactCard.Id;
            
        } catch(Exception e){
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
            
        }catch(Exception e){
            ret.success = false;
            ret.message = e.getMessage();
            system.debug('Exception: ' + e.getMessage());            
        }    
        
        return JSON.serialize(ret);
    }
    
    private class returnData{
        Boolean success {get;set;}
        String message {get;set;}
        String Id {get;set;}
    }

}