@isTest
public class changeOwnerControllerTest {

    @isTest
    public static void test_changeOwner(){
        String userID = changeOwnerController.fetchUser();

        RecordType caseRt = [SELECT Id,Name 
                                FROM RecordType
                                WHERE sObjectType='Case' AND Name = 'Ticket E-commerce'];
          
                                
        List<RecordType> caseRtOMG = [SELECT Id,Name 
                                    FROM  RecordType WHERE  Name IN ('Brand Specialist', 'Reso/Cambio', 'Reso/Cambio in Store', 'Reso/Cambio in Store', 'Ticket E-commerce', 'Ticket E-commerce – Notify Me', 'Ticket OMS', 'Wishlist')
                                    ORDER BY Name];

        RecordTypeSetting__c rts = new RecordTypeSetting__c(Name = 'General',
                                                            CurrencyIsoCode = 'EUR',
                                                            Caso_BrandSpecialist__c = caseRtOMG[0].Id,
                                                            Caso_ResoCambio__c = caseRtOMG[1].Id,
                                                            Task_ResoCambioStore__c = caseRtOMG[2].Id,
                                                            Caso_ResoCambioStore__c = caseRtOMG[3].Id,
                                                            Caso_CustomerCare__c = caseRtOMG[4].Id,
                                                            Caso_NotifyMe__c = caseRtOMG[5].Id,
                                                            Caso_OMS__c = caseRtOMG[6].Id,
                                                            Task_Wishlist__c = caseRtOMG[7].Id);
        insert rts;
                        


        Test.startTest();
        Case c = new Case();
        c.Status= 'Nuovo';
        c.RecordTypeId =caseRt.Id;
        c.OwnerId =userID;
        insert c;
        
        
        
            changeOwnerController.changeOwner(userID);
        Test.stopTest();
    }
}