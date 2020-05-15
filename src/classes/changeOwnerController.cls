public class changeOwnerController {
    @AuraEnabled 
    public static String fetchUser(){
        return userInfo.getUserId();
    }

    @AuraEnabled
    public static void changeOwner(Id userId){
        List<Case> casi= [SELECT id,Owner.Name, OwnerId, CreatedDate, RecordType.name
                            FROM Case
                            WHERE OwnerId =: userId AND (Status = 'Nuovo' OR Status = 'Riassegnato')];
        System.debug('VS Case : '+ casi);


        Map<ID, Case> caseMap = new Map<ID, Case>(casi);
        System.debug('VS Case map : '+ caseMap);  
        System.debug('VS Case map keyset : '+ caseMap.keySet()); 


        List<CaseHistory> caseHistory =[SELECT ID, CaseId, Field, OldValue, NewValue,CreatedDate 
                                FROM CaseHistory 
                                WHERE Field ='Owner' AND CaseId IN: caseMap.keySet()
                                ORDER BY CreatedDate Desc];
        
        System.debug('VS Case history: '+ caseHistory);                            
        
        for(CaseHistory cH : caseHistory){
            Case c =caseMap.get(ch.CaseId);
            Pattern oldValuePattern = Pattern.compile('00G[a-zA-Z0-9]{15}');
            Pattern newValuePattern = Pattern.compile('005[a-zA-Z0-9]{15}');
            Matcher  oldValueBool = oldValuePattern.matcher(cH.OldValue.toString());
            Matcher  newValueBool = newValuePattern.matcher(cH.NewValue.toString());
            if(oldValueBool.matches() && newValueBool.matches())
          
                
                
                if(c.OwnerId == cH.NewValue){
                    c.OwnerId=cH.OldValue.toString();
                    //PALUMBO (START)
                    c.Assegnato_Da_OmniChannel__c = false;
                    //PALUMBO (END)
                } 
            caseMap.put(ch.CaseId, c);
            

            
        }
        update caseMap.values();

    }

    //PALUMBO (START)
    @AuraEnabled
    public static void setOmniChannel(Id userId, String caseId){
        List<Case> cases = [SELECT BusinessHoursId FROM Case WHERE Id=: caseId];
        if (!cases.isEmpty()){
            Case c = cases.get(0);
            c.Assegnato_Da_OmniChannel__c = true;
            update c;
        }
    }
    //PALUMBO (END)
}