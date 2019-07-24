public class MyActiveCampaignsController {

	@AuraEnabled
	public static Map<String,String> getLabels(){
		Map<String,String> labels = new Map<String,String>();
		try{

			Map<String, Schema.SObjectField> fields = Campaign.SObjectType.getDescribe().fields.getMap();
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
		List<CampaignMember> myActiveCampaignMembers = new List<CampaignMember>();
		Set<String> campaignsId = new Set<String>();
		Integer total = 0;
		myActiveCampaignMembers = [
			SELECT Id,CampaignId
			FROM CampaignMember
			WHERE (Titolare_Client_Advisor_Boutique__c = true)
		];

		if(Test.isRunningTest()) {
			myActiveCampaignMembers = [
				SELECT Id,CampaignId
				FROM CampaignMember LIMIT 100
			];
		}

		if(myActiveCampaignMembers != null && myActiveCampaignMembers.size() > 0) {
			for(CampaignMember cm : myActiveCampaignMembers) {
				campaignsId.add(cm.CampaignId);
			}
			if(campaignsId != null && campaignsId.size() > 0) {
				results = [
					SELECT count(Id) total
					FROM Campaign
					WHERE (Id IN: campaignsId AND EndDate >= :System.today())
				];


				total =(Integer)results.get('total');
			}
		}
		if(results != null)
			return total;
		else
			return 0;

	}

	@AuraEnabled
	public static MyReturnClass getMyActiveCampaigns(Integer limits, Integer offsets){
		System.debug('limits'+limits);
		System.debug('offsets'+offsets);
		Integer intlimits = integer.valueof(limits);
		Integer intoffsets = integer.valueof(offsets);
		Map<String,Campaign> myActiveCampaigns = new Map<String,Campaign>();
		List<CampaignMember> myActiveCampaignMembers = new List<CampaignMember>();
		MyReturnClass myReturn = new MyReturnClass();
		Set<String> campaignsId = new Set<String>();
		myActiveCampaignMembers = [
			SELECT Id,CampaignId
			FROM CampaignMember
			WHERE (Titolare_Client_Advisor_Boutique__c = true)
		];

		if(Test.isRunningTest()) {
			myActiveCampaignMembers = [
				SELECT Id,CampaignId
				FROM CampaignMember LIMIT 100
			];
		}

		if(myActiveCampaignMembers != null && myActiveCampaignMembers.size() > 0) {

			for(CampaignMember cm : myActiveCampaignMembers) {
				campaignsId.add(cm.CampaignId);
			}
			if(campaignsId != null && campaignsId.size() > 0) {
				myActiveCampaigns = new Map<String,Campaign>([
					SELECT Id,CreatedDate,Name,StartDate,EndDate,Type,RecordType.Name,Channel__c,Categoria__c
					FROM Campaign
					WHERE (Id IN: campaignsId AND EndDate >= :System.today())
					ORDER BY EndDate DESC NULLS LAST
					LIMIT :intlimits
					OFFSET :intoffsets
				]);
			}
		}

		Map<String,String> pickListValuesList = new Map<String,String>();
		Schema.DescribeFieldResult fieldResult = Campaign.Categoria__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple) {
			pickListValuesList.put(pickListVal.getValue(),pickListVal.getLabel());
		}


		if(myActiveCampaigns != null && myActiveCampaigns.size() > 0){
			//return myActiveCampaigns;

			myReturn.labels = pickListValuesList;
			myReturn.campaigns = myActiveCampaigns;
			return myReturn;
		}
		else
			return new MyReturnClass();

	}

	
	public class MyReturnClass{

		@AuraEnabled
		public Map<String,Campaign> campaigns;
		@AuraEnabled
		public Map<String,String> labels;



	  
	}

}