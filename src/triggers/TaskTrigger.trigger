trigger TaskTrigger on Task (before insert) {

	if(Trigger.isInsert && Trigger.isBefore){
		TaskTriggerHandler.setTaskOwner(Trigger.new);
	}

}