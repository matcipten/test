public with sharing class OnRelazioneGhostTriggerHandler{

    public static void CreateRelazioni(list<Relazione_Ghost__c> rel){

        list<Relazioni__c> ListRelazioni	= new list<Relazioni__c>();

		String hashString = '1000' + String.valueOf(Datetime.now().formatGMT('yyyy-MM-dd HH:mm:ss.SSS'));
		Blob hash = Crypto.generateDigest('MD5', Blob.valueOf(hashString));
		String hexDigest = EncodingUtil.convertToHex(hash);
		system.debug('TEN@hexDigest : ' + hexDigest );
        
        for(Relazione_Ghost__c r:rel){
            
			Relazioni__c nr             = new Relazioni__c();
			nr.Cliente__c               = r.Cliente__c;
			nr.Cliente_in_Relazione__c	= r.Cliente_in_Relazione__c;
			nr.Legame__c                = r.Legame_Cliente_in_Relazione__c;
			nr.Key_Relazione_Ghost__c	= hexDigest;
            ListRelazioni.add(nr);
                
            Relazioni__c nri            = new Relazioni__c();
			nri.Cliente__c              = r.Cliente_in_Relazione__c;
			nri.Cliente_in_Relazione__c = r.Cliente__c;
			nri.Legame__c               = r.Legame_Cliente__c;
			nri.Key_Relazione_Ghost__c	= hexDigest;
            ListRelazioni.add(nri);
            
        }        

        if(ListRelazioni.size()>0){      
            insert ListRelazioni;          
        }
           
    }

}