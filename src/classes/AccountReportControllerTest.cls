@isTest(SeeAllData=true)
public class AccountReportControllerTest {

    
     @isTest
    public static void testMethod1(){
     
        Account acc = AllDataFactory.create_Account();
        insert acc;
      	String test = AccountReportController.getReport(acc.Id, 'Top_Yarn_Type');
        //DisplayReportController.Result test =  DisplayReportController.getReportWithAccId(acc.Id);
        
        
    }
}