@isTest(seeAllData=true)
private class CaseTest {
    @isTest static void testEchoString() {             
        // This causes a fake response to be generated

        RecordTypeSetting__c rts    = RecordTypeSetting__c.getValues('General');

        Case c = new Case();
        c.subject = 'ad';
        c.Status = 'New';
        c.RecordTypeId = rts.Caso_OMS__c;
        insert c;

        System.debug('After Insert');

        c.Status = 'Closed';
        update c;
        
        Test.setMock(WebServiceMock.class, new WebServiceCloseCaseMockImpl());

        Test.startTest();

        System.debug('After Update');

        OnCaseTriggerHandler.CloseTicketCallout(new List<Case>{c});

        Test.stopTest();
    }
}