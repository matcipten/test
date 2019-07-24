@isTest
private class TestOnStagioneTriggerHandler {
    @isTest
    static void TestOnTriggerHandler()
    {
        

    List <Stagione__c> stagioni = new List<Stagione__c>();
    Stagione__c stagioneSummer = 
    new Stagione__c(Name = 'Summer',Stagione_principale__c = true,Codice_Stagione__c = '1');
    

    Stagione__c stagioneWinter = 
    new Stagione__c(Name = 'Winter',Categoria__c = 'Stagionale',Stagione_principale__c = false,Codice_Stagione__c = '2');

    Stagione__c stagioneCasuale = 
    new Stagione__c(Name = 'Casuale',Stagione_principale__c = true,Codice_Stagione__c = '3');

    Stagione__c stagioneCasuale1 = 
    new Stagione__c(Name = 'Casuale',Categoria__c = 'Sera',Stagione_principale__c = false,Codice_Stagione__c = '3');


    Stagione__c stagioneSummer32 = 
    new Stagione__c(Name = 'Summer',Stagione_principale__c = true,Codice_Stagione__c = '1');
    
    Stagione__c stagioneSummer33 = 
    new Stagione__c(Name = 'Summer',Stagione_principale__c = true,Codice_Stagione__c = '1');

    Test.startTest();
    insert stagioneSummer;
    insert stagioneWinter;
    insert stagioneCasuale;
    insert stagioneCasuale1;
    Test.stopTest();

 
    }
    

}