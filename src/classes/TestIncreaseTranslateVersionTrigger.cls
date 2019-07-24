@isTest
public class TestIncreaseTranslateVersionTrigger {
    @isTest static void TestIncreaseTranslateVersion() {
   
            List<Translate__c> tns = new List<Translate__c>();
            for(Integer i=0;i<5;i++) {
                Translate__c tn = new Translate__c(Name = i+'_IT');
                tns.add(tn);
            }
            insert tns;

            Test.startTest();
            Translate__c t = tns[0];
            t.Increase_version__c = true;
            String versionText = 'This is a versioning test';
            t.Note_versionamento__c = versionText;
            String country = 'IT';
            update t;
            List<Translate__c> result = [SELECT Id,Note_versionamento__c FROM Translate__c WHERE Country_FRM__c = :country AND Increase_version__c = false AND N_versione__c = 1];
            Boolean issue = false;
            for (Translate__c tn1 :result){
                if (tn1.Note_versionamento__c != versionText)
                    issue = true;
            }
            Test.stopTest();

            System.assertEquals(false,issue);

            System.assertEquals(5,result.size());
        }
}