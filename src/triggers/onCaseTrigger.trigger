trigger onCaseTrigger on Case (after update, before insert) {

	if(trigger.isInsert && trigger.isBefore){
		CaseEntitlementAction.associateEntitlement(Trigger.new);
	}

	if(trigger.isUpdate){
		if(trigger.isAfter){
			CaseMilestoneAction.checkMilestones(Trigger.oldMap,  Trigger.new);
			
			RecordTypeSetting__c rts	= RecordTypeSetting__c.getValues('General');
			list<Case> LCase 			= new list<Case>();
			
			for(Case c:trigger.new){
			
				if(	c.RecordTypeId == rts.Caso_OMS__c && 
					system.trigger.oldMap.get(c.Id).isclosed== false && 
					c.Isclosed){
					
					LCase.add(c);
					
				}
				
			}
			
			if(LCase.size()>0){
				OnCaseTriggerHandler.CloseTicketCallout(LCase);
			}
			
		}
	}
   
}