@IsTest
public class HomeBirthdayControllerTest {

	@isTest static void testGetLabels(){
		HomeBirthdayController.getLabels();
	}

	@isTest static void testGetTotalCount(){
		try{

			HomeBirthdayController.getTotalCount();
		}
		catch(Exception e) {

		}

		User usr = AllDataFactory.create_User();
		insert usr;

		Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		insert profileSettings;

		// Test.startTest();
		System.runAs(usr){

			Account a = AllDataFactory.create_PersonAccount_Birthday();
			insert a;
		}
		Test.startTest();
		HomeBirthdayController.getTotalCount();
		Test.stopTest();
	}


	@isTest static void testGetBirthdays(){

		try{

			HomeBirthdayController.getBirthdays(1,0);
		}
		catch(Exception e) {

		}


		User usr = AllDataFactory.create_User();
		insert usr;

		Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		insert profileSettings;

		// Test.startTest();
		System.runAs(usr){

			Account a = AllDataFactory.create_PersonAccount_Birthday();
			insert a;
		}
		Test.startTest();
		HomeBirthdayController.getBirthdays(1,0);
		Test.stopTest();
	}

}