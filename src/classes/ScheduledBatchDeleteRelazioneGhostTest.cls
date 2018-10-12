@isTest
private class ScheduledBatchDeleteRelazioneGhostTest {

    static testMethod void DeleteRelazioniTest() {

	/*        
  	Test for: 
    - ScheduledBatchDeleteRelazioneGhost
    - BatchDeleteRelazioneGhost
  	*/        
        
        Relazione_Ghost__c r   				= new Relazione_Ghost__c();
        r.Legame_Cliente__c					= 'Marito';
        r.Legame_Cliente_in_Relazione__c	= 'Moglie';
        insert r;
        
        Admin_Setting__c e 			= new Admin_Setting__c();
        e.Email_Notifica_Batch__c 	= 'test@test.test';
		insert e;
        
		Test.startTest();

        ScheduledBatchDeleteRelazioneGhost sbac = new ScheduledBatchDeleteRelazioneGhost();        
    	SchedulableContext sc;
    	sbac.execute(sc);
    
        Test.stopTest();
               
    }
    
}