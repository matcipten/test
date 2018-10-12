@IsTest
public class EmailPublisherLoaderTest {

    static testmethod void simpleTestITA(){
        Exception failureDuringExecution = null;
        
        String recordTypeID = DescribeUtils.getRecordTypeId('Case', 'Customer_Care');

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