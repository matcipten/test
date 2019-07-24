public class OnOrdineSartoriaSolomeoTriggerHandler {
    
    public static void executeOrdineSartoriaSolomeo(List<Ordine_Sartoria_Solomeo__c> triggerNew, Boolean isBefore, Boolean isInsert, Boolean isUpdate ){
        system.debug(' triggerNew : ' + triggerNew);        
        if(isBefore){
            Map<Id,Ordine_Sartoria_Solomeo__c> mapOrdine_Sartoria_SolomeoWithCapoId = new Map<Id,Ordine_Sartoria_Solomeo__c>();
            Map<Id,Ordine_Sartoria_Solomeo__c> mapOrdine_Sartoria_SolomeoWithAccountId = new Map<Id,Ordine_Sartoria_Solomeo__c>();
            
            for(Ordine_Sartoria_Solomeo__c mapOss : triggerNew){
                mapOrdine_Sartoria_SolomeoWithCapoId.put(mapOss.Capo__c , mapOss);
                mapOrdine_Sartoria_SolomeoWithAccountId.put(mapOss.Cliente__c, mapOss);
            }
            
            system.debug('mapOrdine_Sartoria_SolomeoWithCapoId : ' + mapOrdine_Sartoria_SolomeoWithAccountId);
            system.debug('mapOrdine_Sartoria_SolomeoWithCapoId : ' + mapOrdine_Sartoria_SolomeoWithCapoId);
            
            List<Capo__c> listCapo_Pantolone_Giaca = [SELECT Id, Name , RecordType.DeveloperName ,Tipo_Giacca__c FROM Capo__c WHERE Id In: mapOrdine_Sartoria_SolomeoWithCapoId.KeySet()] ; 
            
            List<Account_Misure_Sartoriali__c> mapAccountMisureSartorialiId = [SELECT Id , Name , RecordType.DeveloperName , Account__c 
                                                                               FROM Account_Misure_Sartoriali__c 
                                                                               WHERE Account__c In: mapOrdine_Sartoria_SolomeoWithAccountId.KeySet()];
            
            system.debug('listCapo_Pantolone_Giaca : ' + mapAccountMisureSartorialiId);
            system.debug('listCapo_Pantolone_Giaca : ' + mapAccountMisureSartorialiId.size());
            
            if(listCapo_Pantolone_Giaca.size()>0){
                for(Ordine_Sartoria_Solomeo__c mapOss : triggerNew){
                    for(Capo__c cp : listCapo_Pantolone_Giaca){
                        if(mapOss.Capo__c == cp.Id){
                            for(Account_Misure_Sartoriali__c ams : mapAccountMisureSartorialiId){
                                system.debug('cp.RecordType.DeveloperName ' +cp.RecordType.DeveloperName);
                                if(cp.RecordType.DeveloperName == ams.RecordType.DeveloperName){
                                    mapOss.Misure_Pantaloni__c = ams.Id;
                                }
                                if(cp.RecordType.DeveloperName.Contains('Giacca') && cp.Tipo_Giacca__c  == ams.RecordType.DeveloperName ){
                                    mapOss.Misure_Giacca__c = ams.Id;
                                }
                                if(cp.RecordType.DeveloperName == 'Abito'){
                                    if(ams.RecordType.DeveloperName == 'Pantalone'){
                                        mapOss.Misure_Pantaloni__c = ams.Id;
                                    }
                                    if(ams.RecordType.DeveloperName.Contains('Giacca') ){
                                        mapOss.Misure_Giacca__c = ams.Id;
                                    }
                                }
                            }
                            
                            
                        }
                    }
                    system.debug('mapOss : ' + mapOss);
                    
                }
                //system.debug('listOrdineSS : ' + listOrdineSS);
            }
        }
        
    }
    
    public static List<Ordine_Sartoria_Solomeo__c> processOnlyStatusNotEditing(List<Ordine_Sartoria_Solomeo__c> ossList){
        List<Ordine_Sartoria_Solomeo__c> l = new List<Ordine_Sartoria_Solomeo__c>();
        for(Ordine_Sartoria_Solomeo__c oss :ossList){
            if(oss.Status__c != 'In editing'){
                l.add(oss);
            }
        }
        return l;
    }
    
    public static void sendAllertOrdineSartoriaSolomeo(List<Ordine_Sartoria_Solomeo__c> orderListNew,  List<Ordine_Sartoria_Solomeo__c> orderListOld){
        System.debug('SV orderListNew: ' + orderListNew);
        System.debug('SV orderListOld: ' + orderListOld);
        
        Set<String> IdAssociate = new Set<String>();
        Set<String> IdUsers = new Set<String>();
        Set<String> IdAccount = new Set<String>();
        for(Ordine_Sartoria_Solomeo__c orderNew : orderListNew){
            IdAssociate.add(orderNew.Associate__c);
            IdUsers.add(orderNew.CreatedById);
            IdAccount.add(orderNew.Cliente__c);
        }
        
        map<string,Account> mapAccount = new map<string,Account>();        
        list<Account> listAccount = [Select PersonContactId from Account where id IN:IdAccount];
        
        for(Account a:listAccount){
            mapAccount.put(a.id, a);
        }
        
        System.debug('SV IdAssociate: ' + IdAssociate);
        System.debug('SV IdUsers: ' + IdUsers);
        
        List<Associated__c> assList = [SELECT Id, Location__c, Id_Associate__c FROM Associated__c WHERE Id IN : IdAssociate];
        System.debug('SV assList: ' + assList);
        
        List<User> usrList = [SELECT Id, Codice_Associate__c, Language_Contact_Card__c, Email, Codice_Boutique__c FROM User WHERE Id IN : IdUsers];
        System.debug('SV usrList: ' + usrList);
        if(usrList.size() <= 0){
            // ToDO
        }
        
        for(Ordine_Sartoria_Solomeo__c orderNew : orderListNew){
			           
            string ContactId;
            if(mapAccount.size()>0){
                ContactId = mapAccount.get(orderNew.Cliente__c).PersonContactId;
            }
            
            //  Create a master list to hold the emails
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            
            //  list of people who should get the email
            List<String> sendTo = new List<String>();
            List<String> sendCc = new List<String>();
            
            for(Ordine_Sartoria_Solomeo__c ordeOld : orderListOld){
                if(orderNew.Id == ordeOld.Id && orderNew.Status__c != ordeOld.Status__c){
                    
                    System.debug('ContactId: ' + ContactId);
                    
                    // SETTING STEP
                    String oldStatus = ordeOld.Status__c;
                    String newStatus = orderNew.Status__c;
                    String step = '';
                    if(oldStatus != 'In revisione 1 livello' && newStatus == 'In revisione 1 livello')
                        step = '1';
                    
                    else if(oldStatus != 'Rifiutato 1 livello' && newStatus == 'Rifiutato 1 livello')
                        step = '1.2';
                    
                    else if(oldStatus == 'Rifiutato 1 livello' && newStatus == 'Annullato')
                        step = '1.3';
                    
                    else if(oldStatus != 'In revisione dal sarto' && newStatus == 'In revisione dal sarto')
                        step = '2';
                    
                    else if(oldStatus == 'Rifiutato dal sarto' && newStatus == 'Annullato')
                        step = '2.2';
                    
                    else if(oldStatus != 'Rifiutato dal sarto' && newStatus == 'Rifiutato dal sarto')
                        step = '2.3';
                    
                    else if(oldStatus != 'Approvato dal sarto' && newStatus == 'Approvato dal sarto')
                        step = '3';
                    
                    else if(oldStatus != 'Ricevuto in negozio' && newStatus == 'Ricevuto in negozio')
                        step = '4';
                    
                    else if(oldStatus != 'Consegnato al Cliente' && newStatus == 'Consegnato al Cliente')
                        step = '5';
                    
                    System.debug('SV step: ' + step);
                    
                    if(step != ''){
                        List<MTM_Alert_Template__mdt> alertTemplateList = [SELECT Id, Id_Template__c, Step__c, Language__c FROM MTM_Alert_Template__mdt WHERE Step__c =: step];
                        System.debug('SV alertTemplateList: ' + alertTemplateList);
                        
                        Set<String> AssociateLocationCode = new Set<String>();
                        for(Associated__c ass : assList){
                            AssociateLocationCode.add(ass.Location__c);
                        }
                        List<MTM_Alert__c> mailSendList = [SELECT Id, Location__c, Step__c, Email__c, Recipient_Type__c, Role__c FROM MTM_Alert__c WHERE Location__c IN : AssociateLocationCode AND Step__c =: step];
                        System.debug('SV mailSendList: ' + mailSendList);
                        
                        for(Associated__c ass : assList){
                            for(MTM_Alert__c mailSend : mailSendList){
                                if(mailSend.Role__c == 'Boutique'){
                                    if(mailSend.Recipient_Type__c == 'TO'){
                                        sendTo.add(orderNew.CreatedById);
                                    } else {
                                        sendCc.add(orderNew.CreatedById);
                                    }
                                } else {
                                    if(mailSend.Recipient_Type__c == 'TO'){
                                        sendTo.add(mailSend.Email__c);
                                    } else {
                                        sendCc.add(mailSend.Email__c);
                                    }
                                }
                            }
                        }
                        
                        System.debug('SV sendTo: ' + sendTo);
                        System.debug('SV sendCc: ' + sendCc);
                        
                        String languageUsrCode = '';
                        for(User usr : usrList){
                            if(usr.Id == orderNew.CreatedById)
                                languageUsrCode = usr.Language_Contact_Card__c;
                        }
                        
                        ID idTemplate = null;
                        Boolean find = false;
                        for(MTM_Alert_Template__mdt alertTemplate : alertTemplateList){
                            if(alertTemplate.Language__c == languageUsrCode){
                                idTemplate = alertTemplate.Id_Template__c;
                                find = true;
                            } else if(alertTemplate.Language__c == 'en'){
                                idTemplate = alertTemplate.Id_Template__c;
                            }
                            
                            if(find){
                                break;
                            }
                        }
                        
                        if(idTemplate != null){
                            mail.setToAddresses(sendTo);
                            mail.setCcAddresses(sendCc);
                            
                            List<String> sendToTest = new List<String>();
                            List<String> sendCcTest = new List<String>();
                            /*
                            sendToTest.add('salvatore.vella@tengroup.it');
                            sendCcTest.add('ester.muggia@tengroup.it');
                            sendCcTest.add('luca.ruzzon@tengroup.it');
                            
                            mail.setToAddresses(sendToTest);
                            mail.setCcAddresses(sendCcTest);
                            */
                            // Set email contents
                            mail.setSenderDisplayName('Brunello Cucinelli');
                            
                            //mail.setTargetObjectId(orderNew.CreatedById);
                            mail.setTargetObjectId(ContactId);
                            mail.setTemplateId(idTemplate);
                            mail.setTreatTargetObjectAsRecipient(false);
                            mail.setSaveAsActivity(false);
                            
                            mail.setWhatId(orderNew.Id);
                            
                            // Add your email to the master list
                            mails.add(mail);
                            System.debug('SV mails: ' + mails);
                            
                            try {
                                Messaging.sendEmail(mails);
                            } catch (Exception e) {
                                System.debug(e.getMessage());
                            }
                        }
                    }
                }
            }
        }
        
        /*
        // SETTING STEP
        String step = '';
        if(oldStatus == 'In editing' && newStatus == 'In revisione 1 livello')
            step = '1';
        
        else if(oldStatus == 'In revisione 1 livello' && newStatus == 'Rifiutato 1 livello')
            step = '1.2';
        
        else if(oldStatus == 'Rifiutato 1 livello' && newStatus == 'Annullato')
            step = '1.3';
        
        else if(oldStatus == 'In revisione 1 livello' && newStatus == 'In revisione dal sarto')
            step = '2';
        
        else if(oldStatus == 'Rifiutato dal sarto' && newStatus == 'Annullato')
            step = '2.2';
        
        else if(oldStatus == 'In revisione dal sarto' && newStatus == 'Rifiutato dal sarto')
            step = '2.3';
        
        else if(oldStatus == 'In revisione dal sarto' && newStatus == 'Approvato dal sarto')
            step = '3';
        
        else if(oldStatus == 'Approvato dal sarto' && newStatus == 'Ricevuto in negozio')
            step = '4';
        
        else if(oldStatus == 'Ricevuto in negozio' && newStatus == 'Consegnato a cliente')
            step = '5';
        
        
        System.debug('SV oldStatus: ' + oldStatus);
        System.debug('SV newStatus: ' + newStatus);
        System.debug('SV step: ' + step);
        */
        /*
        Associated__c ass = [SELECT Id, Location__c, Id_Associate__c FROM Associated__c WHERE Id =: order.Associate__c];
        System.debug('SV ass: ' + ass);
        User usr = [SELECT Id, Codice_Associate__c, Language_Contact_Card__c, Email, Codice_Boutique__c FROM User WHERE Codice_Associate__c =: ass.Id_Associate__c];
        System.debug('SV usr: ' + usr);
        
        if(usr == null){
			// ToDo
        }
        
        List<MTM_Alert__c> mailSend = [SELECT Id, Location__c, Step__c, Email__c, Recipient_Type__c, Role__c FROM MTM_Alert__c WHERE Location__c =: ass.Location__c AND Step__c =: step];
        System.debug('SV mailSend: ' + mailSend);
        
        List<MTM_Alert_Template__mdt> alertTemplateList = [SELECT Id, Id_Template__c, Step__c, Language__c FROM MTM_Alert_Template__mdt WHERE Step__c =: step];
        System.debug('SV alertTemplateList: ' + alertTemplateList);

        String idTemplate = '';
        Boolean find = false;
        for(MTM_Alert_Template__mdt alertTemplate : alertTemplateList){
            if(alertTemplate.Language__c == usr.Language_Contact_Card__c){
                idTemplate = alertTemplate.Id_Template__c;
                find = true;
            } else if(alertTemplate.Language__c == 'en'){
                idTemplate = alertTemplate.Id_Template__c;
            }
            
            if(find){
                break;
            }
        }
        
        //  Create a master list to hold the emails
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        //  list of people who should get the email
        List<String> sendTo = new List<String>();
        List<String> sendCc = new List<String>();
        
        for(MTM_Alert__c sender : mailSend){
            if(sender.Role__c == 'Boutique'){
                if(sender.Recipient_Type__c == 'TO'){
                    sendTo.add(usr.Email);
                } else {
                    sendCc.add(usr.Email);
                }
            } else {
                if(sender.Recipient_Type__c == 'TO'){
                    sendTo.add(sender.Email__c);
                } else {
                    sendCc.add(sender.Email__c);
                }
            }
        }
        
        List<String> sendToTest = new List<String>();
        List<String> sendCcTest = new List<String>();
        
        sendToTest.add('salvatore.vella@tengroup.it');
        sendCcTest.add('ester.muggia@tengroup.it');
        sendCcTest.add('luca.ruzzon@tengroup.it');
        
        mail.setToAddresses(sendToTest);
        mail.setCcAddresses(sendCcTest);
        
        // Set email contents
        mail.setSenderDisplayName('Brunello Test');
        
        mail.setTargetObjectId('005360000011saj');
        mail.setTemplateId('00X9E000000c8Jh');
        mail.setSaveAsActivity(false);
        
        // Add your email to the master list
        mails.add(mail);
        
        System.debug('SV sendTo: ' + sendTo);
        System.debug('SV sendCc: ' + sendCc);
        System.debug('SV mails: ' + mails);
        
        
        try {
            Messaging.sendEmail(mails);
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
		*/
    }
}