@isTest
public class onTransactionTriggerHandlerTest {

    static testMethod void CreateGiftActivityTest() {     
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            Account a1 	= new Account();
            a1.LastName = 'TestLastName1';
            a1.Privacy_1__c = true;
            insert a1;
            
            Product__c p 	= new Product__c();
            p.Name		= 'ProductTest';
            insert p;
            
            Transaction__c t 	= new Transaction__c();
            t.Account__c		= a1.Id;
            insert t;
            
        
        }
        Test.stopTest();
        
        
    }
}