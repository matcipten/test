@isTest
public class TransactionDetialListViewControllerTest {
    @isTest
    public static void  testMethod1(){
        User usr = AllDataFactory.create_User();
        insert usr;
        
        
        
        
        
        System.runAs(usr){
            
            Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
            Account acc =  AllDataFactory.create_Account();
            insert acc;
            
            Product__c prod = AllDataFactory.create_Product();
            insert prod;
            
            Transaction__c transazione =  AllDataFactory.create_Transactions();
            insert transazione;
            
            Transaction_Detail__c Transaction_Detail =  AllDataFactory.create_Transaction_Details();
            insert Transaction_Detail;
            
            List<Transaction_Detail__c> tDetails =  TransactionDetialListViewController.getTransactionDetailsLimit5(acc.Id);
            List<Transaction_Detail__c> tAllDetails =  TransactionDetialListViewController.getTransactionDetailsQueryAll(acc.Id);
            Integer tDetailsInt =  TransactionDetialListViewController.getTransactionDetailsSize(acc.Id);
        }
        
    }
    
}