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
            RecordTypeId = personAccountRecordType.Id
        );

        return result;
    }
    
    public static Product__c create_Product() {
        Account acc = [SELECT Id FROM Account WHERE PersonEmail='personalEmail@gmail.com'];
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
            Subheader_Label__c = 'subheader'
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
    
    
}