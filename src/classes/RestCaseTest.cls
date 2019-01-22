@isTest
private class RestCaseTest {
    
    
    @isTest static void test_post() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            req.requestURI =    '/Ticket_v1.0/'; 
            req.httpMethod = 'POST';
            //req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');
            
            //String recordTypeID = DescribeUtils.getRecordTypeId('Case', 'Customer Care');
            RecordTypeSetting__c rst = new RecordTypeSetting__c(Name='General');
            rst.Caso_ResoCambio__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio');
            rst.Caso_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio_in_Store');
            rst.Caso_CustomerCare__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce');
            rst.Caso_BrandSpecialist__c = DescribeUtils.getRecordTypeId('Case', 'Brand_Specialist');
            rst.Caso_OMS__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_OMS');
            rst.Task_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Task', 'Reso_Cambio_in_Store');
            rst.Task_Wishlist__c = DescribeUtils.getRecordTypeId('Task', 'Wishlist');
            rst.Caso_NotifyMe__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce_Notify_Me');
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
            
            Product__c p = new Product__c();
            p.Item_ID__c = '123456789';
            insert p;
            
            Case c = new Case();
            c.Id_Cliente__c = '123456789';
            c.Origine_Ticket__c = 'ResoCambio';
            c.Tipologia__c = 'E';
            c.id_Store__c = '123456789';
            c.Id_Ordine__c = '123456789';
            c.Id_Reso__c = '123456789';
            
            Case c1 = new Case();
            c1.Id_Cliente__c = '123456789';
            c1.Origine_Ticket__c = 'ResoCambio';
            c1.Tipologia__c = 'E';
            c1.id_Store__c = 'asd';
            c1.Id_Ordine__c = '123456789';
            c1.Id_Reso__c = '123456789';
            
            Case c1a = new Case();
            c1a.Id_Cliente__c = '123456789';
            c1a.Origine_Ticket__c = 'asd';
            c1a.Tipologia__c = 'E';
            c1a.id_Store__c = 'asd';
            c1a.Id_Ordine__c = '123456789';
            c1a.Id_Reso__c = '123456789';
            
            Case c2 = new Case();
            c2.Id_Cliente__c = '123456789';
            c2.Origine_Ticket__c = 'ResoCambio';
            c2.Tipologia__c = 'E';
            c2.id_Store__c = '123456789';
            c2.Id_Ordine__c = 'asd';
            c2.Id_Reso__c = '123456789';
            
            Case c3 = new Case();
            c3.Id_Cliente__c = '123456789';
            c3.Origine_Ticket__c = 'ResoCambio';
            c3.Tipologia__c = 'E';
            c3.id_Store__c = '123456789';
            c3.Id_Ordine__c = '123456789';
            c3.Id_Reso__c = 'asd';
            
            Case c3a = new Case();
            c3a.Id_Cliente__c = 'asd';
            c3a.Origine_Ticket__c = 'ResoCambio';
            c3a.Tipologia__c = 'E';
            c3a.id_Store__c = '123456789';
            c3a.Id_Ordine__c = '123456789';
            c3a.Id_Reso__c = '123456789';
            
            Case c4 = new Case();
            c4.Id_Cliente__c = '123456789';
            c4.Origine_Ticket__c = 'ResoCambioStore';
            c4.Tipologia__c = 'E';
            c4.id_Store__c = '123456789';
            c4.Id_Ordine__c = '123456789';
            c4.Id_Reso__c = '123456789';
            
            
            Case c5 = new Case();
            c5.Id_Cliente__c = '123456789';
            c5.Origine_Ticket__c = 'CustomerCare';
            c5.Tipologia__c = 'E';
            c5.id_Store__c = '123456789';
            c5.Id_Ordine__c = '123456789';
            c5.Id_Reso__c = '123456789';
            
            
            Case c6 = new Case();
            c6.Id_Cliente__c = '123456789';
            c6.Origine_Ticket__c = 'BrandSpecialist';
            c6.Tipologia__c = 'E';
            c6.id_Store__c = '123456789';
            c6.Id_Ordine__c = '123456789';
            c6.Id_Reso__c = '123456789';
            c6.Prodotto_Selezionato__c = '123456789';
            
            
            Case c6a = new Case();
            c6a.Id_Cliente__c = '123456789';
            c6a.Origine_Ticket__c = 'BrandSpecialist';
            c6a.Tipologia__c = 'E';
            c6a.id_Store__c = '123456789';
            c6a.Id_Ordine__c = '123456789';
            c6a.Id_Reso__c = '123456789';
            c6a.Prodotto_Selezionato__c = 'asd';
            
            
            Case c7 = new Case();
            c7.Id_Cliente__c = '123456789';
            c7.Origine_Ticket__c = 'OMS';
            c7.Tipologia__c = 'E';
            c7.id_Store__c = '123456789';
            c7.Id_Ordine__c = '123456789';
            c7.Id_Reso__c = '123456789';
            
            
            //c.RecordTypeId = recordTypeID;
            
            RestContext.response= res;
            RestContext.request = req;
            
            RestCase.doPost(c);
            RestCase.doPost(c1);
            RestCase.doPost(c1a);
            RestCase.doPost(c2);
            RestCase.doPost(c3);
            RestCase.doPost(c3a);
            RestCase.doPost(c4);
            RestCase.doPost(c5);
            RestCase.doPost(c6);
            RestCase.doPost(c6a);
            RestCase.doPost(c7);
            
            RestCase.RestCaseHandler rch = new RestCase.RestCaseHandler();
            //rch.get(req,res);
            //rch.beforeUpdate(req,res, null);
            //rch.afterUpdateResponse(req,res, null);
            
            
        }
        Test.stopTest();
        
    }
    
    @isTest static void test_put() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            
            req.httpMethod = 'PUT';
            //req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');
            
            //String recordTypeID = DescribeUtils.getRecordTypeId('Case', 'Customer Care');
            RecordTypeSetting__c rst = new RecordTypeSetting__c(Name='General');
            rst.Caso_ResoCambio__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio');
            rst.Caso_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio_in_Store');
            rst.Caso_CustomerCare__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce');
            rst.Caso_BrandSpecialist__c = DescribeUtils.getRecordTypeId('Case', 'Brand_Specialist');
            rst.Caso_OMS__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_OMS');
            rst.Task_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Task', 'Reso_Cambio_in_Store');
            rst.Task_Wishlist__c = DescribeUtils.getRecordTypeId('Task', 'Wishlist');
            rst.Caso_NotifyMe__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce_Notify_Me');
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
            
            Product__c p = new Product__c();
            p.Item_ID__c = '123456789';
            insert p;
            
            Case c = new Case();
            c.Id_Cliente__c = '123456789';
            c.Origine_Ticket__c = 'ResoCambio';
            c.Tipologia__c = 'E';
            c.id_Store__c = '123456789';
            c.Id_Ordine__c = '123456789';
            c.Id_Reso__c = '123456789';
            insert c;
            
            
            
            //c.RecordTypeId = recordTypeID;
            req.requestURI =    '/Ticket_v1.0/'+c.Id;
            RestContext.response= res;
            RestContext.request = req;
            
            RestCase.doPatch(c);
            
            
            RestCase.RestCaseHandler rch = new RestCase.RestCaseHandler();
            rch.get(req,res);
            rch.beforeUpdate(req,res, c);
            rch.afterUpdateResponse(req,res, c);
            
            
        }
        Test.stopTest();
        
    }
    @isTest static void test_get() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){
            
            
            req.httpMethod = 'GET';
            //req.requestBody = Blob.valueof('{  "customer" :{"LastName": "Brambilla"}');
            
            //String recordTypeID = DescribeUtils.getRecordTypeId('Case', 'Customer Care');
            RecordTypeSetting__c rst = new RecordTypeSetting__c(Name='General');
            rst.Caso_ResoCambio__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio');
            rst.Caso_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Case', 'Reso_Cambio_in_Store');
            rst.Caso_CustomerCare__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce');
            rst.Caso_BrandSpecialist__c = DescribeUtils.getRecordTypeId('Case', 'Brand_Specialist');
            rst.Caso_OMS__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_OMS');
            rst.Task_ResoCambioStore__c = DescribeUtils.getRecordTypeId('Task', 'Reso_Cambio_in_Store');
            rst.Task_Wishlist__c = DescribeUtils.getRecordTypeId('Task', 'Wishlist');
            rst.Caso_NotifyMe__c = DescribeUtils.getRecordTypeId('Case', 'Ticket_E_commerce_Notify_Me');
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
            
            Product__c p = new Product__c();
            p.Item_ID__c = '123456789';
            insert p;
            
            Case c = new Case();
            c.Id_Cliente__c = '123456789';
            c.Origine_Ticket__c = 'ResoCambio';
            c.Tipologia__c = 'E';
            c.id_Store__c = '123456789';
            c.Id_Ordine__c = '123456789';
            c.Id_Reso__c = '123456789';
            insert c;
            
            
            
            //c.RecordTypeId = recordTypeID;
            req.requestURI =    '/Ticket_v1.0/'+c.Id;
            RestContext.response= res;
            RestContext.request = req;
            
            RestCase.doGet();
            
            
            RestCase.RestCaseHandler rch = new RestCase.RestCaseHandler();
            rch.get(req,res);
            
            
            
        }
        Test.stopTest();
        
    }
    
}