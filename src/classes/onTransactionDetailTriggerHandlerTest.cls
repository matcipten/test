@isTest
private class onTransactionDetailTriggerHandlerTest {
    
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
            
            Transaction_Detail__c td 	= new Transaction_Detail__c();
            td.Transaction__c			= t.Id;
            td.Product__c				= p.Id;
            td.Gift__c					= true;
            td.Quantita__c = 1.0;
            td.CurrencyIsoCode = 'EUR';
            td.Codice_Cassa__c ='1';
            td.Prezzo_di_Listino__c = 300.00;
            td.Prezzo_di_Vendita__c = 150.00;
            td.Data_Scontrino__c = system.today();
            
            insert td;
            
            delete td;
            
        }
        Test.stopTest();
        
        
    }
    static testMethod void CreatebulkifiedTestTD() {     
        /*
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
            
            Transaction_Detail__c td 	= new Transaction_Detail__c();
            td.Transaction__c			= t.Id;
            td.Product__c				= p.Id;
            td.Gift__c					= true;
            td.Quantita__c = 1.0;
            td.CurrencyIsoCode = 'EUR';
            td.Codice_Cassa__c ='1';
            td.Prezzo_di_Listino__c = 300.00;
            td.Prezzo_di_Vendita__c = 150.00;
            
            insert td;
            
            delete td;
           
        }
        Test.stopTest();
         */
        
    }
}