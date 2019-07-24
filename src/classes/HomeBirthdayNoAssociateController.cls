public class HomeBirthdayNoAssociateController {

	@AuraEnabled
	public static Map<String,String> getLabels(){
		Map<String,String> labels = new Map<String,String>();
		try{

			Map<String, Schema.SObjectField> fields = Account.SObjectType.getDescribe().fields.getMap();
			for(String fieldName : fields.keySet()) {
				labels.put(fieldName,fields.get(fieldName).getDescribe().getLabel());
			}
			return labels;
		}
		catch(Exception e) {
			system.debug('problems to get fields');
			return new Map<String,String>();
		}

	}

	@AuraEnabled
	public static Integer getTotalCount(){
		AggregateResult results;
		// List<CampaignMember> myActiveCampaignMembers = new List<CampaignMember>();
		// Set<String> campaignsId = new Set<String>();
		Integer total = 0;
		// myActiveCampaignMembers = [
		//  SELECT Id,CampaignId
		//  FROM CampaignMember
		//  WHERE (Titolare_Client_Advisor_Boutique__c = true)
		// ];

		// if(myActiveCampaignMembers != null && myActiveCampaignMembers.size() > 0) {
		//  for(CampaignMember cm : myActiveCampaignMembers) {
		//      campaignsId.add(cm.CampaignId);
		//  }
		// if(campaignsId != null && campaignsId.size() > 0) {
		try{
			results = [
				SELECT count(Id) total
				FROM Account
				WHERE (IsPersonAccount = true AND PersonBirthdate = NEXT_N_DAYS:30 AND Titolare_Client_Advisor_Boutique__c = true)
			];
		}
		catch(Exception e) {
			total = 0;
		}

		total =(Integer)results.get('total');
		//  }
		// }
		if(results != null)
			return total;
		else
			return 0;

	}

	@AuraEnabled
	public static List<Account> getBirthdays(Integer limits, Integer offsets){
		System.debug('limits'+limits);
		System.debug('offsets'+offsets);
		Integer intlimits = integer.valueof(limits);
		Integer intoffsets = integer.valueof(offsets);
		// List<Campaign> myActiveCampaigns = new List<Campaign>();
		// List<CampaignMember> myActiveCampaignMembers = new List<CampaignMember>();
		// Set<String> campaignsId = new Set<String>();
		// myActiveCampaignMembers = [
		//  SELECT Id,CampaignId
		//  FROM CampaignMember
		//  WHERE (Titolare_Client_Advisor_Boutique__c = true)
		// ];

		// if(myActiveCampaignMembers != null && myActiveCampaignMembers.size() > 0) {
		// for(CampaignMember cm : myActiveCampaignMembers) {
		//  campaignsId.add(cm.CampaignId);
		// }
		// if(campaignsId != null && campaignsId.size() > 0) {
		List<Account> birthdays = [
			SELECT Id,Name,PersonBirthdate,Marketing_Y_N__c,Posta__c,Email__c,Telefono__c,Privacy3__c,Associate__r.Name
			FROM Account
			WHERE (IsPersonAccount = true AND PersonBirthdate = NEXT_N_DAYS:30 AND Titolare_Client_Advisor_Boutique__c = true)
			ORDER BY PersonBirthdate ASC NULLS LAST
			LIMIT :intlimits
			OFFSET :intoffsets
		];
		// }
		// }
		if(birthdays != null && birthdays.size() > 0)
			return birthdays;
		else
			return new List<Account>();

	}

}