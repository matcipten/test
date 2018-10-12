public with sharing class DescribeUtils {
    
    public static Map<String,Schema.RecordTypeInfo> getRecordTypeInfoMap(String objectName){
        List<Schema.DescribeSObjectResult> l = Schema.describeSObjects(new List<String>{objectName});
        
        if(l == null || l.isEmpty()){
            return null;
        }
        
        return l.get(0).getRecordTypeInfosByName();
    }

    /*public static Id getRecordTypeId(String objectName, String recordTypeName){
        return DescribeUtils.getRecordTypeInfoMap(objectName).get(recordTypeName).getRecordTypeId();
    }
    */

    public static Id getRecordTypeId(String objectName, String recordTypeName){
        RecordType rt = [SELECT Id, Description,DeveloperName,Name,SobjectType FROM RecordType where SobjectType = :objectName and DeveloperName =:recordTypeName LIMIT 1];

        return rt == null ? null : rt.Id;
    }
}