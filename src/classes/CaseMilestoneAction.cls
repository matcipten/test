public without sharing class CaseMilestoneAction {

	private static final String PRIMA_RISPOSTA = 'Prima Risposta';
	private static final String CHIUSURA_STATO = 'Chiusura Caso';


	public static void checkMilestones(Map<Id, Case> oldMap, List<Case> cases){
		System.debug('Inside CaseMilestoneAction checkMilestones');
		Map<Id, Case> mapCases = new Map<Id, Case>(cases);
		Map<Id, List<CaseMilestone>> mapCaseMilestone = new Map<Id, List<CaseMilestone>>();
		Set<Id> caseIds = mapCases.keySet();
		MilestoneType primaRispostaMT;
		MilestoneType chiusuraCasoMT;
		List<CaseMilestone> cm2Update = new List<CaseMilestone>();
		List<String> nameList = new List<String>{PRIMA_RISPOSTA, CHIUSURA_STATO};

		List<CaseMilestone> caseMilestones = [SELECT CaseId, CompletionDate, IsCompleted, MilestoneTypeId 
			FROM CaseMilestone 
			where CaseID = :caseIds];

		List<MilestoneType> mts = [SELECT CreatedById,CreatedDate,Description,Id,LastModifiedById,LastModifiedDate,Name,RecurrenceType,SystemModstamp 
			FROM MilestoneType 
			where Name in :nameList];

		for(MilestoneType mt: mts){
			if(mt.Name == PRIMA_RISPOSTA){
				primaRispostaMT = mt;
			}

			if(mt.Name == CHIUSURA_STATO){
				chiusuraCasoMT = mt;
			}
		}

		System.debug('primaRispostaMT: ' + primaRispostaMT);
		System.debug('chiusuraCasoMT: ' + chiusuraCasoMT);
		

		for(CaseMilestone cm : caseMilestones){
			List<CaseMilestone> cmList = mapCaseMilestone.get(cm.CaseId);

			if(cmList == null){
				cmList = new List<CaseMilestone>();
			}

			cmList.add(cm);
			mapCaseMilestone.put(cm.CaseId, cmList);
		}

		System.debug('mapCaseMilestone: ' + mapCaseMilestone);

		for(Case c : cases){
			if(oldMap.get(c.Id).Status != c.Status && (c.Status != 'Riassegnato' && c.Status != 'Nuovo') ){
				// COMPLETA IL CASE MILESTONE CORRETTO
				List<CaseMilestone> cmList = mapCaseMilestone.get(c.Id);

				if(primaRispostaMT != null && cmList != null && !cmList.isEmpty()){
					for(CaseMilestone cm : cmList){
						if(cm.MilestoneTypeId == primaRispostaMT.Id && !cm.isCompleted){
							System.debug('COMPLETA IL MILESTONE DI PRIMA RISPOSTA');
							cm.CompletionDate = System.now();
							//cm.IsCompleted = true;
							cm2Update.add(cm);
						}
					}
				}
			}

			if(!oldMap.get(c.Id).isclosed && c.isclosed){
				// COMPLETA IL CASE MILESTONE CORRETTO
				List<CaseMilestone> cmList = mapCaseMilestone.get(c.Id);

				if(chiusuraCasoMT != null && cmList != null && !cmList.isEmpty()){
					for(CaseMilestone cm : cmList){
						if(cm.MilestoneTypeId == chiusuraCasoMT.Id && !cm.isCompleted){
							System.debug('COMPLETA IL MILESTONE DI CHIUSURA CASO');
							cm.CompletionDate = System.now();
							//cm.IsCompleted = true;
							cm2Update.add(cm);
						}
					}
				}
			}
		}

		System.debug('cm2Update: ' + cm2Update);

		if(!cm2Update.isEmpty()){
			update cm2Update;
		}
	}

	public static void checkMilestoneStatus(List<Case> cases){
		List<Id> caseToWork = new List<Id>();
		for (Case c : cases){            
            if (c.Status_New_First_Shadow__c || c.Status_Reassigned_First_Shadow__c || c.Status_Reply_Received_First_Shadow__c){         
                caseToWork.add(c.Id);
            }
		}		
		
		if (!caseToWork.isEmpty()){
			dummyUpdate(caseToWork);
		}		
	}

	@future
	private static void dummyUpdate(List<Id> cases){
		System.debug('future method called');
		update [SELECT Id FROM Case WHERE Id IN: cases];
	}
}