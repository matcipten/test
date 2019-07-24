@isTest
public class NuovaRiparazioneControllerTest {
	
    @isTest(seeAllData=True)
    public static void testNuovaRiparazioneController(){
       String str = NuovaRiparazioneController.getRecordTypeId('Riparazione');
        
    }
}