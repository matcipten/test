@isTest
private class OnRelazioneGhostTriggerHandlerTest {

    static testMethod void CreateRelazioniTest() {

    /*        
  	Test for: 
    - OnRelazioneGhostTriggerHandler.CreateRelazioni
    - OnRelazioneGhostTrigger
  	*/      
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
        
        Account a1  = new Account();
        a1.LastName = 'TestLastName1';
        insert a1;
        
        Account a2	= new Account();
        a2.LastName = 'TestLastName2';
        insert a2;
        
        Relazione_Ghost__c r   				= new Relazione_Ghost__c();
        r.Cliente__c						= a1.Id;
        r.Cliente_in_Relazione__c			= a2.Id;
        r.Legame_Cliente__c					= 'Marito';
        r.Legame_Cliente_in_Relazione__c	= 'Moglie';
        insert r;
            
            }
        Test.stopTest();
             
    }
    
}