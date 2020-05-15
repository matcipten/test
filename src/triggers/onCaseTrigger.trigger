trigger onCaseTrigger on Case (after update, before insert, before update) {
	if(trigger.isInsert){
		system.debug('VS check per milestone isInsert');
	}
	if(trigger.isInsert && trigger.isBefore){
		CaseEntitlementAction.associateEntitlement(Trigger.new);
		//PALUMBO (START)
		CaseOmniChannelHandler.setBusinessHours(Trigger.new);
		//PALUMBO (END)
	}
	if(trigger.isUpdate){
		system.debug('VS check per milestone isUpdate');
	}
	if(trigger.isUpdate){
		if(trigger.isAfter){
			system.debug('VS check per milestone isUpdate');
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

			//PALUMBO (START)
			if (!System.isFuture()){
				CaseMilestoneAction.checkMilestoneStatus(Trigger.new);
			}			
			//PALUMBO (END)
			
		} else if (Trigger.isBefore){
			//PALUMBO (START)
			CaseOmniChannelHandler.setBusinessHoursUpdate(Trigger.oldMap, Trigger.new);
			//PALUMBO (END)
		}
	}
   
}