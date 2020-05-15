/*
 * @Author svella
 */
public class AllDataFactory {

    public static User create_User() {

        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        User result = new User(
            Alias = 'standt1',
            Email='user1@testorg.com',
            EmailEncodingKey='UTF-8',
            LastName='Testing1',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            ProfileId = p.Id,
            Extension = '9988',
            TimeZoneSidKey='America/Los_Angeles',
            UserName='standard1@testorg.com'
            );

        return result;
    }

    public static User create_UserWithProfile(string TestProfileId) {
        User result = new User(
            LastName                    = 'Utente Test',
            CommunityNickname           = 'communitynicknameTest',
            Alias                       = 'UserTest',
            ProfileId                   = TestProfileId,
            Email                       = 'test@test.com',
            Username                    = 'test.User@testr.name',
            EmailEncodingKey            = 'ISO-8859-1',
            TimeZoneSidKey              = 'Europe/Rome',
            LanguageLocaleKey           = 'it',
            LocaleSidKey                = 'it_IT'
            );
        return result;
    }

    public static Account create_Account() {
        RecordType personAccountRecordType =  [SELECT Id FROM RecordType where SobjectType='Account' and Developername='PersonAccount'];

        Account result = new Account(
            FirstName = 'TestName',
            LastName = 'TestSurname',
            Sesso__c = 'M',
            PersonEmail =  'personalEmail@gmail.com',
            Phone = '12345679',
            PersonMobilePhone = '16844838',
            SignedLanguage__c = 'en',
            RecordTypeId = personAccountRecordType.Id
            );

        return result;
    }


    public static Product__c create_Product() {
        //PN added LIMIT 1
        Account acc = [SELECT Id FROM Account WHERE PersonEmail='personalEmail@gmail.com' LIMIT 1];
        Product__c result = new Product__c(
            Name = 'test_product'
            );

        return result;
    }

    public static Transaction__c create_Transactions() {
        RecordType transactionRecordType =  [SELECT Id FROM RecordType where SobjectType='Transaction__c' and Developername='Boutique'];
        Account acc = [SELECT Id FROM Account WHERE PersonEmail='personalEmail@gmail.com'];

        Transaction__c result = new Transaction__c(
            Name     = '1234567890',
            Account__c = acc.Id,
            RecordTypeId = transactionRecordType.Id
            );

        return result;
    }

//PN da rivedere, presuppone 3 inserimenti
    public static Transaction_Detail__c create_Transaction_Details() {
        Transaction__c trans = [SELECT Id FROM Transaction__c WHERE Name='1234567890'];
        Account acc = [SELECT Id FROM Account WHERE PersonEmail='personalEmail@gmail.com'];
        Product__c prod = [SELECT Id FROM Product__c WHERE Name='test_product'];

        Transaction_Detail__c result = new Transaction_Detail__c(
            Name     = '0987654321',
            Transaction__c = trans.Id,
            Product__c = prod.Id
            );

        return result;
    }

    public static Attachment create_Attachment(Id accountId) {
        Attachment result = new Attachment(
            Name='Unit Test Attachment',
            body=Blob.valueOf('Unit Test Attachment Body'),
            parentId = accountId
            );

        return result;
    }

    //MC- Attachments
    public static attachment create_Attachment(Id parent,string name,string attachtype){
        Attachment attach=new Attachment();
        attach.Name = (name != null) ? name : 'test_attachment';
        Blob bodyBlob = Blob.valueOf('TestTestAndTestagain');
        attach.body = bodyBlob;
        attach.parentId = parent;
        attach.ContentType = (attachtype != null) ? 'application/' + attachtype : 'application/pdf';
        attach.IsPrivate = false;
        attach.Description = 'Test';

        return attach;
    }

    public static ContentVersion create_ContentVersion() {
        ContentVersion result = new ContentVersion(
            Title = 'Penguins',
            PathOnClient = 'Penguins.jpg',
            VersionData = Blob.valueOf('Test Content'),
            IsMajorVersion = true
            );

        return result;
    }

    public static ContentDocumentLink create_ContentDocumentLink(ContentVersion cv) {
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;

        ContentDocumentLink result = new ContentDocumentLink(
            ContentDocumentId = conDoc,
            ShareType = 'I'
            );

        return result;
    }

    public static ContentDocumentLink create_ContentDocumentLink(ContentVersion cv, Transaction_Detail__c detail) {
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;

        ContentDocumentLink result = new ContentDocumentLink(
            ContentDocumentId = conDoc,
            LinkedEntityId = detail.Product__c,
            ShareType = 'I'
            );

        return result;
    }

    // ACTIVATE FOR REGISTRATION FORM

    public static Translate__c create_Translator() {


        Translate__c result = new Translate__c(
            Name = 'en_US',
            Subheader_Label__c = 'subheader',
            Privacy_Yes_Label__c = 'Privacy_Yes_Label__c',
            Privacy_No_Label__c= 'Privacy_No_Label__c',First_Name_Label__c='First_Name_Label__c' ,Last_Name_Label__c='Last_Name_Label__c' ,
            Street_Label__c= 'Address', City_Label__c= 'City' , CAP_Label__c= 'CAP_Label__c', Country_Label__c= 'Country',
            Phone_Label__c= 'Phone contact (with international prefix)', Nationality_Label__c='Nationality_Label__c' , 
            Birthdate_Label__c='Birthdate_Label__c' , Gender_Label__c='Gender_Label__c' , Profession_Label__c= 'Profession_Label__c',
            Hobby_Label__c='Hobby_Label__c' , Preferred_Language_Label__c='Preferred_Language_Label__c' , 
            Contact_Preferences_Label__c= 'Contact_Preferences_Label__c' , Privacy_1_Label__c= 'Privacy_1_Label__c', Privacy_2_Label__c= 'Privacy_2_Label__c' , Privacy_3_Label__c= 'Privacy_3_Label__c', Date_Label__c= 'Date', Signature_Label__c= 'Signature',
            Language_Label__c= 'Language_Label__c', Email_Label__c= 'Email', Salutation_Label__c='Salutation_Label__c' ,
            Passport_Section_Label__c= 'Passport_Section_Label__c', Numero_Passaporto_Label__c='Numero_Passaporto_Label__c' , Paese_di_emissione_passaporto_Label__c='Paese_di_emissione_passaporto_Label__c' ,
            Data_di_emissione_passaporto_Label__c= 'Data_di_emissione_passaporto_Label__c',Ente_di_emissione_passaporto_Label__c='Ente_di_emissione_passaporto_Label__c' ,
            State_Label__c='State_Label__c' ,Local_First_Name_Label__c= 'Local_First_Name_Label__c',Local_Last_Name_Label__c= 'Local_Last_Name_Label__c',
            We_Chat_ID_Label__c='We_Chat_ID_Label__c' ,Checkbox_Phone_Label__c='Checkbox_Phone_Label__c' ,Checkbox_Email_Label__c= 'Checkbox_Email_Label__c',
            Checkbox_WeChat_Label__c= 'Checkbox_WeChat_Label__c',Checkbox_Mail_Label__c='Checkbox_Mail_Label__c' ,
            Checkbox_Messaging_Label__c='Checkbox_Messaging_Label__c' ,Privacy_Header_Before_Link_Label__c= 'Privacy_Header_Before_Link_Label__c',
            Privacy_Header_Link_Label__c='Privacy_Header_Link_Label__c' ,Privacy_Header_After_Link_Label__c= 'Privacy_Header_After_Link_Label__c',State_Contact_Address_Label__c='State_Contact_Address_Label__c'
            );

        return result;
    }
    

    public static Profile__c create_TriggerSetting(String ProfileId) {

        Profile__c result = new Profile__c(
            Id_Admin_Apex__c = ProfileId,
            Id_Xstore_Apex__c = '00e36000000ebXdAAI'
            );

        return result;
    }

    // MTM
    public static Account_Misure_Sartoriali__c create_Account_Misure_Sartoriali() {
        RecordType misureRecordType =  [SELECT Id FROM RecordType where SobjectType='Account_Misure_Sartoriali__c' and Developername='Pantalone'];
        Account_Misure_Sartoriali__c result = new Account_Misure_Sartoriali__c(

            Altezza_montante_davanti__c = 10,
            Altezza_montante_dietro__c = 12,
            Circonferenza_bacino__c = 13,
            Circonferenza_torace__c = 14,
            Circonferenza_vita_giacca__c = 13,
            Circonferenza_vita_pantalone__c = 12,
            Curvo__c = true,
            Forte_panciuto__c = true,
            Larghezza_coscia__c = 12,
            Larghezza_fondo__c = 13,
            Larghezza_ginocchio__c = 14,
            Larghezza_manica_bicipite__c = 12,
            Larghezza_manica_fondo__c = 14,
            Larghezza_polpaccio__c = 12,
            Larghezza_spalle_pt_to_pt__c = 21,
            Lungh_giacca_dietro__c = 34,
            Lungh_manica_destra_cucitura_interna__c = 21,
            Normale__c = false,
            RecordTypeId = misureRecordType.Id,
            Rovesciato__c = true,
            Semi_bacino__c = 12,
            Semi_torace__c = 14,
            Semi_vita__c = 23,
            Spalle_Alte__c = true,
            Spalle_Basse__c = true,
            Spalle_Regolari__c = true,
            Stomaco_prominente__c = true,
            Taglia__c = 'taglia text'
            );

        return result;
    }

    public static Misure_di_Riferimento_Sartoria__c create_Misure_di_Riferimento_Sartoria(String rtDevName) {
        RecordType misureRecordType =  [SELECT Id FROM RecordType where SobjectType='Misure_di_Riferimento_Sartoria__c' and Developername=: rtDevName];
        Misure_di_Riferimento_Sartoria__c result = new Misure_di_Riferimento_Sartoria__c(
            Altezza_montante_davanti__c = 10,
            Altezza_montante_dietro__c = 10,
            Larghezza_coscia__c = 10,
            Larghezza_fondo__c = 10,
            Larghezza_ginocchio__c = 10,
            Larghezza_manica_bicipite__c = 10,
            Larghezza_manica_fondo__c = 10,
            Larghezza_polpaccio__c = 10,
            Larghezza_spalle_pt_to_pt__c = 10,
            Lungh_giacca_dietro__c = 10,
            Lungh_manica_destra_cucitura_interna__c = 10,
            Lungh_manica_sinistra_cucitura_interna__c = 10,
            Semi_bacino__c = 10,
            Semi_torace__c = 10,
            Semi_vita__c = 10,
            RecordType = misureRecordType,
            Taglia__c = '10'
            );

        return result;
    }

    public static Rest_MTM_MisureCustomer.AttachWrapper create_postAttachWrapper(string format,string type,string staticResourceName){
        Rest_MTM_MisureCustomer.AttachWrapper aw = new Rest_MTM_MisureCustomer.AttachWrapper();
        string data = [SELECT Body FROM StaticResource WHERE Name =:staticResourceName].Body.toString();
        aw.format = format;
        aw.type = type;
        aw.attachment = data;

        return aw;
    }

    public static MTM_Alert__c create_MTM_Alert(String loc, String step, String recipient, String role){
        MTM_Alert__c result =new MTM_Alert__c();

        result.Location__c = loc;
        result.Step__c = step;
        result.Email__c = 'test@test.it';
        result.Recipient_Type__c = recipient;
        result.Role__c = role;

        return result;
    }


    //PN 20190128
    public static Account create_PersonAccount_Birthday() {
        String rtId =  Account.SobjectType.getDescribe().getRecordTypeInfosByDeveloperName().get('PersonAccount').getRecordTypeId();

        Account result = new Account(
            FirstName = 'TestName',
            LastName = 'TestSurname',
            Sesso__c = 'M',
            PersonEmail =  'personalEmail@gmail.com',
            Phone = '12345679',
            PersonMobilePhone = '16844838',
            RecordTypeId = rtId,
            Privacy3__c = true,
            PersonBirthdate = Date.Today().addDays(1)
            );

        return result;
    }

    public static Activity_tracking__c create_Activity_Tracking(String recordType){

        Account a = AllDataFactory.create_PersonAccount_Birthday();
        insert a;


        Map<String,Sobject> campaignAndMember = AllDataFactory.insert_MyActiveCampaignAndMembers();
        Campaign camp = (Campaign) campaignAndMember.get('Campaign');
        String channel = 'Mail';
        String category = (recordType == 'One_To_One') ? 'OT_Tour Visit' : 'MA_Catalogues';
        String rtId = Activity_tracking__c.SobjectType.getDescribe().getRecordTypeInfosByDeveloperName().get(recordType).getRecordTypeId();

        system.debug(camp);
        system.debug(rtId);
        system.debug(a);

        Activity_tracking__c at = new Activity_tracking__c(Canale__c = channel,
                                                           Categoria__c = category,
                                                           RecordTypeId = rtId,
                                                           Customer_Name__c=a.Id,
                                                           Campagna__c = camp.Id,
                                                           Location__c = 'Out of store',
                                                           Location_Out_of_store__c = 'aaa',
                                                           Activity_Date__c = System.today(),
                                                           Note_Contatto__c = 'bbb');
        system.debug(at);
        // insert at;
        return at;
    }

    public static Map<String,sObject> insert_MyActiveCampaignAndMembers() {
        String rtId =  Campaign.SobjectType.getDescribe().getRecordTypeInfosByDeveloperName().get('One_To_One').getRecordTypeId();
        Campaign c ;
        try{
             c = new Campaign(
            Name = 'Campaign a',
            Quantity__c = '1',
            Email__c = true,
            RecordTypeId = rtId,
            Categoria__c = 'OT_Tour Visit',
            Location__c = 'Out of store',
            Location_Out_of_store__c = 'aaa',
            StartDate = Date.Today().addDays(-1),
            EndDate = Date.Today().addDays(1)
            );

        insert c;
        }catch(Exception ex){
            system.debug('Ex '+ ex.getCause());
            system.debug('Ex '+ ex.getLineNumber());
            system.debug('Ex '+ ex.getMessage());
        }
        
		

        Contact cont = new Contact(
            LastName = 'LastName'
            );

        insert cont;

        CampaignMember cm = new CampaignMember(
            CampaignId = c.Id,
            ContactId = cont.Id,
            Status = 'Suggested Target'
            );
        insert cm;

        Map<String,sObject> sObjectsMap = new Map<String,sObject>();

        sObjectsMap.put('Campaign',(sObject)c);
        sObjectsMap.put('CampaignMember',(sObject)cm);

        return sObjectsMap;
    }

    public static Location__c create_location(){
        Location__c l = new Location__c(
            Name = 'location'
            );
        return l;
    }

    public static Associated__c insert_associate(){
        Location__c l = AllDataFactory.create_location();
        insert l;
        Associated__c a = new Associated__c(
            Location__c = l.Id,
            Name = 'Name'

            );
        insert a;
        return a;
    }

    public static Attivita_Marketing__c insert_Gift() {
        Account a = AllDataFactory.create_PersonAccount_Birthday();
        insert a;
        Product__c prod = AllDataFactory.create_Product();
        insert prod;
        Associated__c ass = AllDataFactory.insert_associate();
        Attivita_Marketing__c gift = new Attivita_Marketing__c(Product__c = prod.Id,
                                                               Cliente__c = a.Id,
                                                               Associate__c = ass.Id);
        insert gift;
        return gift;
    }


    public static ContentDocumentLink create_ContentDocumentLink(ContentVersion cv, Attivita_Marketing__c gift) {
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;

        ContentDocumentLink result = new ContentDocumentLink(
            ContentDocumentId = conDoc,
            LinkedEntityId = gift.Product__c,
            ShareType = 'I'
            );

        return result;
    }


    public static ContentDocumentLink create_ContentDocumentLink(ContentVersion cv, Product__c prod) {
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id].ContentDocumentId;

        ContentDocumentLink result = new ContentDocumentLink(
            ContentDocumentId = conDoc,
            LinkedEntityId = prod.Id,
            ShareType = 'I'
            );

        return result;
    }

    public static Map<String,sObject> insert_Transaction_AND_Detail() {
        
        String transRTId = Transaction__c.SobjectType.getDescribe().getRecordTypeInfosByDeveloperName().get('Boutique').getRecordTypeId();

        Account acc = AllDataFactory.create_PersonAccount_Birthday();
        insert acc;

        Transaction__c trans = new Transaction__c(
            Name     = '1234567890',
            Account__c = acc.Id,
            RecordTypeId = transRTId
            );
        insert trans;

        Product__c prod = AllDataFactory.create_Product();
        insert prod;

        Transaction_Detail__c result = new Transaction_Detail__c(
            Name     = '0987654321',
            Transaction__c = trans.Id,
            Product__c = prod.Id
            );

        insert result;

        Map<String,sObject> myMap = new Map<String,sObject>();
        myMap.put('Transaction__c',(sObject) trans);
        myMap.put('Transaction_Detail__c',(sObject) result);

        return myMap;
    }

    //PN 20190128 END
    
    
    
    //Akshay
    public static Contact create_Contact(){
    Contact cont = new Contact(
            LastName = 'LastName'
            );
        return cont;
    }
    
    public static List<Contact> create_BulkContact(){
        List<Contact> contList =  new List<Contact>();
        for(integer i = 0; i < 100; i++){
            Contact cont = new Contact(
            LastName = 'LastName'+i
            );
            contList.add(cont);
        }
    
        return contList;
    }

    public static Campaign create_Campaign(){
        
        String rtId =  Campaign.SobjectType.getDescribe().getRecordTypeInfosByDeveloperName().get('One_To_One').getRecordTypeId();

        Campaign camp = new Campaign(
            Name = 'Campaign a',
            Quantity__c = '1',
            Email__c = true,
            RecordTypeId = rtId,
            Categoria__c = 'OT_Tour Visit',
            Location__c = 'Out of store',
            Location_Out_of_store__c = 'aaa',
            StartDate = Date.Today().addDays(-1),
            EndDate = Date.Today().addDays(1)
            );
        
        
        return camp;
        
    }
    public static CampaignMember create_CampaignMemberSingle(Id campId, Id contId){
        CampaignMember campMem = new CampaignMember(
            CampaignId = campId,
            ContactId = contId
            );
        
        return campMem;
        
    }


}