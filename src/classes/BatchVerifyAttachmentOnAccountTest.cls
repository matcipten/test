@isTest
public class BatchVerifyAttachmentOnAccountTest {
    
    @isTest
    static void CreateVerifyAttachmentTest() {
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Account acc = AllDataFactory.create_Account();
        acc.Allegati__c = false;
        insert acc;
        
        Account acc2 = AllDataFactory.create_Account();
        acc2.Allegati__c = false;
        insert acc2;
        
        ContentVersion cv = AllDataFactory.create_ContentVersion();
        insert cv;
        
        ContentDocumentLink cDe = AllDataFactory.create_ContentDocumentLink(cv);
        cDe.LinkedEntityId = acc.Id;
        insert cDe;
        
        Attachment att = AllDataFactory.create_Attachment(acc2.Id);
        insert att;
        
        Test.startTest();
        System.runAs(usr){
            Id batchJobId = Database.executeBatch(new BatchVerifyAttachmentOnAccount(), 200);
        }
        Test.stopTest();
        
    }

}