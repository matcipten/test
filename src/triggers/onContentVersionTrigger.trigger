trigger onContentVersionTrigger on ContentVersion (after insert) {

	if(trigger.isInsert){
		if(trigger.isAfter){
            system.debug('ContentVersion insert');
            OnContentVersionTriggerHandler.SetAllegatiInAccount(trigger.new);
		}
	}
}