@isTest
public class OnContentDocumentTriggerHandlerTest {
    
    @isTest
    static void CreateContentDocumentInAccountTest() {
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        
        
        Test.startTest();
        System.runAs(usr){
            
            Account acc = AllDataFactory.create_Account();
        insert acc;
        
        ContentVersion cv = AllDataFactory.create_ContentVersion();
        insert cv;
        
        ContentDocumentLink cDe = AllDataFactory.create_ContentDocumentLink(cv);
        cDe.LinkedEntityId = acc.Id;
        insert cDe;
            
            ContentVersion contentVersionSelect = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];
            List<ContentDocument> documents = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument WHERE Id = : contentVersionSelect.ContentDocumentId];
            delete(documents);
        }
        Test.stopTest();
        
        
    }

}