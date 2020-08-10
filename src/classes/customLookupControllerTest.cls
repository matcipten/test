@isTest
public class customLookupControllerTest {

	@isTest static void testFetchLookUpValues(){
		User usr = AllDataFactory.create_User();
		insert usr;

		Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		insert profileSettings;

		Account a;
		System.runAs(usr){
			a = AllDataFactory.create_PersonAccount_Birthday();
			insert a;

			Test.startTest();
			customLookUpController.fetchLookUpValues('','Account','','', '','');
			customLookUpController.fetchLookUpValues(a.Name,'Account','','', '','');
			customLookUpController.fetchLookUpValues(a.Name,'Account','PersonEmail','', '','');
			Test.stopTest();
		}
	}

}