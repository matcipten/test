@isTest
public class CreateActivityTrackingControllerTest {

	@isTest static void testGetLabels(){
		CreateActivityTrackingController.getLabels();
	}

	@isTest static void testGetCategorie(){
		CreateActivityTrackingController.getCategorie();
	}

	@isTest static void testGetRecordTypes(){
		CreateActivityTrackingController.getRecordTypes();
	}

	@isTest static void testGetSelectedCustomer(){
		try{

			CreateActivityTrackingController.getSelectedCustomer('("asdasd")');
		}
		catch(Exception e) {

		}

		User usr = AllDataFactory.create_User();
		insert usr;

		Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		insert profileSettings;

		// Test.startTest();
		Account a;
		System.runAs(usr){

			a = AllDataFactory.create_PersonAccount_Birthday();
			insert a;
		}
		Test.startTest();
		CreateActivityTrackingController.getSelectedCustomer(a.Id);
		Test.stopTest();
	}

	@isTest static void testCreateNewActivityTracking(){

		User usr = AllDataFactory.create_User();
		insert usr;

		Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
		insert profileSettings;

		// Test.startTest();
		Account a;
		System.runAs(usr){

			try{

				CreateActivityTrackingController.createNewActivityTracking(null);
			}
			catch(Exception e) {

			}

			// User usr = AllDataFactory.create_User();
			// insert usr;

			// Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
			// insert profileSettings;

			// // Test.startTest();
			// Account a;
			// System.runAs(usr){

			//  a = AllDataFactory.create_PersonAccount_Birthday();
			//  insert a;
			// }

			Activity_Tracking__c at1 = AllDataFactory.create_Activity_Tracking('One_To_One');
			Activity_Tracking__c at2 = AllDataFactory.create_Activity_Tracking('Mailing');
			Test.startTest();
			CreateActivityTrackingController.createNewActivityTracking(at1);


			CreateActivityTrackingController.createNewActivityTracking(at2);
			Test.stopTest();
		}

	}

	@isTest static void getUserInfo(){
		User usr = AllDataFactory.create_User();
		usr.Codice_Associate__c = 'codiceAss';
		usr.Codice_Boutique__c = 'codiceBout';
		insert usr;

		Location__c location = new Location__c(Id_Location__c = 'codiceBout', Name = 'test');
		insert location;

		Associated__c associate = new Associated__c(Id_Associate__c = 'codiceAss', Name = 'test', Location__c= location.Id);
		insert associate;		

		System.runAs(usr){
			CreateActivityTrackingController.getUserInfo();
		}
	}
}