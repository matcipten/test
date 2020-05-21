@IsTest
public class EmailPublisherLoaderTest {

    static testmethod void simpleTestITA(){
        Exception failureDuringExecution = null;
        
        String recordTypeID = DescribeUtils.getRecordTypeId('Case', 'Customer_Care');
        RecordTypeSetting__c rst = new RecordTypeSetting__c(Name='General');
            rst.Caso_ResoCambio__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio');
            rst.Caso_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio_in_Store');
            rst.Caso_CustomerCare__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce');
            rst.Caso_BrandSpecialist__c = DescribeUtils.getRecordTypeId('Case', 'Brand_Specialist');
            rst.Caso_OMS__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_OMS');
            rst.Task_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Task', 'Reso_Cambio_in_Store');
            rst.Task_Wishlist__c = DescribeUtils.getRecordTypeId('Task', 'Wishlist');
            rst.Caso_NotifyMe__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce_Notify_Me');
            insert rst;
        //Entitlement entIta = new Entitlement(Name = 'Entitlement ITA');
        //insert entIta;
        
        Case c = new Case();
       //c.Name = 'Caso ITA';
        c.RecordTypeId = recordTypeID;
        insert c;

        String defaultsAsJSON = '[{"targetSObject":{"attributes":{"type":"EmailMessage"},"TextBody":"",'
            + '"FromName":"Test","FromAddress":"test@example.com","HtmlBody":"<html><body></body></html>","BccAddress":"test@example.com",'
            + '"CcAddress":"","ToAddress":"test@example.com","Subject":"Testing"},"contextId":"'
            + c.Id 
            + '","actionType":"Email",'
            + '"actionName":"Case.Email","fromAddressList":["salesforce@test.com"]}]';
            
        List<QuickAction.SendEmailQuickActionDefaults> defaultsSettings = 
            (List<QuickAction.SendEmailQuickActionDefaults>)JSON.deserialize(defaultsAsJSON, List<QuickAction.SendEmailQuickActionDefaults>.class);

        Test.startTest();
        
        try {
        
        
            (new EmailPublisherLoader()).onInitDefaults(defaultsSettings); 
            
        } catch(Exception failure) { 
            failureDuringExecution = failure; 
        }

        Test.stopTest();

        System.assertEquals(null, failureDuringExecution, 'There was an exception thrown during the test!');
    }
    
    
    static testmethod void simpleTestUSA(){
        //Create test data here
        Exception failureDuringExecution = null;
        
        String recordTypeID = DescribeUtils.getRecordTypeId('Case', 'Customer_Care_US');

        //Entitlement entUs = new Entitlement(Name = 'Entitlement US');
        //insert entUs;
        RecordTypeSetting__c rst = new RecordTypeSetting__c(Name='General');
            rst.Caso_ResoCambio__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio');
            rst.Caso_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio_in_Store');
            rst.Caso_CustomerCare__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce');
            rst.Caso_BrandSpecialist__c = DescribeUtils.getRecordTypeId('Case', 'Brand_Specialist');
            rst.Caso_OMS__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_OMS');
            rst.Task_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Task', 'Reso_Cambio_in_Store');
            rst.Task_Wishlist__c = DescribeUtils.getRecordTypeId('Task', 'Wishlist');
            rst.Caso_NotifyMe__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce_Notify_Me');
            insert rst;
        Case c = new Case();
        //c.Name = 'Caso UDA';
        c.RecordTypeId = recordTypeID;
        insert c;
        

        String defaultsAsJSON = '[{"targetSObject":{"attributes":{"type":"EmailMessage"},"TextBody":"",'
            + '"FromName":"Test","FromAddress":"test@example.com","HtmlBody":"<html><body></body></html>","BccAddress":"test@example.com",'
            + '"CcAddress":"","ToAddress":"test@example.com","Subject":"Testing"},"contextId":"'
            + c.Id 
            + '","actionType":"Email",'
            + '"actionName":"Case.Email","fromAddressList":["salesforce@test.com"]}]';
            
        List<QuickAction.SendEmailQuickActionDefaults> defaultsSettings = 
            (List<QuickAction.SendEmailQuickActionDefaults>)JSON.deserialize(defaultsAsJSON, List<QuickAction.SendEmailQuickActionDefaults>.class);

        Test.startTest();
        
        try {
        
        
            (new EmailPublisherLoader()).onInitDefaults(defaultsSettings); 
            
        } catch(Exception failure) { 
            failureDuringExecution = failure; 
        }

        Test.stopTest();

        System.assertEquals(null, failureDuringExecution, 'There was an exception thrown during the test!');
    }
    
  
    
}