trigger onUserTrigger on User (before insert, before update) {

	if(trigger.isUpdate){
		if(trigger.isBefore){
			for(User u:trigger.new){
				u.CurrencyISOcode__c = u.DefaultCurrencyIsoCode;
			}	
		}
	}

	if(trigger.isInsert){
		if(trigger.isBefore){
			for(User u:trigger.new){
				u.CurrencyISOcode__c = u.DefaultCurrencyIsoCode;
			}					
		}
	} 
    
}