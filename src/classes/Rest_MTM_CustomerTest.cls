@isTest
public class Rest_MTM_CustomerTest {
    
    @isTest static void test_Get(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        usr.Codice_Boutique__c = '001';
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
        
        Account acc = AllDataFactory.create_Account();
        insert acc;
        system.debug('acc : ' +  acc);
        List<Account_Misure_Sartoriali__c> listAms = new List<Account_Misure_Sartoriali__c>();
        Account_Misure_Sartoriali__c ams = AllDataFactory.create_Account_Misure_Sartoriali();
        ams.Account__c = acc.Id;
        insert ams;
        listAms.add(ams);
        Location__c c = new Location__c();
        insert c;
        
        
        Associated__c t = new Associated__c();
        t.Id_Associate_Micros__c = '123456789';
        t.Location__c = c.Id;
        insert t;
        
        List<Ordine_Sartoria_Solomeo__c> listOss = new List<Ordine_Sartoria_Solomeo__c>();
        Ordine_Sartoria_Solomeo__c oss = new Ordine_Sartoria_Solomeo__c();
        oss.Associate__c = t.id;
        oss.Cliente__c = acc.Id;
        //oss.Name = 'Test';
        insert oss;
        
        listOss.add(oss);
        
        /* Rest_MTM_Customer.CustomerWrapper cW = new Rest_MTM_Customer.CustomerWrapper();
cW.FirstName = acc.FirstName;
cW.Id = acc.Id;
cW.LastName = acc.LastName;
cW.PersonEmail = acc.PersonEmail;
cW.Phone = acc.PersonMobilePhone;
cW.Id_Cliente_Relate = acc.Id_Cliente_Relate__c;
cW.misure = listAms;
cW.ordini = listOss;
*/
        Id [] fixedSearchResults = new Id[]{acc.Id};
            Test.setFixedSearchResults(fixedSearchResults);
        List<List<SObject>> searchList = [FIND 'TestSurname' 
                                          IN ALL FIELDS RETURNING 
                                          Account(id, name WHERE LastName = 'TestSurname' LIMIT 1)];
        req.requestURI =    '/MTM/V1/Customer/'; 
        req.addParameter('str', acc.LastName);
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = Rest_MTM_Customer.doGet();
        
        System.debug(rw);
            }
        Test.stopTest();
    }
    
    @isTest static void test_get1() {
        new Rest_MTM_Customer.RestCustomerHandler().beforeUpdate(null, null, null);
        new Rest_MTM_Customer.RestCustomerHandler().afterUpdateResponse(null, null, null);
        new Rest_MTM_Customer.RestCustomerHandler().beforeInsert(null);
        new Rest_MTM_Customer.RestCustomerHandler().afterInsert(null);
    }
    
}