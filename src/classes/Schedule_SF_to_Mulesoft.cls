global class Schedule_SF_to_Mulesoft implements Schedulable {
    global void execute(SchedulableContext ctx) {
        SFtoMuleSoft_Retry.doRetry();
     }   
}