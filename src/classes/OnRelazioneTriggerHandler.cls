public with sharing class OnRelazioneTriggerHandler{

    public static void DeleteRelazioni(list<Relazioni__c> rel){

        list<Relazioni__c> ListRelazioni    = new list<Relazioni__c>();
		set<string> RelazioniIds			= new set<string>();
        
        for(Relazioni__c r:rel){           
            RelazioniIds.add(r.Key_Relazione_Ghost__c);          
        }        

        ListRelazioni = [Select Id 
                         from Relazioni__c 
                         where Key_Relazione_Ghost__c IN:RelazioniIds];
              
        if(ListRelazioni.size()>0){      
            delete ListRelazioni;          
        }
          
    }

}