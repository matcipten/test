@isTest(seeAllData=true)
public class ScheduleClosingCaseInactiveFor90DaysTest {
    
    @isTest static void Test_Scheduling(){
        
        Test.startTest(); 
        
        ScheduleClosingCaseInactiveFor90Days.schedule_updateCase();       
        ScheduleClosingCaseInactiveFor90Days sh1 = new ScheduleClosingCaseInactiveFor90Days();
        String sch = '0 0 2 ? *  mon'; 
        system.schedule('Test Territory Check', sch, sh1); 
        
        
        
        Test.stopTest();
        
    }
    
    
    @isTest static void inActiveCase(){
         System.debug('Before Insert');
        Account acc = new Account();
        acc.Name = 'Test1 AccCase ';
       // acc.LastName = 'AccCase ';
        //acc.CreatedDate = datetime.newInstance(2017, 1, 1, 12, 30, 0);
        insert acc;
      
        List<Account> accId = [SELECT Id FROM ACCOUNT Limit 1];
        
        System.debug('accId-->'+accId);
        
         Contact con = new Contact();
        con.AccountId = acc.Id;
        con.LastName = 'AccCase';
        insert con;
        
		Case cs = new Case();
        RecordTypeSetting__c rts    = RecordTypeSetting__c.getValues('General');
        
        cs.ContactId = con.Id;
        cs.AccountId = acc.Id;
        cs.subject = 'ad';
        cs.Status = 'Nuovo';
        cs.RecordTypeId = rts.Caso_OMS__c;
        cs.CreatedDate = datetime.newInstance(2017, 1, 1, 12, 30, 0);
        cs.Data_Ultima_Mail__c=  datetime.newInstance(2017, 2, 1, 12, 30, 0);
        cs.LastModifiedDate= datetime.newInstance(2017, 2, 2, 12, 30, 0);
        cs.Chiuso_Automaticamente__c = false;
        
        insert cs;
        
        System.debug('After Insert');
        List<Case> test1 = [SELECT id,Data_Ultima_Mail__c,LastModifiedDate FROM Case WHERE AccountId =: acc.Id ];
        system.debug('test1---->'+test1);
        
        Test.startTest();  
        
        ScheduleClosingCaseInactiveFor90Days.closingCase();        
        Test.stopTest();  
    } 
    
}