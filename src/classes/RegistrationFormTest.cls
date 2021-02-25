@isTest
public class RegistrationFormTest {
    
    @isTest
    static void validateRegistrationFormController() {
        
        User usr = AllDataFactory.create_User();
        usr.Nation_Contact_Card__c ='US';
        usr.Area_Contact_Card__c= 'US';
        
        insert usr;
        
        
        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Account acc = AllDataFactory.create_Account();
        insert acc;
		
        Account accTest = AllDataFactory.create_Account();
        Translate__c translate = AllDataFactory.create_Translator();
        insert translate;
        
            RegistrationForm.getUserInformation();
            RegistrationForm.getTranslatorForm('US');
            RegistrationForm.getselectOptions(acc, 'Salutation');
            String test_save = RegistrationForm.saveNewAccount(accTest, 'sPad64');

            Account test_acc = RegistrationForm.getAccount(acc.Id);

            String test_update = RegistrationForm.updateNewAccount(test_acc, 'sPad64');
            
            List<Contact_Card__c> cc = [SELECT Id From Contact_Card__c WHERE Customer_ID__c =: acc.Id];
            RegistrationForm.registerForm(cc[0].Id);
            
        }
        Test.stopTest();
        
    }
    @isTest
    static void validateRegistrationFormController2() {
        
        User usr = AllDataFactory.create_User();
        usr.Nation_Contact_Card__c ='JP';
        usr.Area_Contact_Card__c= 'JP';
        
        insert usr;
        
        
        Test.startTest();
        System.runAs(usr){
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Account acc = AllDataFactory.create_Account();
        insert acc;
		
        Account accTest = AllDataFactory.create_Account();
        Translate__c translate = AllDataFactory.create_Translator2();
        insert translate;
        
            RegistrationForm.getUserInformation();
            RegistrationForm.getTranslatorForm('JP');
            RegistrationForm.getselectOptions(acc, 'Salutation');
            String test_save = RegistrationForm.saveNewAccount(accTest, 'sPad64');

            Account test_acc = RegistrationForm.getAccount(acc.Id);

            String test_update = RegistrationForm.updateNewAccount(test_acc, 'sPad64');
            
            List<Contact_Card__c> cc = [SELECT Id From Contact_Card__c WHERE Customer_ID__c =: acc.Id];
            RegistrationForm.registerForm(cc[0].Id);
            
        }
        Test.stopTest();
        
    }
    
    

}