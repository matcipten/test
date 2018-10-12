@isTest
public class RegistrationFormTest {
    
    @isTest
    static void validateRegistrationFormController() {
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Account acc = AllDataFactory.create_Account();
        insert acc;

        Translate__c translate = AllDataFactory.create_Translator();
        insert translate;
        
        
        Test.startTest();
        System.runAs(usr){
            RegistrationForm.getUserInformation();
            RegistrationForm.getTranslatorForm();
            RegistrationForm.getselectOptions(acc, 'Salutation');
            String test_save = RegistrationForm.saveNewAccount(acc, 'sPad64');

            Account test_acc = RegistrationForm.getAccount(acc.Id);

            String test_update = RegistrationForm.updateNewAccount(test_acc, 'sPad64');
            

        }
        Test.stopTest();
        
    }

}