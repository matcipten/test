@isTest
private class RestMultiTransactionDetailTest {
  
  @isTest static void test_post() {
    RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
      
      User usr = AllDataFactory.create_User();
        insert usr;
        
        Profile__c profileSettings = AllDataFactory.create_TriggerSetting(usr.ProfileId);
        insert profileSettings;
        
        Test.startTest();
        System.runAs(usr){

        req.requestURI =    '/MultiTransaction_Detail_v1.0/'; 
        req.httpMethod = 'POST';

        WebService_Settings__c cs= new WebService_Settings__c(Name='General');
        cs.TransactionDetailPostRecordLimit__c = 50;
        cs.TenderDetailPostRecordLimit__c = 50;
        cs.OMS_Endpoint__c = 'http://46.30.169.234:8084/dispatch/tickets/oms/close';
        cs.OMS_Enviroment__c = '';
        cs.OMS_Task_Parameter__c = 'ticket';
        insert cs;

        Account customer = new Account();
        customer.LastName = 'Brambilla';
        insert customer;

        Transaction__c c = new Transaction__c();
        c.Account__c = customer.Id;
        insert c;

         Transaction_Detail__c t = new Transaction_Detail__c();
         t.Transaction__c = c.Id;
         t.CurrencyIsoCode = 'EUR';
         t.Prezzo_di_Vendita__c = 100;
         t.Prezzo_di_Listino__c = 100;

         Transaction_Detail__c t1 = new Transaction_Detail__c();
         t1.Transaction__c = c.Id;
         t1.CurrencyIsoCode = 'EUR';
         t1.Prezzo_di_Vendita__c = 100;
         t1.Prezzo_di_Listino__c = 100;
        //insert t;

        List<Transaction_Detail__c> l = new List<Transaction_Detail__c>{t, t1};
        RestMultiTransactionDetail.ListWrapper lw = new RestMultiTransactionDetail.ListWrapper(l);
        String j = JSON.serialize(lw);

        RestContext.response= res;
        RestContext.request = req;
        req.requestBody = Blob.valueOf(j);
        
        ResponseWrapper rw = RestMultiTransactionDetail.doPost();
        
        System.debug(rw);
            
        }
        Test.stopTest();
  }

}