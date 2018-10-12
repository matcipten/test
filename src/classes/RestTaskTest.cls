@isTest
private class RestTaskTest {
    
    
    @isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI =    '/Task_v1.0/'; 
        req.httpMethod = 'POST';

        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){

        RecordTypeSetting__c rst = new RecordTypeSetting__c(Name='General');
        rst.Caso_ResoCambio__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio');
        rst.Caso_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio_in_Store');
        rst.Caso_CustomerCare__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce');
        rst.Caso_BrandSpecialist__c = DescribeUtils.getRecordTypeId('Case', 'Brand_Specialist');
        rst.Caso_OMS__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_OMS');
        rst.Task_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Task', 'Reso_Cambio_in_Store');
        rst.Task_Wishlist__c = DescribeUtils.getRecordTypeId('Task', 'Wishlist');
        insert rst;



        Location__c l = new Location__c();
        l.Id_Location_Micros__c = '123456789';
        l.Id_Location__c = '123456789';
        insert l;

        Account a = new Account(
            FirstName = 'name', 
            LastName = 'ln', 
            PersonEmail = 'asd@asd.asd',
            Id_Cliente_DW__c = '123456789'
            );
        insert a;

        Transaction__c t = new Transaction__c();
        t.Account__c = a.Id;
        t.Name = '123456789';
        insert t;

        Transaction_Detail__c td = new Transaction_Detail__c();
        td.Transaction__c = t.Id;
        td.Name = '123456789';
        insert td;

        Product__c pr = new Product__c();
        pr.Item_ID__c = '123456789';
        insert pr;


        Task c = new Task();
        c.Id_Cliente__c = '123456789';
        c.Origine_Task__c = 'ResoCambioStore';
        c.id_Store__c = '123456789';
        c.Id_Ordine__c = '123456789';
        c.Id_Reso__c = '123456789';

        Task c1 = new Task();
        c1.Id_Cliente__c = '123456789';
        c1.Origine_Task__c = 'Wishlist';
        c1.id_Store__c = '123456789';
        c1.Id_Ordine__c = '123456789';
        c1.Id_Reso__c = '123456789';
        c1.scheda_prodotto__c = '[{"prodotto" :"123456789","quantita" :"1"}]';

        Task c2 = new Task();
        c2.Id_Cliente__c = 'asd';
        c2.Origine_Task__c = 'Wishlist';
        c2.id_Store__c = '123456789';
        c2.Id_Ordine__c = '123456789';
        c2.Id_Reso__c = '123456789';
        c2.scheda_prodotto__c = '[{"prodotto" :"123456789","quantita" :"1"}]';

        Task c3 = new Task();
        c3.Id_Cliente__c = '123456789';
        c3.Origine_Task__c = 'Wishlist';
        c3.id_Store__c = 'asd';
        c3.Id_Ordine__c = '123456789';
        c3.Id_Reso__c = '123456789';
        c3.scheda_prodotto__c = '[{"prodotto" :"123456789","quantita" :"1"}]';

        Task c4 = new Task();
        c4.Id_Cliente__c = '123456789';
        c4.Origine_Task__c = 'Wishlist';
        c4.id_Store__c = '123456789';
        c4.Id_Ordine__c = 'asd';
        c4.Id_Reso__c = '123456789';
        c4.scheda_prodotto__c = '[{"prodotto" :"123456789","quantita" :"1"}]';

          Task c5 = new Task();
        c5.Id_Cliente__c = '123456789';
        c5.Origine_Task__c = 'Wishlist';
        c5.id_Store__c = '123456789';
        c5.Id_Ordine__c = '123456789';
        c5.Id_Reso__c = 'asd';
        c5.scheda_prodotto__c = '[{"prodotto" :"123456789","quantita" :"1"}]';
        //c.RecordTypeId = recordTypeID;
        
        RestContext.response= res;
        RestContext.request = req;
        
        RestTask.doPost(c);
        RestTask.doPost(c1);
        RestTask.doPost(c2);
        RestTask.doPost(c3);
        RestTask.doPost(c4);
        RestTask.doPost(c5);

        RestTask.RestTaskHandler rch = new RestTask.RestTaskHandler();
        rch.get(req,res);
        rch.beforeUpdate(req,res, null);
        rch.afterUpdateResponse(req,res, null);
            
            
        }
        Test.stopTest();
    }

    
}