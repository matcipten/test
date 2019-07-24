public class OnStagioneTriggerHandler {


    public static void recalculateStagioniPrincipali(Stagione__c newStagione)
    {

        List <Stagione__c> listaStagioniCoinvolte = [
            SELECT Id, Stagione_principale__c, Categoria__c, Codice_Stagione__c
            FROM Stagione__c
            WHERE (Categoria__c = 'Sera' OR Categoria__c = 'Business' OR Stagione_principale__c = true)
            AND id != : newStagione.id
        ];

        for(Stagione__c stagione : listaStagioniCoinvolte) {
            stagione.Stagione_principale__c = false;

            if(stagione.Categoria__c == 'Sera' || stagione.Categoria__c == 'Business')
                stagione.Codice_Stagione__c = newStagione.Codice_Stagione__c;
        }

        update listaStagioniCoinvolte;


    }
}