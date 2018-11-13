@isTest
public class ProdottiImagesPreviewControllerTest {
    
    @isTest
    static void validateProdottiImagesPreviewController() {
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        
        
        Test.startTest();
        System.runAs(usr){
            
            Account acc = AllDataFactory.create_Account();
        insert acc;
        
        String parentId = (String)acc.Id;
        
        Product__c prod = AllDataFactory.create_Product();
        insert prod;
        
        Transaction__c trans = AllDataFactory.create_Transactions();
        insert trans;
        
        Transaction_Detail__c detail = AllDataFactory.create_Transaction_Details();
        insert detail;
        
        ContentVersion cv = AllDataFactory.create_ContentVersion();
        insert cv;
        
        ContentDocumentLink cDe = AllDataFactory.create_ContentDocumentLink(cv, detail);
        insert cDe;
            
            List<ProdottiImagesPreviewController.productContainer> stringArray = ProdottiImagesPreviewController.getAttachments(parentId, 'purchase');
        }
        Test.stopTest();
        
    }
}