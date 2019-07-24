public class NuovaRiparazioneController {

    @AuraEnabled
    public static String getRecordTypeId(String developerName){
        
        Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(developerName).getRecordTypeId();
        
        return (String) recordTypeId;
    }
}