@isTest
public class Rest_MTM_OrderedTest {
    
    @testSetup static void setup() {
        // Create common test DATA
        
        Location__c c = new Location__c();
        insert c;
        
        Associated__c t = new Associated__c();
        t.Id_Associate_Micros__c = '123456789';
        t.Location__c = c.Id;
        insert t;
        
        Ordine_Sartoria_Solomeo__c oss = new Ordine_Sartoria_Solomeo__c();
        oss.Associate__c = t.id;
        oss.Status__c = 'In editing';
        //oss.Name = 'Test';
        insert oss;
        
        Ordine_Sartoria_Solomeo__c oss2 = new Ordine_Sartoria_Solomeo__c();
        oss2.Associate__c = t.id;
        oss2.Status__c = 'In revisione 1 livello';
        //oss.Name = 'Test';
        insert oss2;
        
        Ordine_Sartoria_Solomeo__c oss3 = new Ordine_Sartoria_Solomeo__c();
        oss3.Associate__c = t.id;
        oss3.Status__c = 'Rifiutato 1 livello';
        //oss.Name = 'Test';
        insert oss3;
        
        Ordine_Sartoria_Solomeo__c oss4 = new Ordine_Sartoria_Solomeo__c();
        oss4.Associate__c = t.id;
        oss4.Status__c = 'In revisione 1 livello';
        //oss.Name = 'Test';
        insert oss4;
        
        Ordine_Sartoria_Solomeo__c oss5 = new Ordine_Sartoria_Solomeo__c();
        oss5.Associate__c = t.id;
        oss5.Status__c = 'Rifiutato dal sarto';
        //oss.Name = 'Test';
        insert oss5;
        
        Ordine_Sartoria_Solomeo__c oss6 = new Ordine_Sartoria_Solomeo__c();
        oss6.Associate__c = t.id;
        oss6.Status__c = 'In revisione dal sarto';
        //oss.Name = 'Test';
        insert oss6;
        
        Ordine_Sartoria_Solomeo__c oss7 = new Ordine_Sartoria_Solomeo__c();
        oss7.Associate__c = t.id;
        oss7.Status__c = 'In revisione dal sarto';
        //oss.Name = 'Test';
        insert oss7;
        
        Ordine_Sartoria_Solomeo__c oss8 = new Ordine_Sartoria_Solomeo__c();
        oss8.Associate__c = t.id;
        oss8.Status__c = 'Approvato dal sarto';
        //oss.Name = 'Test';
        insert oss8;
        
        Ordine_Sartoria_Solomeo__c oss9 = new Ordine_Sartoria_Solomeo__c();
        oss9.Associate__c = t.id;
        oss9.Status__c = 'Ricevuto in negozio';
        //oss.Name = 'Test';
        insert oss9;
    }
    
    @isTest static void test_Get(){ 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Location__c c = new Location__c();
        insert c;
        
        
        Associated__c t = new Associated__c();
        t.Id_Associate_Micros__c = '123456789';
        t.Location__c = c.Id;
        insert t;
        
        Ordine_Sartoria_Solomeo__c oss = new Ordine_Sartoria_Solomeo__c();
        oss.Associate__c = t.id;
        //oss.Name = 'Test';
        insert oss;
        
        //MC- Added test for attachments
        Attachment a = AllDataFactory.create_attachment(oss.Id, 'pfd_test', 'pdf');
        insert a;
        
        //
        
        req.requestURI =    '/MTM/V1/Ordered/'+t.Id; 
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = Rest_MTM_Ordered.doGet();
        
        System.debug(rw);
    }
    
    @isTest static void test_GetSarto(){ 
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Location__c c = new Location__c();
        insert c;
        
        
        Associated__c t = new Associated__c();
        t.Id_Associate_Micros__c = '123456789';
        t.Location__c = c.Id;
        insert t;
        
        Ordine_Sartoria_Solomeo__c oss = new Ordine_Sartoria_Solomeo__c();
        oss.Associate__c = t.id;
        //oss.Name = 'Test';
        insert oss;
        
        //MC- Added test for attachments
        Attachment a = AllDataFactory.create_attachment(oss.Id, 'pfd_test', 'pdf');
        insert a;
        
        req.requestURI =    '/MTM/V1/Ordered/'; 
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = Rest_MTM_Ordered.doGet();
        
        System.debug(rw);
    }
    
    @isTest static void test_Post(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Location__c c = new Location__c();
        insert c;
        
        
        Associated__c t = new Associated__c();
        t.Id_Associate_Micros__c = '123456789';
        t.Location__c = c.Id;
        insert t;
        
        Ordine_Sartoria_Solomeo__c oss = new Ordine_Sartoria_Solomeo__c();
        oss.Associate__c = t.id;
        oss.Status__c = 'In editing';
        //oss.Name = 'Test';
        insert oss;
        
        req.requestURI =    '/MTM/V1/Ordered/'+t.Id; 
        req.httpMethod = 'Post';
        
        RestContext.response= res;
        RestContext.request = req;
        
        Rest_MTM_Ordered.OrderWrapper oW = new Rest_MTM_Ordered.OrderWrapper();
        oW.step = 'I';
        oW.data = oss;
        
        String JsonMsg=JSON.serialize(oW);
        
        ResponseWrapper rw = Rest_MTM_Ordered.doPost(oW);
        
        
        System.debug(rw);
    }    
    
    @isTest static void test_Update(){
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Associated__c t = [select Id, Location__c From Associated__c LIMIT 1];
        
        MTM_Alert__c mtm_alert = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Referente MTM');
        insert mtm_alert;
        
        MTM_Alert__c mtm_alert2 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Referente MTM');
        insert mtm_alert2;
        
        MTM_Alert__c mtm_alert3 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Boutique');
        insert mtm_alert3;
        
        MTM_Alert__c mtm_alert4 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Boutique');
        insert mtm_alert4;
        
        Test.startTest();
        System.runAs(u){
            
            
        }
        Test.stopTest();
    }   
    
    @isTest static void test_Update2(){
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Associated__c t = [select Id, Location__c From Associated__c LIMIT 1];
        
        MTM_Alert__c mtm_alert = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Referente MTM');
        insert mtm_alert;
        
        MTM_Alert__c mtm_alert2 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Referente MTM');
        insert mtm_alert2;
        
        MTM_Alert__c mtm_alert3 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Boutique');
        insert mtm_alert3;
        
        MTM_Alert__c mtm_alert4 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Boutique');
        insert mtm_alert4;
        
        Test.startTest();
        System.runAs(u){
            
            
            
        }
        Test.stopTest();
    } 
    
    @isTest static void test_Update3(){
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Associated__c t = [select Id, Location__c From Associated__c LIMIT 1];
        
        MTM_Alert__c mtm_alert = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Referente MTM');
        insert mtm_alert;
        
        MTM_Alert__c mtm_alert2 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Referente MTM');
        insert mtm_alert2;
        
        MTM_Alert__c mtm_alert3 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Boutique');
        insert mtm_alert3;
        
        MTM_Alert__c mtm_alert4 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Boutique');
        insert mtm_alert4;
        
        Test.startTest();
        System.runAs(u){
            
            
            
        }
        Test.stopTest();
    }  
    
    @isTest static void test_Update4(){
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Associated__c t = [select Id, Location__c From Associated__c LIMIT 1];
        
        MTM_Alert__c mtm_alert = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Referente MTM');
        insert mtm_alert;
        
        MTM_Alert__c mtm_alert2 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Referente MTM');
        insert mtm_alert2;
        
        MTM_Alert__c mtm_alert3 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Boutique');
        insert mtm_alert3;
        
        MTM_Alert__c mtm_alert4 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Boutique');
        insert mtm_alert4;
        
        Test.startTest();
        System.runAs(u){
            
            

            
        }
        Test.stopTest();
    }    
    
    @isTest static void test_Update5(){
        
        User u = AllDataFactory.create_User();
        u.Codice_Boutique__c = '001';
        insert u;
        
        Associated__c t = [select Id, Location__c From Associated__c LIMIT 1];
        
        MTM_Alert__c mtm_alert = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Referente MTM');
        insert mtm_alert;
        
        MTM_Alert__c mtm_alert2 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Referente MTM');
        insert mtm_alert2;
        
        MTM_Alert__c mtm_alert3 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'TO', 'Boutique');
        insert mtm_alert3;
        
        MTM_Alert__c mtm_alert4 = AllDataFactory.create_MTM_Alert(t.Location__c, '1', 'CC', 'Boutique');
        insert mtm_alert4;
        
        Test.startTest();
        System.runAs(u){
            
            
            
        }
        Test.stopTest();
    }
    
    @isTest static void test_get1() {
        //new Rest_MTM_Ordered.RestOrderedHandler().beforeUpdate(null, null, SObject(oss));
        new Rest_MTM_Ordered.RestOrderedHandler().afterUpdateResponse(null, null, null);
        new Rest_MTM_Ordered.RestOrderedHandler().beforeInsert(null);
        new Rest_MTM_Ordered.RestOrderedHandler().afterInsert(null);
        //new Rest_MTM_Ordered.RestOrderedHandler().afterInsertUpdate(null);
    }
    
}