public with sharing class CreateActivityTrackingController {

	/*@AuraEnabled
	   public static Map<String,String> getCanali(){
	    Map<String,String> canali = new Map<String,String>();
	    Schema.DescribeFieldResult fieldResult = Activity_Tracking__c.Canale__c.getDescribe();
	    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
	    for( Schema.PicklistEntry pickListVal : ple) {
	        canali.put(pickListVal.getValue(),pickListVal.getLabel());
	    }
	    return canali;
	   }*/


	@AuraEnabled
	public static Map<String,String> getGiftTipologiaPicklist(){
		//PN20190305 manage gift
		Map<String,String> giftLabels = new  Map<String,String>();
        

		Schema.DescribeSObjectResult giftDescribe = Attivita_Marketing__c.SobjectType.getDescribe();
		Map<String, Schema.SObjectField> giftFields = giftDescribe.fields.getMap();

		Schema.DescribeFieldResult giftPicklist = giftFields.get('Tipologia_Attivit_picklist__c').getDescribe();
		
		for (Schema.PicklistEntry f : giftPicklist.getPicklistValues()) {

            giftLabels.put(f.getValue(),f.getLabel());

		}
		
		return giftLabels;

		//PN20190305 manage gift END

	}

	@AuraEnabled(cacheable=true)
	public static Map<String,Map<String,String> > getLabels(){
		Map<String,Map<String,String> > allLabels = new Map<String,Map<String,String> >();
		Map<String,String> labels = new  Map<String,String>();
		Map<String,String> rtLabels = new  Map<String,String>();
		Map<String,String> canaleLabels = new  Map<String,String>();
		try{

			Schema.DescribeSObjectResult activityTrackingDescribe = Activity_Tracking__c.SobjectType.getDescribe();
			Map<String, Schema.SObjectField> fields = activityTrackingDescribe.fields.getMap();




			for(String fieldName : fields.keySet()) {
				String label = fields.get(fieldName).getDescribe().getLabel();
				label = label.replace('ID ','');
				label = label.replace(' ID','');
				labels.put(fieldName,label);
			}
			allLabels.put('labels',labels);

			Map<String,Schema.RecordTypeInfo> rts = activityTrackingDescribe.getRecordTypeInfosByDeveloperName();
			for(Schema.RecordTypeInfo rt : rts.values()) {
				rtLabels.put(rt.getDeveloperName(),rt.getName());
			}

			allLabels.put('rtLabels',rtLabels);

			Schema.DescribeFieldResult canalePicklist = fields.get('Canale__c').getDescribe();
			for (Schema.PicklistEntry f : canalePicklist.getPicklistValues()) {
				canaleLabels.put(f.getValue(),f.getLabel());

			}

			allLabels.put('picklist_labels_canale_c',canaleLabels);


			return allLabels;
		}
		catch(Exception e) {
			system.debug('problems to get fields');
			return new Map<String,Map<String,String> >();
		}

	}

	@AuraEnabled(cacheable=true)
	public static String getCategorie(){
		Map<String,Map<String,String> > categorie = new Map<String,Map<String,String> >();
		Schema.DescribeFieldResult fieldResult = Activity_Tracking__c.Categoria__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple) {
			String type = pickListVal.getValue().split('_')[0];
			Map<String,String> temp =  categorie.get(type);
			if(temp == null)
				temp = new Map<String,String>();
			temp.put(pickListVal.getValue(),pickListVal.getLabel());
			categorie.put(type,temp);
		}
		return JSON.serialize(categorie);
	}

	@AuraEnabled(cacheable=true)
	public static Map<String,Map<String,String> > getRecordTypes(){
		Map<String,Map<String,String> > recordTypesMap = new Map<String,Map<String,String> >();
		Map<String,Schema.RecordTypeInfo> rts = Schema.SObjectType.Activity_Tracking__c.getRecordTypeInfosByDeveloperName();
		for(Schema.RecordTypeInfo rt : rts.values()) {
			Map<String,String> singleRtType = new Map<String,String>();
			singleRtType.put('Id',rt.getRecordTypeId());
			singleRtType.put('Name',rt.getName());
			singleRtType.put('DeveloperName',rt.getDeveloperName());
			recordTypesMap.put(rt.getDeveloperName(),singleRtType);
		}
		return recordTypesMap;
	}

	@AuraEnabled
	public static String createNewActivityTracking(Activity_tracking__c newActivityTracking){
		system.debug(newActivityTracking);
		
		//Akshay Start
		//VS - Skip for BC's Contact 
		if(!newActivityTracking.Categoria__c.startsWith('BC_')){
			Schema.DescribeFieldResult fieldResult = Campaign.Categoria__c.getDescribe();
			List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
			for( Schema.PicklistEntry pickListVal : ple){
				System.debug('Akshay : ' + pickListVal.getValue() + pickListVal.getValue().split('_')[1].equals(newActivityTracking.Categoria__c));
				
				if(pickListVal.getValue().split('_')[1].equals(newActivityTracking.Categoria__c.split('_')[1])){
					if(pickListVal.getValue().split('_')[0].contains(newActivityTracking.Categoria__c.split('_')[0])){
						newActivityTracking.Categoria__c = pickListVal.getValue();
						break;
					}
					
				}
			}
		}
		System.debug('categoriaValue1 : ' + newActivityTracking.Categoria__c);

		//Akshay End

		// String recordType = newActivityTracking.RecordTypeId;

		// Map<String,String> recordTypesMap = new Map<String,String>();
		// Map<String,Schema.RecordTypeInfo> rts = Schema.SObjectType.Activity_Tracking__c.getRecordTypeInfosByDeveloperName();
		// for(Schema.RecordTypeInfo rt : rts.values()) {
		//  if(rt.getRecordTypeId() == recordType) {
		//      recordType = rt.getDeveloperName();
		//      break;
		//  }
		// }
		// if(recordType == 'One_To_One') {
		//  newActivityTracking.Note_Contatto__c = null;
		// }
		// else if(recordType == 'Mailing') {
		//  newActivityTracking.Location__c = null;
		//  newActivityTracking.Location_Instore__c = null;
		//  newActivityTracking.Location_Out_of_store__c = null;
		// }

		insert newActivityTracking;

		return newActivityTracking.Id;
	}

	@AuraEnabled
	public static Account getSelectedCustomer(String accountId){
		try{
			List<Account> customers = [SELECT Id,Name FROM Account WHERE Id = :accountId];
			if(customers != null && customers.size() > 0) {
				Account customer = customers.get(0);
				return customer;
			}
			else
				return new Account();
		}
		catch(Exception e) {
			system.debug('some problems to get currect account');
			return new Account();
		}
	}

	@AuraEnabled
	public static Id setCampaignOTWithSelectedRecord(String categoriaValue, String tipoDevNameValue){
        System.debug('categoriaValue : ' + categoriaValue);
		System.debug('tipoDevNameValue : ' + tipoDevNameValue);
		
		Schema.DescribeFieldResult fieldResult = Campaign.Categoria__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple){
			System.debug('Akshay : ' + pickListVal.getValue() + pickListVal.getValue().split('_')[1].equals(categoriaValue));
			
			if(pickListVal.getValue().split('_')[1].equals(categoriaValue.split('_')[1])){
				if(pickListVal.getValue().split('_')[0].contains(categoriaValue.split('_')[0])){
					categoriaValue = pickListVal.getValue();
					break;
				}
				
			}
		}    
		System.debug('categoriaValue1 : ' + categoriaValue);
		List<Campaign> camp =  [SELECT Id,Name
		                        FROM CAMPAIGN
		                        WHERE RecordType.DeveloperName =:tipoDevNameValue
		                                                         AND Categoria__c =: categoriaValue
		                                                                            AND Default_for_Activity_Tracking__c =  true
		                                                                                                                   Order By CreatedDate Desc
		                                                                                                                   LIMIT 1];

		return camp[0].Id;

	}

	@AuraEnabled
	public static String createGift(String tipo,String accountId,String actId,Date activityDate,String note){

		List<Associated__c> associates = new List<Associated__c>();
		Associated__c associate = null;
		Attivita_Marketing__c gift;

		List<Activity_tracking__c> act = new List<Activity_tracking__c>();

		User mySelf = [Select Id, Codice_Associate__c,Profile.Name,Codice_Boutique__c FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];

		try{

			try{
				if(mySelf.Profile.Name == 'BC - Boutique' || mySelf.Profile.Name == 'BC - Boutique SG TW') {
					List<Location__c> locations = [SELECT Id,Id_Store_Manager__c,Id_Location_Micros__c FROM Location__c WHERE Id_Location_Micros__c  = :mySelf.Codice_Boutique__c];
					if(locations != null && locations.size() > 0) {
						String storeManagerId = locations[0].Id_Store_Manager__c;
						if(storeManagerId != null && storeManagerId != '') {
							associates = [SELECT Id FROM Associated__c WHERE Id_Associate_Micros__c = :storeManagerId ORDER BY LastModifiedDate DESC LIMIT 1];
							if(associates != null && associates.size() > 0)
								associate = associates[0];
						}
					}
				}
				else if(mySelf.Profile.Name == 'BC - Associate'){
					associates = [SELECT Id FROM Associated__c WHERE Id_Associate_Micros__c = :mySelf.Codice_Associate__c ORDER BY LastModifiedDate DESC LIMIT 1];
					if(associates != null && associates.size() > 0)
						associate = associates[0];
				}
			}
			catch(Exception e1) {
				associate = null;
			}

			if(associate != null)
				gift = new Attivita_Marketing__c(Tipologia_Attivit_picklist__c=tipo,Cliente__c=accountId,Data__c=activityDate,Associate__c=associate.Id,Note__c=note);
			else
				gift = new Attivita_Marketing__c(Tipologia_Attivit_picklist__c=tipo,Cliente__c=accountId,Data__c=activityDate,Note__c=note);


			insert gift;

			act = [SELECT id, Gift__c  FROM Activity_tracking__c WHERE id = :actId];
			system.debug('MCIPE '+act);

			if(act !=null && act.size() > 0){
				act[0].Gift__c = gift.Id;
				update act;
			}

			return (String) gift.Id;
		}
		catch(Exception e) {
			system.debug(e.getMessage());
			return null;
		}

	}


	@AuraEnabled
	public static Integer updateGiftWithImage(String giftId, String imageId){

		try{

			Attivita_Marketing__c gift = [SELECT Id, Product_Image_Reference__c FROM Attivita_Marketing__c WHERE Id = :giftId LIMIT 1];

			ContentVersion cv = [SELECT Id FROM ContentVersion WHERE ContentDocumentId = :imageId AND IsLatest = true LIMIT 1];

			gift.Product_Image_Reference__c = cv.Id;
			update gift;

			return 1;
		}
		catch(Exception e) {
			system.debug(e.getMessage());
			return 0;
		}

	}
	// private final static Integer MAX_RESULTS = 5;

	// @AuraEnabled
	// public static List<LookupSearchResult> search(String searchTerm, List<String> selectedIds, String objectName) {
	//  // Prepare query paramters
	//  searchTerm += '*';
	//  String query = 'FIND \''+searchTerm+'\' IN ALL FIELDS RETURNING '+objectName+' (Name WHERE id NOT IN :selectedIds) LIMIT '+MAX_RESULTS;
	//  system.debug(query);
	//  // Execute search query
	//  List<List<SObject> > searchResults = search.query(query);

	//  // Prepare results
	//  List<LookupSearchResult> results = new List<LookupSearchResult>();

	//  // Extract Accounts & convert them into LookupSearchResult
	//  String accountIcon = 'standard:account';
	//  SObject [] objects = searchResults[0];
	//  for (SObject obj : objects) {
	//      results.add(new LookupSearchResult((String)obj.get('Id'), objectName, accountIcon,(String) obj.get('Name'), ''));
	//  }

	//  /*// Extract Opportunities & convert them into LookupSearchResult
	//     String opptyIcon = 'standard:opportunity';
	//     Opportunity [] opptys = ((List<Opportunity>) searchResults[1]);
	//     for (Opportunity oppty : opptys) {
	//      results.add(new LookupSearchResult(oppty.Id, 'Opportunity', opptyIcon, oppty.Name, 'Opportunity • '+ oppty.StageName));
	//     }*/

	//  return results;
	// }

	// PALUMBO (START)
	@AuraEnabled
    public static WrapperValues getUserInfo(){
		WrapperValues wrapper = new WrapperValues();
        User u = [SELECT ID, Name, Codice_Associate__c,Codice_Boutique__c	FROM User WHERE ID=: UserInfo.getUserId()];
		if (u.Codice_Associate__c != null){
			List<Associated__c> associates = [SELECT Id, Name, Id_Associate_Micros__c FROM Associated__c WHERE Id_Associate_Micros__c =:u.Codice_Associate__c LIMIT 1];
			if (!associates.isEmpty()){
				Associated__c ass = associates.get(0);
				wrapper.ass = new WrapperItem(ass.Id,ass.Name,ass.Id_Associate_Micros__c);
			}
		}

		if (u.Codice_Boutique__c != null){
			List<Location__c> locations = [SELECT Id, Name, Id_Location_Micros__c FROM Location__c WHERE Id_Location_Micros__c =:u.Codice_Boutique__c LIMIT 1];
			if (!locations.isEmpty()){
				Location__c loc = locations.get(0);
				wrapper.bout = new WrapperItem(loc.Id,loc.Name,loc.Id_Location_Micros__c);
			}
		}

		return wrapper;
	} 
	@AuraEnabled
	public static Boolean getUserCheckProfile(){
		User u = [SELECT Id,name, profile.Name	FROM User WHERE ID=: UserInfo.getUserId()];
		if(u.profile.Name=='BC - CRM Local' || u.profile.Name=='System Administrator' || u.profile.Name=='BC - Customer Care 1° Level'|| u.profile.Name=='BC - Customer Care 1° Level US')
			return true;
		else
			return false;
	}

	@AuraEnabled
	public static Activity_Tracking_s_Icons__c getValueFromStaticResource(){
		return Activity_Tracking_s_Icons__c.getInstance();
	}

	@AuraEnabled
	public static Boolean getBCUSerInfo(){
		Map<Id, User> m = new Map<Id, User>([SELECT id, name
											FROM user 
											WHERE id in 
												(SELECT userorgroupid FROM groupmember WHERE group.DeveloperName = 'User_BC_s_Contact')]);

		return m.containsKey(UserInfo.getUserId());
		
	}

	public class WrapperValues{
		@AuraEnabled		
		public WrapperItem bout{get;set;}
		@AuraEnabled	
		public WrapperItem ass {get;set;}
	}

	public class WrapperItem{	
		@AuraEnabled		
		public String Id;
		@AuraEnabled
		public String Name;
		@AuraEnabled
		public String value;

		public WrapperItem(String i, String name, String value){
			this.Id = i;
			this.Name = name;
			this.value = value;
		}
	}	
	// PALUMBO (START)
}