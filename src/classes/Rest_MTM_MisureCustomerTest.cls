@isTest
public class Rest_MTM_MisureCustomerTest {

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
        
        Account_Misure_Sartoriali__c ams  = AllDataFactory.create_Account_Misure_Sartoriali();
		ams.Account__c = acc.Id;
        insert ams;
		        
        req.requestURI =    '/MTM/V1/Misure/'+acc.Id; 
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = Rest_MTM_MisureCustomer.doGet();
        
        System.debug(rw);
            
            }
        Test.stopTest();
        
    }
    @isTest static void test_GetError(){
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
        
        Account acc = AllDataFactory.create_Account();
        insert acc;
        
        Account_Misure_Sartoriali__c ams  = AllDataFactory.create_Account_Misure_Sartoriali();
		ams.Account__c = acc.Id;
        insert ams;
		        
        req.requestURI =    '/MTM/V1/Misure/'+acc.Id; 
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = Rest_MTM_MisureCustomer.doGet();
        
        System.debug(rw);
        
            }
        Test.stopTest();
    }
    
    
     @isTest static void test_Post(){
        
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
        //MC- To test order attachments process
        Location__c c = new Location__c();
        insert c;
               
        Associated__c t = new Associated__c();
        t.Id_Associate_Micros__c = '123456789';
        t.Location__c = c.Id;
        insert t;
        
        Ordine_Sartoria_Solomeo__c oss = new Ordine_Sartoria_Solomeo__c();
        oss.Associate__c = t.id;
        
        insert oss;
        string ossname = [SELECT Name FROM Ordine_Sartoria_Solomeo__c WHERE Id=:oss.Id].Name;
        //insert attachments order
        List<Attachment> aList = new List<Attachment>();
        aList.add(ALLDataFactory.create_Attachment(oss.Id, 'pdf_' + ossname + '.pdf', 'pdf'));
        aList.add(ALLDataFactory.create_Attachment(oss.Id, 'pdf_cliente_' + ossname + '.pdf', 'pdf'));
        aList.add(ALLDataFactory.create_Attachment(oss.Id, 'img_' + ossname + '.png', 'png'));
        insert aList;
        //MC-
         
        Account_Misure_Sartoriali__c ams  = AllDataFactory.create_Account_Misure_Sartoriali();
		ams.Account__c = acc.Id;
        ams.Ordine_Sartoria_Solomeo__c = oss.Id; 
        
		        
        req.requestURI =    '/MTM/V1/Misure/'; 
        req.httpMethod = 'Post';
        
        RestContext.response= res;
        RestContext.request = req;
         
       Rest_MTM_MisureCustomer.MisureWrapper mW = new Rest_MTM_MisureCustomer.MisureWrapper();
         mW.step = 'I';
         mW.data = ams;
         //MC- to test order attachments process
         List<Rest_MTM_MisureCustomer.AttachWrapper> awList = new List<Rest_MTM_MisureCustomer.AttachWrapper>();
         awList.add(ALLDataFactory.create_postAttachWrapper('pdf','pdf','testRest1'));
         awList.add(ALLDataFactory.create_postAttachWrapper('pdf','pdf_cliente','testRest1'));
         awList.add(ALLDataFactory.create_postAttachWrapper('png','img','testRest1'));
         mW.attachments = awList;
        
        ResponseWrapper rw = Rest_MTM_MisureCustomer.doPost(mW);
        System.debug(rw);
            
            }
        Test.stopTest();

        
    }
    @isTest static void test_PostSarto(){
        
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
        
        //MC- To test order attachments process
        Location__c c = new Location__c();
        insert c;
               
        Associated__c t = new Associated__c();
        t.Id_Associate_Micros__c = '123456789';
        t.Location__c = c.Id;
        insert t;
        
        Ordine_Sartoria_Solomeo__c oss = new Ordine_Sartoria_Solomeo__c();
        oss.Associate__c = t.id;
        insert oss;
        string ossname = [SELECT Name FROM Ordine_Sartoria_Solomeo__c WHERE Id=:oss.Id].Name;
        //insert attachments order
        List<Attachment> aList = new List<Attachment>();
        aList.add(ALLDataFactory.create_Attachment(oss.Id, 'pdf_' + ossname + '.pdf', 'pdf'));
        aList.add(ALLDataFactory.create_Attachment(oss.Id, 'pdf_cliente_' + ossname + '.pdf', 'pdf'));
        aList.add(ALLDataFactory.create_Attachment(oss.Id, 'img_' + ossname + '.png', 'png'));
        insert aList;
        //MC-
        
        Account_Misure_Sartoriali__c ams  = AllDataFactory.create_Account_Misure_Sartoriali();
		ams.Account__c = acc.Id;
        ams.Ordine_Sartoria_Solomeo__c = oss.id;
        insert ams;
		
        //MC- to test order attachments process
        List<Rest_MTM_MisureCustomer.AttachWrapper> awList = new List<Rest_MTM_MisureCustomer.AttachWrapper>();
        awList.add(ALLDataFactory.create_postAttachWrapper('pdf','pdf','testRest1'));
        awList.add(ALLDataFactory.create_postAttachWrapper('pdf','pdf_cliente','testRest1'));
        awList.add(ALLDataFactory.create_postAttachWrapper('png','img','testRest1'));
        
        req.requestURI =    '/MTM/V1/Misure/'; 
        req.httpMethod = 'Post';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ams.Circonferenza_vita_pantalone__c = 32;
        ams.Circonferenza_torace__c = 30;
       	Rest_MTM_MisureCustomer.MisureWrapper mW = new Rest_MTM_MisureCustomer.MisureWrapper();
        mW.step = 'U';
        mW.profilo = 'Sarto';
        mW.data = ams;
        mW.data.Id = ams.Id;
        mW.attachments = awList;
        
        
        ResponseWrapper rw = Rest_MTM_MisureCustomer.doPost(mW);
        System.debug(rw);
        
            }
        Test.stopTest();
    }
    
    @isTest static void test_get1() {
        //new Rest_MTM_MisureCustomer.RestMisureCustomerHandler().beforeUpdate(null, null, SObject(oss));
        new Rest_MTM_MisureCustomer.RestMisureCustomerHandler().afterUpdateResponse(null, null, null);
        new Rest_MTM_MisureCustomer.RestMisureCustomerHandler().beforeInsert(null);
        new Rest_MTM_MisureCustomer.RestMisureCustomerHandler().afterInsert(null);
        
        //MC- PassTest
        //Rest_MTM_MisureCustomer.passTest();
    }
}