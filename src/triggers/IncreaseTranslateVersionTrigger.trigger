trigger IncreaseTranslateVersionTrigger on Translate__c (before update) {
    for(Translate__c tn : Trigger.New){
        if (tn.Increase_version__c == true){
                 if (tn.N_versione__c == null)
                     tn.N_versione__c = 0;
                 else
                    tn.N_versione__c= tn.N_versione__c + 1;
                 tn.Increase_version__c = false;
            for (Translate__c t1 : [SELECT Id FROM Translate__c WHERE Country_FRM__c = :tn.Country_FRM__c AND Id <> :tn.Id])
            {
                t1.N_versione__c = tn.N_versione__c;
                t1.Note_versionamento__c = tn.Note_versionamento__c;                
                t1.Richiedi_Firma__c = tn.Richiedi_Firma__c;
                update t1;
            }
        }
    }
}