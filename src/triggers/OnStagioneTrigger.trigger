Trigger OnStagioneTrigger on Stagione__c (after update,after insert)
{


    List <Stagione__c> listaStagioniPrincipali = new List<Stagione__c>();

    if(trigger.isUpdate) {
        if(trigger.isAfter) {
            for(Stagione__c newStagione: Trigger.new) {

                Stagione__c oldStagione = Trigger.oldMap.get(newStagione.Id);

                if(newStagione.Stagione_principale__c == true && oldStagione.Stagione_principale__c == false)
                {
                    if(listaStagioniPrincipali.size() == 0) {
                        listaStagioniPrincipali.add(newStagione);
                    }
                    else
                        newStagione.addError(Label.OnStagioneTriggerLabel);
                }
            }

            if(listaStagioniPrincipali.size() == 1)
                OnStagioneTriggerHandler.recalculateStagioniPrincipali(listaStagioniPrincipali[0]);
        }
    }

    if(trigger.isInsert)
    {
        if(trigger.isAfter)
        {

            for(Stagione__c newStagione: Trigger.new)
            {
                if(newStagione.Stagione_principale__c == true)
                {
                    if(listaStagioniPrincipali.size() == 0) {
                        listaStagioniPrincipali.add(newStagione);
                    }
                    else{
                        newStagione.addError('Stai inserendo piu di una staggione principale');
                    }
                }
            }
            if(listaStagioniPrincipali.size() == 1)
                OnStagioneTriggerHandler.recalculateStagioniPrincipali(listaStagioniPrincipali[0]);
        }
    }

}