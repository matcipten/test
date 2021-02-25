public with sharing class customLookUpController {
	/* @AuraEnabled
	   public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName) {
	     system.debug('ObjectName-->' + ObjectName);
	     String searchKey = searchKeyWord + '%';

	     List < sObject > returnList = new List < sObject > ();

	     // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5
	     String sQuery = '';
	     if(UserInfo.isMultiCurrencyOrganization() && ObjectName == 'CurrencyType'){
	         if(searchKeyWord == null || searchKeyWord == ''){
	             sQuery = 'SELECT Id, IsoCode FROM ' +ObjectName + ' WHERE IsActive = true order by IsoCode ASC';
	         }
	         else
	             sQuery = 'SELECT IsoCode FROM ' +ObjectName + ' WHERE IsActive = true AND Name LIKE: searchKey order by IsoCode DESC limit 5';
	     }
	     else{
	         sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
	     }
	     //String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
	     List < sObject > lstOfRecords = Database.query(sQuery);

	     for (sObject obj: lstOfRecords) {
	         returnList.add(obj);
	     }
	     return returnList;
	   }*/

	@AuraEnabled
	public static List < sObject > fetchLookUpValues(String searchKeyWord, String ObjectName, String searchObjectKey,String searchObjectValue, String filter, String idLocMicros) {
		system.debug('ObjectName-->' + ObjectName);
		system.debug('searchKeyWord-->' + searchKeyWord);
		system.debug('searchObjectKey-->' + searchObjectKey);
		system.debug('searchObjectValue-->' + searchObjectValue);
		system.debug('filter-->' + filter);
		String searchKey = '%' + searchKeyWord + '%';
		user u = [SELECT Id, Name, Nation_Contact_Card__c, Language_Contact_Card__c, Department__c, Codice_Boutique__c, Canale_di_Vendita__c, Profile.Name  FROM User WHERE Id =: UserInfo.getuserid() ];
		System.debug('VS user: '+u);
		List < sObject > returnList = new List < sObject > ();

		Map <String, Schema.SObjectField> fieldsMap = Schema.getGlobalDescribe().get(ObjectName).getDescribe().fields.getMap();

		// Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5
		String sQuery = '';
		// if(UserInfo.isMultiCurrencyOrganization() && ObjectName == 'CurrencyType'){
		//  if(searchKeyWord == null || searchKeyWord == ''){
		//      sQuery = 'SELECT Id, IsoCode FROM ' +ObjectName + ' WHERE IsActive = true order by IsoCode ASC';
		//  }
		//  else
		//      sQuery = 'SELECT IsoCode FROM ' +ObjectName + ' WHERE IsActive = true AND Name LIKE: searchKey order by IsoCode DESC limit 5';
		// }
		// else{

		sQuery += 'SELECT Id,Name ';
		if(searchObjectKey != null && searchObjectKey != 'undefined' && searchObjectKey != '')
			sQuery += ','+searchObjectKey+' ';

		// if(fieldsMap.get('ext_key_id__c') != null)
		//  sQuery += ',Ext_Key_Id__c ';
		// if(fieldsMap.get('retailer_group_code__c') != null)
		//  sQuery += ',Retailer_Group_Code__c ';
		// if(fieldsMap.get('country_code__c') != null)
		//  sQuery += ',Country_Code__c ';
		// if(fieldsMap.get('retailer_group__c') != null)
		//  sQuery += ',Retailer_Group__c ';

		if(searchObjectKey == null || searchObjectKey == 'undefined' || searchObjectValue == null || searchObjectValue == 'undefined' || searchObjectKey == '' || searchObjectValue == '')
			sQuery +=  'FROM ' +ObjectName + ' WHERE Name LIKE: searchKey';
		else if(fieldsMap.get(searchObjectKey.toLowerCase()) != null || searchObjectKey.toLowerCase().contains('recordtype.')) {
			if( fieldsMap.get(searchObjectKey.toLowerCase()) != null
			    && (fieldsMap.get(searchObjectKey.toLowerCase()).getDescribe().getType() == Schema.DisplayType.Boolean
			        || fieldsMap.get(searchObjectKey.toLowerCase()).getDescribe().getType() == Schema.DisplayType.Currency
			        || fieldsMap.get(searchObjectKey.toLowerCase()).getDescribe().getType() == Schema.DisplayType.Integer
			        || fieldsMap.get(searchObjectKey.toLowerCase()).getDescribe().getType() == Schema.DisplayType.Long
			        || fieldsMap.get(searchObjectKey.toLowerCase()).getDescribe().getType() == Schema.DisplayType.Percent
			        || fieldsMap.get(searchObjectKey.toLowerCase()).getDescribe().getType() == Schema.DisplayType.Boolean )) {
				searchObjectValue = searchObjectValue;
			}
			else{
				searchObjectValue = '\'' + searchObjectValue + '\'';
			}
			// sQuery +=  'FROM ' +ObjectName + ' WHERE Name LIKE: searchKey AND '+searchObjectKey+' = \''+searchObjectValue+'\' ORDER BY createdDate DESC LIMIT 5';
			if(u.Profile.Name=='BC - Boutique'|| u.Profile.Name=='BC - Boutique SG TW' ||u.Profile.Name=='BC - Associate'){
				sQuery +=  'FROM ' +ObjectName + ' WHERE Name LIKE: searchKey AND '+searchObjectKey+' = '+searchObjectValue;
			}else {
				sQuery +=  'FROM ' +ObjectName + ' WHERE Name LIKE: searchKey';
			}
	
		}

		

		if(filter != null && filter != ''){
			sQuery += ' ' + filter;
		}
		System.debug('VS CHECK1');
		if(idLocMicros != null && idLocMicros != ''){
			// sQuery += ' AND Id_Location_Micros__c='+idLocMicros;
			Location__c loc= [SELECT name, Id_Location_Micros__c
							FROM 	Location__c 
							WHERE id=:idLocMicros];
			
			sQuery +=  ' AND Id_Location_Micros__c=\''+loc.Id_Location_Micros__c+'\'';
			System.debug('VS CHECK2');
		}

		//AK
		sQUery += ' ORDER BY createdDate DESC LIMIT 5';
		// }
		//String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC limit 5';
		system.debug(sQuery);
		List < sObject > lstOfRecords = Database.query(sQuery);

		for (sObject obj: lstOfRecords) {
			returnList.add(obj);
		}
		return returnList;
	}
}