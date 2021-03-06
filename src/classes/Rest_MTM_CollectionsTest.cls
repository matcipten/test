@isTest
public class Rest_MTM_CollectionsTest {
    
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
        
        List<Account_Misure_Sartoriali__c> listAms = new List<Account_Misure_Sartoriali__c>();
        Account_Misure_Sartoriali__c ams = AllDataFactory.create_Account_Misure_Sartoriali();
        ams.Account__c = acc.Id;
        insert ams;
        listAms.add(ams);
        
        Account_Misure_Sartoriali__c ams1 = AllDataFactory.create_Account_Misure_Sartoriali();
        ams1.Account__c = acc.Id;
        insert ams1;
        listAms.add(ams1);
        Stagione__c st = new Stagione__c();
        st.Name = 'test';
        st.Attiva__c = true;
        insert st;
        
        Capo__c capo = new Capo__c();
        capo.Stagione__c = st.Id;
        capo.Name = 'Test Name';
        capo.Codice_Abito__c = '33';
        capo.Codice_Giacca__c = '2332';
        capo.Codice_Pantalone__c = '232';
        capo.Descrizione_Modello_Giacca__c = '23';
        capo.Descrizione_Modello_Pantalone__c = '23';
        capo.Modello_Giacca__c = '32';
        
        insert capo;
        
       
        
        Tessuto__c tes = new Tessuto__c();
        tes.Name = 'ts Name';
        tes.Codice__c = '2323';
        tes.Descrizione_Tessuto__c ='sagfs';
        tes.Peso__c ='32';
        tes.Tipologia_Tessuto__c ='232' ;
        insert tes;

         Capo_Tessuto__c capoTe = new Capo_Tessuto__c();
        capoTe.Capo__c = capo.Id;
        capoTe.Tessuto__c = tes.Id;
        insert capoTe;
        Tessuto_Colore__c col = new Tessuto_Colore__c();
       
        col.Tessuto__c =tes.Id;
        col.Name = 'Test colore';
        col.Codice_Colore__c = 'Fw222';
        col.Descrizione_Colore__c = 'blue ';
        insert col;
                                   
        Fodera__c fd = new Fodera__c();
        fd.Name = 'Test Fd';
        fd.Codice__c = '32e23';
        fd.Descrizione__c = '2efds';         
        insert fd;
        
        Location__c c = new Location__c();
        insert c;
        
        Misure_di_Riferimento_Sartoria__c mdrs =  AllDataFactory.create_Misure_di_Riferimento_Sartoria('Pantalone');
       
        
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
        Rest_MTM_Collections.CollectionWrapper cW = new Rest_MTM_Collections.CollectionWrapper();
        //MC- To test Rest_MTM_Collections_Performant
        Rest_MTM_Collections_Performant.CollectionWrapper cW1 = new Rest_MTM_Collections_Performant.CollectionWrapper();
        
        
        
        req.requestURI =    '/MTM/V1/Collections/'; 
        req.httpMethod = 'GET';
        
        RestContext.response= res;
        RestContext.request = req;
        
        ResponseWrapper rw = Rest_MTM_Collections.doGet();
        //MC- To test Rest_MTM_Collections_Performant
        ResponseWrapper rw1 = Rest_MTM_Collections_Performant.doGet();
        
        req.requestURI = '/MTM/V1/Collections/' + capo.Id;
        RestContext.request = req;
        rw1 = Rest_MTM_Collections_Performant.doGet();
            
            }
        Test.stopTest();
    }
    
    @isTest static void test_get1() {
        new Rest_MTM_Collections.RestCollectionsHandler().beforeUpdate(null, null, null);
        new Rest_MTM_Collections.RestCollectionsHandler().afterUpdateResponse(null, null, null);
        new Rest_MTM_Collections.RestCollectionsHandler().beforeInsert(null);
        new Rest_MTM_Collections.RestCollectionsHandler().afterInsert(null);
        //MC- To test Rest_MTM_Collections_Performant
        new Rest_MTM_Collections_Performant.RestCollectionsHandler().beforeUpdate(null, null, null);
        new Rest_MTM_Collections_Performant.RestCollectionsHandler().afterUpdateResponse(null, null, null);
        new Rest_MTM_Collections_Performant.RestCollectionsHandler().beforeInsert(null);
        new Rest_MTM_Collections_Performant.RestCollectionsHandler().afterInsert(null);
    }
}