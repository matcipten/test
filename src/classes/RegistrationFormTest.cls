@isTest
public class RegistrationFormTest {
    
    @isTest
    static void validateRegistrationFormController() {
        
        User usr = AllDataFactory.create_User();
        usr.Nation_Contact_Card__c ='US';
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Account acc = AllDataFactory.create_Account();
        insert acc;
		
        Account accTest = AllDataFactory.create_Account();
        Translate__c translate = AllDataFactory.create_Translator();
        insert translate;
        
        
        Test.startTest();
        System.runAs(usr){
            RegistrationForm.getUserInformation();
            RegistrationForm.getTranslatorForm('US');
            RegistrationForm.getselectOptions(acc, 'Salutation');
            String test_save = RegistrationForm.saveNewAccount(accTest, 'sPad64');

            Account test_acc = RegistrationForm.getAccount(acc.Id);

            String test_update = RegistrationForm.updateNewAccount(test_acc, 'sPad64');
            

        }
        Test.stopTest();
        
    }

}