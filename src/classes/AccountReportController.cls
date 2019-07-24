public class AccountReportController {
    
    @auraEnabled
    public static String getReport(Id accId, String reportName){
      
        // Get the report ID
        List <Report> reportList = [SELECT Id,DeveloperName FROM Report where 
                                    DeveloperName = :reportName];
        String reportId = (String)reportList.get(0).get('Id');
        
        // Get the report metadata
        Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(reportId);
        Reports.ReportMetadata reportMd = describe.getReportMetadata();
        
        // Override filter and run report
        Reports.ReportFilter filter = reportMd.getReportFilters()[0];
        filter.setValue(accId);
        Reports.ReportResults results = Reports.ReportManager.runReport(reportId, reportMd);
               
        system.debug('results : ' + JSON.serialize(results));
        
        return JSON.serialize(results);
        
    }
    
}