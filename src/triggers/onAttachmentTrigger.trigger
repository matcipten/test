trigger onAttachmentTrigger on Attachment (after insert, after delete) {
	if(trigger.isInsert){
		if(trigger.isAfter){
            system.debug('Attachment insert');
            OnAttachmentTriggerHandler.SetAllegatiInAccount(trigger.new, 'I');
		}
	}
   
	if(trigger.isDelete){
        if(trigger.isAfter){
            system.debug('Attachment delete');
            OnAttachmentTriggerHandler.SetAllegatiInAccount(trigger.old, 'D');
		}
	}

}