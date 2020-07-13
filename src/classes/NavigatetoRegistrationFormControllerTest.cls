@isTest

public class NavigatetoRegistrationFormControllerTest {
    @isTest
    public static void testgetUserCorrectInterface(){

        User u= AllDataFactory.create_User();
        Test.startTest();
        System.runAs(u){
            NavigatetoRegistrationFormController.getUserCorrectInterface();
        }
        Test.stopTest();
    }

    @isTest
    public static void testgetUserCorrectInterfaceTW(){

        User u= AllDataFactory.create_User();
        ID userID= [SELECT User_Id__c
        FROM New_User_Interface_DCC__mdt 
        LIMIT 1].User_Id__c;
        u.ID= userID;
        Test.startTest();
        System.runAs(u){
            New_User_Interface_DCC__mdt UserTW =new New_User_Interface_DCC__mdt();
            UserTW.User_Id__c=u.Id;

            NavigatetoRegistrationFormController.getUserCorrectInterface();
        }
        Test.stopTest();
    } 
        

}