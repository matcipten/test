@isTest
public class OnAttachmentTriggerHandlerTest {
    
    @isTest
    static void CreateAttachmentInAccountTest() {
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            Account acc = AllDataFactory.create_Account();
        insert acc;
        
        Attachment att = AllDataFactory.create_Attachment(acc.Id);
        insert att;
            
           delete att;
        }
        Test.stopTest();
    	
		
        
    }

}