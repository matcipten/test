public with sharing class CampaignMemberListViewController {
@AuraEnabled
public static Boolean verifyUser(){
	Boolean verifyUserProfile = true;
	User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
	if(user.Nome_Profilo__c == 'BC - Associate' || user.Nome_Profilo__c == 'BC - Boutique') {
		verifyUserProfile = false;
	}
	system.debug('verifyUserProfile :' + verifyUserProfile );
	return verifyUserProfile;
}
@AuraEnabled
public static Campaign getCampaign(Id campaignId){
	return [Select Id,Name FROM Campaign WHERE Id =: campaignId LIMIT 1];
}
@AuraEnabled
public static List<CampaignMember> getCampaignMembers(Id campaignId, integer offset){
	List<CampaignMember> campMemList =  new List<CampaignMember>();
	List<Account> accList =  new  List<Account>();
	List<Id> tempIds =  new List<Id>();

	system.debug('GetCampaignMembers');
	try{
		//offset =  offset * 2 ;
		User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
		system.debug(user);
		if(user.Nome_Profilo__c ==  'BC - Associate') {
			system.debug('BC - Associate');
			accList = [SELECT Contact_ID__pc FROM Account where Id_Associate__c = :user.Codice_Associate__c  ];
			system.debug(accList);
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug('DEBUG tempIds = '+ tempIds);
				campMemList = queryCampaignMember(campaignId,tempIds,offset);
				system.debug('DEBUG campMemList.size = '+campMemList.size());
			}

		}else if(user.Nome_Profilo__c == 'BC - Boutique') {
			system.debug('BC - Boutique');
			accList = [SELECT Contact_ID__pc FROM Account where Id_Location__c = :user.Codice_Boutique__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug('DEBUG tempIds = '+ tempIds);
				campMemList = queryCampaignMember(campaignId,tempIds,offset);
			}
			system.debug('DEBUG campMemList.size = '+campMemList.size());

		}else{
			campMemList = [SELECT Id,type,Status, FirstName, LastName, Title,CompanyOrAccount,campaign.Name, ContactId,Contact.Account.Name,Contact.Account.Privacy3__c,Contact.Account.Privacy1__c,Contact.Account.Privacy2__c,
			               Contact.Account.Associate__r.Name, Contact.Account.Data_Ultimo_Acquisto__c, Contact.Account.Importo_Acquisti_Totale__c, Contact.Account.Marketing_FRM__c
			               FROM CampaignMember
			               WHERE CampaignId =: campaignId
			                                  LIMIT 20 OFFSET :offset];
		}
		system.debug(campMemList.size());
	} Catch(Exception ex){
		throw new AuraHandledException('exceptionText');
	}

	return (campMemList.size()>0) ? campMemList : null;
}
@AuraEnabled
public static List<CampaignMember> getAllCampaignMembers(Id campaignId){
	List<CampaignMember> campMemList =  new List<CampaignMember>();
	List<Account> accList =  new  List<Account>();
	List<Id> tempIds =  new List<Id>();

	system.debug('Aksa');
	try{
		//offset =  offset * 2 ;
		User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
		system.debug(user);
		if(user.Nome_Profilo__c ==  'BC - Associate') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Associate__c = :user.Codice_Associate__c  ];
			system.debug(accList);
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds);
				campMemList = queryAllCampaignMember(campaignId,tempIds);
			}

		}else if(user.Nome_Profilo__c == 'BC - Boutique') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Location__c = :user.Codice_Boutique__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds.size());
				campMemList = queryAllCampaignMember(campaignId,tempIds);
			}
			system.debug(campMemList.size());

		}else{
			campMemList = [SELECT Id,type,Status, FirstName, LastName, Title,CompanyOrAccount,campaign.Name, ContactId,Contact.Account.Name,Contact.Account.Privacy3__c,Contact.Account.Privacy1__c,Contact.Account.Privacy2__c,
			               Contact.Account.Associate__r.Name, Contact.Account.Data_Ultimo_Acquisto__c, Contact.Account.Importo_Acquisti_Totale__c, Contact.Account.Marketing_FRM__c
			               FROM CampaignMember
			               WHERE CampaignId =: campaignId LIMIT 9999];
		}
		system.debug(campMemList.size());
	} Catch(Exception ex){
		throw new AuraHandledException('exceptionText');
	}
	return (campMemList.size()>0) ? campMemList : null;
}
@AuraEnabled
public static Integer getTotalNumberOfCampaignMems(Id campaignId){
	List<CampaignMember> campMemList =  new List<CampaignMember>();
	List<Account> accList =  new  List<Account>();
	List<Id> tempIds =  new List<Id>();
	Integer result =  0;
	system.debug('Aksa');
	try{
		//offset =  offset * 2 ;
		User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
		system.debug(user);
		if(user.Nome_Profilo__c ==  'BC - Associate') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Associate__c = :user.Codice_Associate__c  ];
			system.debug(accList);
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds);
				result = queryTotalCampaignMember(campaignId,tempIds);
				//result =  campMemList.size();
			}

		}else if(user.Nome_Profilo__c == 'BC - Boutique') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Location__c = :user.Codice_Boutique__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds.size());
				result = queryTotalCampaignMember(campaignId,tempIds);
				//result =  campMemList.size();
			}
			system.debug(campMemList.size());

		}else{
			result  = [SELECT count()
			           FROM CampaignMember
			           WHERE CampaignId =: campaignId ];
		}
		system.debug(campMemList.size());
	} Catch(Exception ex){
		throw new AuraHandledException('exceptionText');
	}
	return result;
}
@AuraEnabled
public static List<CampaignMember> searchCamapaignMembers(Id campaignId, String searchText){
	List<CampaignMember> campMemList =  new List<CampaignMember>();
	List<Account> accList =  new  List<Account>();
	List<Id> tempIds =  new List<Id>();
	String key= '%'+searchText+'%';
	system.debug('Aksa');
	try{

		User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];

		if(user.Nome_Profilo__c ==  'BC - Associate') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Associate__c = :user.Codice_Associate__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				campMemList = queryCampaignMember(campaignId,tempIds,key);
			}

		}else if(user.Nome_Profilo__c == 'BC - Boutique') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Location__c = :user.Codice_Boutique__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				campMemList = queryCampaignMember(campaignId,tempIds,key);
			}


		}else{
			campMemList = [SELECT Id,type,Status, FirstName, LastName, Title,CompanyOrAccount,campaign.Name, ContactId,Contact.Account.Name,Contact.Account.Privacy3__c,Contact.Account.Privacy1__c,Contact.Account.Privacy2__c,
			               Contact.Account.Associate__r.Name, Contact.Account.Data_Ultimo_Acquisto__c, Contact.Account.Importo_Acquisti_Totale__c, Contact.Account.Marketing_FRM__c
			               FROM CampaignMember
			               WHERE CampaignId =: campaignId
			                                  AND Name LIKE :key
			                                  LIMIT 50];
		}

	} Catch(Exception ex){
		throw new AuraHandledException('exceptionText');
	}
	return (campMemList.size()>0) ? campMemList : null;


	//return [Select Id,type,Status , FirstName, LastName, Title,CompanyOrAccount FROM CampaignMember  Where Name Like :j];
}
@AuraEnabled
public static List<Contact> searchContact(String searchText,List<String> contactsSelected){
	system.debug('Akshay');
	String key= '%'+searchText+'%';
	List<Contact> contList =  new List<Contact>();
	List<Account> accList =  new  List<Account>();
	List<Id> tempIds =  new List<Id>();
	system.debug('Akshay');
	try{

		Set<String> contactsSelectedSet = new Set<String>(contactsSelected);

		User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
		system.debug(user);
		if(user.Nome_Profilo__c ==  'BC - Associate') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Associate__c = :user.Codice_Associate__c  ];
			system.debug(accList);
			if(accList.size()>0) {
				for(Account ac : accList) {
					if(!contactsSelectedSet.contains(ac.Contact_ID__pc))
						tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds);
				contList = queryContacts(tempIds, key);
			}

		}else if(user.Nome_Profilo__c == 'BC - Boutique') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Location__c = :user.Codice_Boutique__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					if(!contactsSelectedSet.contains(ac.Contact_ID__pc))
						tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds.size());
				contList = queryContacts(tempIds, key);
			}
			system.debug(contList.size());

		}else{
			contList = [SELECT Id,Name,Account.Name, Phone, Email, Owner.Name
			            FROM Contact
			            WHERE Name LIKE :key LIMIT 50];
		}
		system.debug(contList.size());
	} Catch(Exception ex){
		throw new AuraHandledException('exceptionText');
	}
	return (contList.size()>0) ? contList : null;

}
@auraEnabled
public static List<Contact> getContacts(Integer offset){
	List<Contact> contList =  new List<Contact>();
	List<Account> accList =  new  List<Account>();
	List<Id> tempIds =  new List<Id>();
	system.debug('Akshay : '+offset);
	try{

		User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
		system.debug(user);
		if(user.Nome_Profilo__c ==  'BC - Associate') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Associate__c = :user.Codice_Associate__c  ];
			system.debug(accList);
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds);
				contList = queryContacts(tempIds, offset);
			}

		}else if(user.Nome_Profilo__c == 'BC - Boutique') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Location__c = :user.Codice_Boutique__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds.size());
				contList = queryContacts(tempIds, offset);
			}
			system.debug(contList.size());

		}else{
			contList = [SELECT Id,Name,Account.Name, Phone, Email, Owner.Name , Marketing_FRM__c
			            FROM Contact
			            LIMIT 20 OFFSET :offset];
		}
		system.debug(contList.size());
	} Catch(Exception ex){
		throw new AuraHandledException('exceptionText');
	}
	system.debug('contList : '+contList);
	return (contList.size()>0) ? contList : null;

}
@auraEnabled
public static List<Contact> getAllContacts(){
	List<Contact> contList =  new List<Contact>();
	List<Account> accList =  new  List<Account>();
	List<Id> tempIds =  new List<Id>();
	system.debug('Akshay');
	try{

		User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
		system.debug(user);
		if(user.Nome_Profilo__c ==  'BC - Associate') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Associate__c = :user.Codice_Associate__c  ];
			system.debug(accList);
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds);
				contList = queryAllContacts(tempIds);
			}

		}else if(user.Nome_Profilo__c == 'BC - Boutique') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Location__c = :user.Codice_Boutique__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds.size());
				contList = queryAllContacts(tempIds);
			}
			system.debug(contList.size());

		}else{
			contList = [SELECT Id,Name,Account.Name, Phone, Email, Owner.Name
			            FROM Contact LIMIT 99];
		}
		system.debug(contList.size());
	} Catch(Exception ex){
		throw new AuraHandledException('exceptionText');
	}
	return (contList.size()>0) ? contList : null;

}
@auraEnabled
public static Integer getTotalNumberOfContacts(){
	List<Contact> contList =  new List<Contact>();
	List<Account> accList =  new  List<Account>();
	List<Id> tempIds =  new List<Id>();
	Integer result = 0;
	system.debug('Akshay');
	try{

		User user = [SELECT Id, LastName, Codice_Boutique__c, Id_Store_Manager__c, Codice_Associate__c, Nome_Profilo__c FROM User WHERE Id=:UserInfo.getUserId()];
		system.debug(user);
		if(user.Nome_Profilo__c ==  'BC - Associate') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Associate__c = :user.Codice_Associate__c  ];
			system.debug(accList);
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds);
				result = queryTotalContacts(tempIds);
			}

		}else if(user.Nome_Profilo__c == 'BC - Boutique') {
			accList = [SELECT Contact_ID__pc FROM Account where Id_Location__c = :user.Codice_Boutique__c  ];
			if(accList.size()>0) {
				for(Account ac : accList) {
					tempIds.add(ac.Contact_ID__pc);
				}
				system.debug(tempIds.size());
				result = queryTotalContacts(tempIds);
			}
			system.debug(contList.size());

		}else{
			result = [SELECT count()
			          FROM Contact];
		}
		system.debug(result);
	} Catch(Exception ex){
		throw new AuraHandledException('exceptionText');
	}
	return result;

}


@AuraEnabled
public static Map < String, String > getselectOptions(sObject objObject, string fld) {
	system.debug('objObject --->' + objObject);
	system.debug('fld --->' + fld);
	try{
		Map < String, String > allOpts = new Map < String, String > ();
		// Get the object type of the SObject.
		Schema.sObjectType objType = objObject.getSObjectType();

		// Describe the SObject using its object type.
		Schema.DescribeSObjectResult objDescribe = objType.getDescribe();

		// Get a map of fields for the SObject
		map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();

		// Get the list of picklist values for this field.
		list < Schema.PicklistEntry > values =
			fieldMap.get(fld).getDescribe().getPickListValues();

		system.debug('values --->' + values);

		// Add these values to the selectoption list.
		for (Schema.PicklistEntry a: values) {
			allOpts.put(a.getLabel(), a.getValue());
		}
		system.debug('allOpts ---->' + allOpts);
		return allOpts;
	}catch(Exception exp) {
		system.debug('Exp :  ' + exp.getMessage());
		return null;
	}

}
@AuraEnabled
public static List<CampaignMember> insertContactsAsCampaignMem(List<Id> contactId, String Status, Id camp, String modifyStatus){
	List<CampaignMember> camMempList =   new List<CampaignMember>();
	List<CampaignMember> queryCamMempList =   new List<CampaignMember>();
	Map<Id,CampaignMember> mapCm =  new Map<Id,CampaignMember>();
	system.debug(contactId);
	system.debug(Status);
	system.debug(camp);

	try{
		List<CampaignMember> contactsExistInCM =  [SELECT Id, ContactId
		                                           FROM CampaignMember
		                                           WHERE ContactId IN :contactId and CampaignId =:camp
		];

		for(CampaignMember cm  :  contactsExistInCM) {
			mapCm.put(cm.ContactId,cm);
		}
		system.debug(mapCm);

		for(Id cmId : contactId) {
			if(mapCm.containsKey(cmId)) {
				mapCm.get(cmId).status = Status;
			}else{
				CampaignMember cm =  new CampaignMember();
				cm.CampaignId =  camp;
				cm.ContactId =  cmId;
				cm.Status =  Status;

				camMempList.add(cm);
			}


		}
		system.debug(camMempList);
		//Updates only when user want to modify the status
		if(modifyStatus != 'keepExisting') {
			update mapCm.values();
		}

		insert camMempList;
		system.debug(camMempList);
		queryCamMempList = getCampaignMembers(camp, 0);
	} Catch(Exception ex){
		throw new AuraHandledException(ex.getMessage());
	}
	system.debug('queryCamMempList :' + queryCamMempList);
	return queryCamMempList;
}
@AuraEnabled
public static void deleteCampaignMembers(List<Id> campMemIds){
	system.debug('campMemIds :'+ campMemIds);
	List<CampaignMember> campMemList =  [SELECT Id FROM CampaignMember WHERE Id IN: campMemIds];
	system.debug('campMemList : ' + campMemList);
	delete campMemList;

}
public static List<CampaignMember> queryCampaignMember(Id campaignId, List<Id> contactIds,Integer offset){

	List<CampaignMember> campList = [SELECT Id,type,Status, FirstName, LastName, Title,CompanyOrAccount,campaign.Name, ContactId,Contact.Account.Name,Contact.Account.Privacy3__c,Contact.Account.Privacy1__c,Contact.Account.Privacy2__c,
	                                 Contact.Account.Associate__r.Name, Contact.Account.Data_Ultimo_Acquisto__c, Contact.Account.Importo_Acquisti_Totale__c, Contact.Account.Marketing_FRM__c
	                                 FROM CampaignMember
	                                 WHERE CampaignId =: campaignId
	                                                    AND ContactId IN :contactIds
	                                                    Order By LastName
	                                                    LIMIT 20 OFFSET :Integer.valueOf(offset)
	];
	system.debug(campList.size());
	return campList;
}
public static List<CampaignMember> queryAllCampaignMember(Id campaignId, List<Id> contactIds){

	List<CampaignMember> campList = [SELECT Id,type,Status, FirstName, LastName, Title,CompanyOrAccount,campaign.Name, ContactId,Contact.Account.Name,Contact.Account.Privacy3__c,Contact.Account.Privacy1__c,Contact.Account.Privacy2__c,
	                                 Contact.Account.Associate__r.Name, Contact.Account.Data_Ultimo_Acquisto__c, Contact.Account.Importo_Acquisti_Totale__c, Contact.Account.Marketing_FRM__c
	                                 FROM CampaignMember
	                                 WHERE CampaignId =: campaignId
	                                                    AND ContactId IN :contactIds
	                                                    Order By LastName
	                                                    LIMIT 25
	];
	system.debug(campList.size());
	return campList;
}

public static Integer queryTotalCampaignMember(Id campaignId, List<Id> contactIds){

	Integer campList = [SELECT count()
	                    FROM CampaignMember
	                    WHERE CampaignId =: campaignId
	                                       AND ContactId IN :contactIds

	];
	system.debug(campList);
	return campList;
}

public static List<CampaignMember> queryCampaignMember(Id campaignId, List<Id> contactIds, String key){

	List<CampaignMember> campList = [SELECT Id,type,Status, FirstName, LastName, Title,CompanyOrAccount,campaign.Name, ContactId,Contact.Account.Name,Contact.Account.Privacy3__c,Contact.Account.Privacy1__c,Contact.Account.Privacy2__c,
	                                 Contact.Account.Associate__r.Name, Contact.Account.Data_Ultimo_Acquisto__c, Contact.Account.Importo_Acquisti_Totale__c, Contact.Account.Marketing_FRM__c
	                                 FROM CampaignMember
	                                 WHERE CampaignId =: campaignId
	                                                    AND ContactId IN :contactIds
	                                                    AND Name Like :key
	                                                    LIMIT 50];
	return campList;
}
public static List<Contact> queryContacts(List<Id> contactIds, Integer offset){

	List<Contact> contList = [SELECT Id,Name,Account.Name, Phone, Email, Owner.Name , Marketing_FRM__c
	                          FROM Contact
	                          WHERE Id IN :contactIds
	                          LIMIT 20 OFFSET :Integer.valueOf(offset)
	];
	return contList;
}
public static List<Contact> queryAllContacts(List<Id> contactIds){

	List<Contact> contList = [SELECT Id,Name,Account.Name, Phone, Email, Owner.Name
	                          FROM Contact
	                          WHERE Id IN :contactIds
	                          LIMIT 9999
	];
	return contList;
}
public static Integer queryTotalContacts(List<Id> contactIds){

	Integer contList = [SELECT count()
	                    FROM Contact
	                    WHERE Id IN :contactIds
	];
	return contList;
}
public static List<Contact> queryContacts(List<Id> contactIds, String key){

	List<Contact> contList = [SELECT Id,Name,Account.Name, Phone, Email, Owner.Name
	                          FROM Contact
	                          WHERE Id IN :contactIds
	                          AND Name Like :key
	                          LIMIT 50
	];
	return contList;
}

@AuraEnabled
public static User getUserInfo(){
	Map <String,Schema.SObjectField> fieldList = Schema.getGlobalDescribe().get('User').getDescribe().fields.getMap();

	String query = 'SELECT';

	for(String field: fieldList.keySet()) {
		query+= ' '+field+',';
	}

	query = query.substring(0,query.length()-1);
	query += ' FROM User WHERE Id = \''+UserInfo.getUserId()+'\'';


	User myUser =  (User)Database.query(query);

	system.debug(JSON.serializePretty(myUser));

	return myUser;
}


}