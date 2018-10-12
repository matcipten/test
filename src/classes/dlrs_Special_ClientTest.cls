/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_Special_ClientTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_Special_ClientTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new Special_Client__c());
    }
}