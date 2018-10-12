trigger onContentDocumentTrigger on ContentDocument (before delete) {
    
	if(trigger.isDelete){
        if(trigger.isBefore){
            system.debug('ContentDocument delete');
            OnContentDocumentTriggerHandler.SetAllegatiInAccount(trigger.old);
		}
	}
}