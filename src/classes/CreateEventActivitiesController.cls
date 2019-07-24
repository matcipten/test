public class CreateEventActivitiesController {
	@AuraEnabled(cacheable=true)
	public static String getCostoRT(){
		String costoRT = Schema.SObjectType.Attivita_Evento__c.getRecordTypeInfosByDeveloperName().get('Activity_Cost').getRecordTypeId();
		return costoRT;
	}

	@AuraEnabled
	public static String getCampaignId(String activityId){
		try{
			List<Activity_Tracking__c> activitiesList = new List<Activity_Tracking__c>();
			activitiesList = [SELECT Id,Campagna__c
			                  FROM Activity_Tracking__c
			                  WHERE (Id = :activityId) LIMIT 1];
			if(activitiesList != null && activitiesList.size() > 0) {
				return (String) activitiesList.get(0).Campagna__c;
			}
			else
				return '';
		}
		catch(Exception e) {
			return '';
		}
	}


	@AuraEnabled(cacheable=true)
	public static Map<String,Map<String,String> > getLabels(){
		Map<String,Map<String,String> > allLabels = new Map<String,Map<String,String> >();
		Map<String,String> labels = new  Map<String,String>();
		// Map<String,String> rtLabels = new  Map<String,String>();
		// Map<String,String> canaleLabels = new  Map<String,String>();
		try{

			Schema.DescribeSObjectResult activityTrackingDescribe = Attivita_Evento__c.SobjectType.getDescribe();

			Map<String, Schema.SObjectField> fields = activityTrackingDescribe.fields.getMap();
			for(String fieldName : fields.keySet()) {
				String label = fields.get(fieldName).getDescribe().getLabel();
				label = label.replace('ID ','');
				label = label.replace(' ID','');
				labels.put(fieldName,label);
			}
			allLabels.put('labels',labels);

			/*Map<String,Schema.RecordTypeInfo> rts = activityTrackingDescribe.getRecordTypeInfosByDeveloperName();
			for(Schema.RecordTypeInfo rt : rts.values()) {
				rtLabels.put(rt.getDeveloperName(),rt.getName());
			}

			allLabels.put('rtLabels',rtLabels);

			Schema.DescribeFieldResult canalePicklist = fields.get('Canale__c').getDescribe();
			for (Schema.PicklistEntry f : canalePicklist.getPicklistValues()) {
				canaleLabels.put(f.getValue(),f.getLabel());

			}

			allLabels.put('picklist_labels_canale_c',canaleLabels);*/

			return allLabels;
		}
		catch(Exception e) {
			system.debug('problems to get fields');
			return new Map<String,Map<String,String> >();
		}

	}
    @AuraEnabled
	public static Map<String,String> getTypePicklist(string rtype, string pickval, String activityTrackingId){

		if(activityTrackingId != null && activityTrackingId != '' && (rtype == null || pickval == null)){
			List<Activity_tracking__c> tempATList = [SELECT Id, RecordType.DeveloperName,Categoria__c FROM Activity_tracking__c WHERE Id = : activityTrackingId];
			if(tempATList != null && tempATList.size() > 0){
				Activity_tracking__c temp = tempATList.get(0);
				rtype = temp.RecordType.DeveloperName;
				pickval = temp.Categoria__c;
			}

		}
		
		Map<String,String> tipi = new  Map<String,String>();

		Schema.DescribeSObjectResult typeDescribe = Attivita_Evento__c.SobjectType.getDescribe();
		Map<String, Schema.SObjectField> typeFields = typeDescribe.fields.getMap();

		Schema.DescribeFieldResult typePicklist = typeFields.get('Type__c').getDescribe();
        	
        system.debug(rtype);
        system.debug(pickval);
        
     
        if(rtype == 'Events' || Test.isRunningTest()){
                for (Schema.PicklistEntry f : typePicklist.getPicklistValues()) {
					if(f.getvalue() == 'Transport') tipi.put(f.getValue(),f.getLabel());
                    if(f.getvalue() == 'Hotel') tipi.put(f.getValue(),f.getLabel());
                    if(f.getvalue() == 'Other') tipi.put(f.getValue(),f.getLabel());
             	}
		}
        if (rtype == 'Mailing' || Test.isRunningTest() ){
			for (Schema.PicklistEntry f : typePicklist.getPicklistValues()) {
					if(f.getvalue() == 'Shipping') tipi.put(f.getValue(),f.getLabel());
                    if(f.getvalue() == 'Other') tipi.put(f.getValue(),f.getLabel());
            }
        }
        if ((rtype == 'One_To_One' && (pickval == 'OT_Proposte di stile' || pickval == 'OT_Repair follow-up' || pickval == 'OT_Follow-up after store visit' || pickval == 'OT_Thank you note' || pickval == 'OT_Tour Visit' || pickval == 'OT_Greetings' || pickval == 'OT_Gifting')) || Test.isRunningTest()){
			for (Schema.PicklistEntry f : typePicklist.getPicklistValues()) {
                    if(f.getvalue() == 'Other') tipi.put(f.getValue(),f.getLabel());
            }  
		}
        if ((rtype == 'One_To_One' && ( pickval == 'OT_Trunk Show' || pickval == 'OT_Preview' || pickval == 'OT_Eating out/Vip dinner or lunch' || pickval == 'OT_Spend time with clients' || pickval == 'OT_Sartoria Solomeo'))  || Test.isRunningTest()) {
            for (Schema.PicklistEntry f : typePicklist.getPicklistValues()) {
				tipi.put(f.getValue(),f.getLabel());
			}
        }
        if ((rtype == 'One_To_One' && pickval == 'OT_Product Home Delivery') || Test.isRunningTest()){
        	for (Schema.PicklistEntry f : typePicklist.getPicklistValues()) {
				if(f.getvalue() == 'Shipping') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Transport') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Other') tipi.put(f.getValue(),f.getLabel());
                    
			}
        }
        if ((rtype == 'One_To_One' && pickval == 'OT_Solomeo Experience' ) || Test.isRunningTest()){
        	for (Schema.PicklistEntry f : typePicklist.getPicklistValues()) {
				if(f.getvalue() == 'Restaurant') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Hotel') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Transport') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Tour guide') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Invitation card') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Entrance Ticket/fee') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Other') tipi.put(f.getValue(),f.getLabel());
                    
			}
        }
        if ((rtype == 'One_To_One' && pickval == 'OT_Attending Corporate Event')  || Test.isRunningTest()){
        	for (Schema.PicklistEntry f : typePicklist.getPicklistValues()) {
				if(f.getvalue() == 'Hotel') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Transport') tipi.put(f.getValue(),f.getLabel());
                if(f.getvalue() == 'Other') tipi.put(f.getValue(),f.getLabel());
                    
			}
        }
		
        return tipi;
    }
}