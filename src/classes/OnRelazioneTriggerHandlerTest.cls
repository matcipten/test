@isTest
private class OnRelazioneTriggerHandlerTest {

    static testMethod void DeleteRelazioniTest() {

	/*        
  	Test for: 
    - OnRelazioneTriggerHandler.DeleteRelazioni
    - OnRelazioneTrigger
  	*/        
        
        Relazioni__c r1   = new Relazioni__c();
        r1.Key_Relazione_Ghost__c = '0123456789';
        insert r1;
        
        Relazioni__c r2   = new Relazioni__c();
        r2.Key_Relazione_Ghost__c = '0123456789';
        insert r2;
        
		delete r1;
               
    }
    
}