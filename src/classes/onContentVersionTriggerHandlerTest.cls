@isTest
public class onContentVersionTriggerHandlerTest {
    
    @isTest
    static void CreateContentVersionInAccountTest() {
        
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
            
        }
        Test.stopTest();
        
        
    }

    @isTest
    static void CreateContentVersionInActivityTrackingTest() {
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        
        
        Test.startTest();
        System.runAs(usr){
            
            Activity_tracking__c act = AllDataFactory.create_Activity_Tracking('One_To_One');
        insert act;
        
        ContentVersion cv = AllDataFactory.create_ContentVersion();
        insert cv;
        
        ContentDocumentLink cDe = AllDataFactory.create_ContentDocumentLink(cv);
        cDe.LinkedEntityId = act.Id;
        insert cDe;
            
        }
        Test.stopTest();
             
    }

}