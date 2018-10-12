global class ScheduleClosingCaseInactiveFor90Days implements Schedulable{
    global String errorMessage = '';
    global Boolean errorOccurred = false;
       
    public static void schedule_routine(String schName, String sch) {
        ScheduleClosingCaseInactiveFor90Days sis = new ScheduleClosingCaseInactiveFor90Days();
        System.Schedule(schName, sch, sis);
        System.debug('TenG: Scheduled "'+schName+'" successfully!');
    }
    /**
     * ScheduleClosingCaseInactiveFor90Days.schedule_updateCase();
     * for running the schedule
     * 
     * */

    public static void schedule_updateCase(String sch) {
        String schName = 'ScheduleClosingCaseInactiveFor90Days_schedule_updateCase';
        ScheduleClosingCaseInactiveFor90Days.schedule_routine(schName, sch);
    }
    public static void schedule_updateCase() {
        String sch = '0 0 6 ? * MON';
        schedule_updateCase(sch);
    }
    
		
    global void execute(SchedulableContext sc){
        
        ScheduleClosingCaseInactiveFor90Days.closingCase();
        
    }
  
    public static void closingCase(){
         	try{  
    	Date less90Days = System.today().addDays(-90);
               
        
		 List<Case> idsToUpdate = [SELECT id 
                                   FROM Case 
                                   WHERE IsClosed = false 
                                   AND (
                                       Data_Ultima_Mail__c  <= :less90Days 
                                        OR 
                                       LastModifiedDate <= :less90Days) 
                                  ];
	
        system.debug('query ----->'+idsToUpdate);
        system.debug('querySize ----->'+idsToUpdate.size());
 
      
            System.debug('Executing');
            
            List<case> updateStaCase = new List<case>();
            
            for(Case uCase: idsToUpdate ){
            System.debug('id-->'+uCase.Id);
            uCase.Chiuso_Automaticamente__c = true;
            uCase.status='Chiuso';
                
              updateStaCase.add(uCase);
        }
       
        update updateStaCase;
            
           }Catch(Exception e){
             system.debug('Eccezione Case updateInfo ' + e.getMessage());
			system.debug('StackString Case updateInfo ' + e.getStackTraceString());
               
      //      errorOccurred = true;
	//		errorMessage = ex.getMessage() + '|' + ex.getStackTraceString();   
            
           }
   
          
    }
    	
}