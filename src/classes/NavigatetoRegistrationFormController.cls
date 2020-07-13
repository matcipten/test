public class NavigatetoRegistrationFormController {
    @AuraEnabled        
    public static String getUserCorrectInterface(){
        String url='Normal User';
        if([SELECT User_Id__c, Url_DCC__c
        FROM New_User_Interface_DCC__mdt 
        WHERE User_Id__c =: UserInfo.getUserId()].size()>0)
        url =[SELECT User_Id__c, Url_DCC__c
                                            FROM New_User_Interface_DCC__mdt 
                                            WHERE User_Id__c =: UserInfo.getUserId()].Url_DCC__c;
        
        return url;
    }

}