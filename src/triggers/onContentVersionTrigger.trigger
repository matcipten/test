trigger onContentVersionTrigger on ContentVersion (after insert,after delete) {

	if(trigger.isInsert){
		if(trigger.isAfter){
            system.debug('ContentVersion insert');
			OnContentVersionTriggerHandler.SetAllegatiInAccount(trigger.new);
			OnContentVersionTriggerHandler.UpdateImageActivityTracking(trigger.new);
		}
	}
}