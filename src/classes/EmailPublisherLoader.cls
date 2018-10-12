global class EmailPublisherLoader implements QuickAction.QuickActionDefaultsHandler {
    // Empty constructor
    global EmailPublisherLoader() {
    }
    
    // The main interface method
    global void onInitDefaults(QuickAction.QuickActionDefaults[] defaults) {
        QuickAction.SendEmailQuickActionDefaults sendEmailDefaults = null;
        EmailMessage targetMessageObj = null;
        String templateName;
        
        // Check if the quick action is the standard Case Feed send email action
        for (Integer j = 0; j < defaults.size(); j++) {
            
            if (defaults.get(j) instanceof QuickAction.SendEmailQuickActionDefaults && 
               defaults.get(j).getTargetSObject().getSObjectType() == 
                   EmailMessage.sObjectType){
               System.debug('defaults.get(j).getActionName():' + defaults.get(j).getActionName());
               System.debug('defaults.get(j).getActionType():' + defaults.get(j).getActionType());
               System.debug('get(j)' + (QuickAction.SendEmailQuickActionDefaults)defaults.get(j));
           }
    
            
            if (defaults.get(j) instanceof QuickAction.SendEmailQuickActionDefaults && 
               defaults.get(j).getTargetSObject().getSObjectType() == 
                   EmailMessage.sObjectType && 
               defaults.get(j).getActionName().equals('Case.Email') && 
               defaults.get(j).getActionType().equals('Email')) {
                   targetMessageObj = (EmailMessage)defaults.get(j).getTargetSObject(); 
                   sendEmailDefaults = 
                       (QuickAction.SendEmailQuickActionDefaults)defaults.get(j);
                   break;
            }
        }
        
        if (sendEmailDefaults != null) {
            Case c = [SELECT Status, Reason, RecordTypeId, RecordType.DeveloperName,
                      Account.PersonEmail, Account.Id , Account.isPersonAccount, Account.Email_Azienda__c
                      FROM Case 
                      WHERE Id=:sendEmailDefaults.getContextId()];
            
            targetMessageObj.ToAddress = c.Account.isPersonAccount ? c.Account.PersonEmail : c.Account.Email_Azienda__c;
                      
            String recordTypeId = c.RecordTypeId;
            String recDeveloperName = c.RecordType.DeveloperName;
            
            System.debug('Case recuperato: ' + c);
            
            if(recDeveloperName == 'Customer_Care'){
                templateName = 'Modello_predefinito_Customer_Care';
            } else {
                templateName = 'Customer_Care_Default_Reply_US_2';
            }
            
            sendEmailDefaults.setInsertTemplateBody(true);
            
            sendEmailDefaults.setTemplateId(
                        getTemplateIdHelper(templateName));
        }
        
    
        
    }
    
    private Id getTemplateIdHelper(String templateApiName) {
        Id templateId = null;
        try {
            templateId = [select id, name from EmailTemplate 
                          where developername = : templateApiName].id;   
                          
            System.debug('Retrieved templateId: ' + templateId);              
                          
                          
        } catch (Exception e) {
            system.debug('Unble to locate EmailTemplate using name: ' + 
                templateApiName + ' refer to Setup | Communications Templates ' 
                    + templateApiName);
        }
        return templateId;
    }
    
}