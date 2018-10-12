@isTest
public class Schedule_Batch_ResetKPIOnAccount_Test {
    @isTest
    static void Schedule_Batch_ResetKPIOnAccountMethod(){
         User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            Account a1 	= new Account();
            a1.LastName = 'TestLastName1';
            insert a1;

            Account a2 	= new Account();
            a2.LastName = 'TestLastName2';
            a2.Importo_Totale_Acquisti__c = 2;
            insert a2;
           
            

        
            Schedule_Batch_ResetKPIOnAccount sbr =  new Schedule_Batch_ResetKPIOnAccount();
        	sbr.testMode = true;
            
            ID batchprocessid = Database.executeBatch(sbr, 10 ); 
        }
        Test.stopTest();
   
        
        
        
       // ID batchprocessid = Database.executeBatch(sbr, 10 ); 
        
    }

}