public without sharing class TaskTriggerHandler {
    
    public static void setTaskOwner(List<Task> taskList){
        List<Task> tasksWithAlert = new List<Task>();

        String recordTypeId = DescribeUtils.getRecordTypeId('Task', 'Alert_Duplicato');
        Set<Id> alertIds = new Set<Id>();
        //Map<Id, Task> mapTask = new Map<Id, Task>(taskList);
        //Map<, Id> mapTaskAlert = new Map<Id, Id>();
        Map<Id, Task> mapAlertTask = new Map<Id, Task>();
        Map<id, List<SFSSDupeCatcher__Potential_Duplicate__c>> mapAlertDuplicates = new Map<id, List<SFSSDupeCatcher__Potential_Duplicate__c>>();
		System.debug('taskList: ' + taskList);

        for(Task t : taskList){
            System.debug('t.WhatId: ' + t.WhatId);
            
            if(t.WhatId != null){
                tasksWithAlert.add(t);
                alertIds.add(t.WhatId);

                //mapTaskAlert.put(t.id, t.What.id);
                mapAlertTask.put( t.WhatId, t);
            }
        }

        if(tasksWithAlert.isEmpty()){
            System.debug('Tasks With Alert is Empty');
            
            return;
        }

        List<SFSSDupeCatcher__Potential_Duplicate__c> duplicates = [
                Select Id, SFSSDupeCatcher__Duplicate_Warning__c, 
                SFSSDupeCatcher__Account__c,
                SFSSDupeCatcher__Account__r.CreatedDate,
                SFSSDupeCatcher__Account__r.OwnerId
                from SFSSDupeCatcher__Potential_Duplicate__c
                where SFSSDupeCatcher__Duplicate_Warning__c in :alertIds
                order by SFSSDupeCatcher__Account__r.CreatedDate DESC
        ];      

        //System.debug('mapTaskAlert:' + mapTaskAlert);
        System.debug('mapAlertTask' + mapAlertTask);

        for(SFSSDupeCatcher__Potential_Duplicate__c d : duplicates){
            if(mapAlertDuplicates.get(d.SFSSDupeCatcher__Duplicate_Warning__c) == null) {
                mapAlertDuplicates.put(d.SFSSDupeCatcher__Duplicate_Warning__c, new List<SFSSDupeCatcher__Potential_Duplicate__c>());
            }

            mapAlertDuplicates.get(d.SFSSDupeCatcher__Duplicate_Warning__c).add(d);
        }

        System.debug('mapAlertDuplicates' + mapAlertDuplicates);

        for(Id alertId : mapAlertDuplicates.keySet()){
            Task t  = mapAlertTask.get(alertId);

            Account acc = mapAlertDuplicates.get(alertId).get(0).SFSSDupeCatcher__Account__r;
            
            System.debug('acc per task: ' + t + ' is:' + acc);

            t.OwnerId = acc.OwnerId;
            t.Subject = Label.DC_TASK_SUBJECT;
            t.Description = Label.DC_TASK_COMMENT;
            t.RecordTypeId = recordTypeId;
        }
    }


}