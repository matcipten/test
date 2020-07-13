@isTest
public class DiscountCategoriesControllerTest {

    @isTest
    public static void testgetPicklistValue_NoNationContactCard(){

        User u= AllDataFactory.create_User();
        Test.startTest();
        System.runAs(u){
            DiscountCategoriesController.getPicklistValue();
        }
        Test.stopTest();
    }


    @isTest
    public static void testgetPicklistValue_NationContactCard(){

        User u= AllDataFactory.create_User();
        u.Nation_Contact_Card__c='IT';
        Test.startTest();
        System.runAs(u){
            DiscountCategoriesController.getPicklistValue();
        }
        Test.stopTest();
    }


    // @isTest
    // public static void testupdateAccount(){

    //     User u1= AllDataFactory.create_User();
    //     u1.Username='test1@1test.it';
    //     insert u1;
    //     User u2= AllDataFactory.create_User();
    //     u2.ManagerId= u1.id;
    //     u2.Alias = 'standard';
    //     u2.Email='Test2@testorg.com2';
    //     u2.Username='test2@2test.com';
    //     u2.EmailEncodingKey='UTF-8';
    //     u2.LastName='AAA';
    //     insert u2;
        
    //     Account a = AllDataFactory.create_Account();
        
    //     Test.startTest();
        
    //         insert a;
    //         DiscountCategoriesController.updateAccount(a.ID,'VIP10','Test');
        
    //     Test.stopTest();
    // }
}