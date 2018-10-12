public without sharing class CaseEntitlementAction {

	public static void associateEntitlement(List<Case> cases){
		System.debug('Inside CaseEntitlementAction associateEntitlement');

		// Recupero i REcord Type 
		List<RecordType> recordTypesCustomerCare = [SELECT Id,Description, DeveloperName, Name, SobjectType 
			FROM RecordType 
			where SobjectType = 'Case' 
			and DeveloperName in ('Customer_Care', 'Customer_Care_US')];

		// Recupero gli Entitlement da associare
		List<Entitlement> ents = [SELECT Name,Type FROM Entitlement where Name in ('Entitlement ITA', 'Entitlement US')];
		Entitlement entUsa;
		Entitlement entIta;

		for(Entitlement e : ents){
			if(e.Name == 'Entitlement US'){
				entUsa = e;
			}

			if(e.Name == 'Entitlement ITA'){
				entIta = e;
			}
		}

		Map<Id, RecordType> mapRecordType = new Map<Id, RecordType>(recordTypesCustomerCare);

		for(Case c : cases ){
			String rtId = c.RecordTypeId;

			// SKIP UNUSED RECOrD TYPE
			if(!mapRecordType.containsKey(rtId)){
				continue;
			}

			// ASSOCIA ENTITLEMENT TO CASE
			if(mapRecordType.get(rtId).DeveloperName == 'Customer_Care'){
				if(entIta != null){
					c.EntitlementId = entIta.id;
					System.debug(c + ' associato a entitlement ITA');
				}
			} else {
				if(entUsa != null){
					c.EntitlementId = entUsa.id;
					System.debug(c + ' associato a entitlement US');
					
				}
			}

		}
	}


}