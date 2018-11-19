@RestResource(urlMapping='/MTM/V1/Ordered/*')
global without sharing class Rest_MTM_Ordered {
    
    // Get Order
    @HttpGet
    global static ResponseWrapper doGet(){
        return new RestOrderedHandler().doGetHandler(RestContext.request, RestContext.response); 
    }
    
    // INSERT & UPDATE ORDER
    @HttpPost
    global static ResponseWrapper doPost(OrderWrapper order) {
        Ordine_Sartoria_Solomeo__c orderData = new Ordine_Sartoria_Solomeo__c();
        orderData = order.data;         
        
        return new RestOrderedHandler().doPostHandlerWrapper(order.step, orderData);
    }    
    
    public static List<OrderResponseWrapper> getOrdine(List<Ordine_Sartoria_Solomeo__c> ordineList, List<Account> accountList,List<Associated__c> associateList ,  List<Account_Misure_Sartoriali__c> misureList){
        
        List<OrderResponseWrapper> orderWrapList = new List<OrderResponseWrapper>();
        //MC- 2018.08.03 create map orderId ==> related attachment list #start
        Map<string,List<AttachWrapper>> orderIdToAttachs = new Map<string,List<AttachWrapper>>();
        for(Ordine_Sartoria_Solomeo__c ord :ordineList){
            if(ord.Attachments != null && ord.Attachments.size() > 0){
                List<AttachWrapper> attwList = new List<AttachWrapper>();
                for(Attachment att :ord.Attachments){
                    AttachWrapper aw = new AttachWrapper();
                    aw.Id = att.Id;
                    aw.Name = att.Name;
                    attwList.add(aw);
                }
                orderIdToAttachs.put(ord.Id,attwList);
            }
        }
        //MC- 2018.08.03 create map orderId ==> related attachment list #End
        
        for(Ordine_Sartoria_Solomeo__c ossW : ordineList){
            system.debug('ossW : ' +ossW);
            OrderResponseWrapper orderWrap = new OrderResponseWrapper();
            //orderWrap.ordine = ossw;
            orderWrap.id = ossW.Id ;
            orderWrap.OwnerId = ossW.OwnerId;
            orderWrap.IsDeleted = ossW.IsDeleted;
            orderWrap.Name = ossW.Name;
            orderWrap.CurrencyIsoCode = ossW.CurrencyIsoCode;
            orderWrap.Cliente =ossW.Cliente__c;
            orderWrap.Status = ossW.Status__c;
            orderWrap.Area_MTM = ossW.Area_MTM__c;
            orderWrap.Tessuto_Colore = ossW.Tessuto_Colore__c;
            orderWrap.Capo = ossW.Capo__c;
            orderWrap.Fodera = ossW.Fodera__c;
            orderWrap.Bottone = ossW.Bottone__c;
            orderWrap.Completato = ossW.Completato__c;
            orderWrap.Tessuto = ossW.Tessuto__c;
            orderWrap.Descrizione_Tessuto = ossW.Descrizione_Tessuto__c;
            orderWrap.Descrizione_Colore = ossW.Descrizione_Colore__c;
            orderWrap.Quantit = ossW.Quantit__c;
            orderWrap.Nome_Associate = ossW.Nome_Associate__c;
            orderWrap.Cognome_Associate =ossW.Cognome_Associate__c;
            orderWrap.LastModifiedDate = ossW.LastModifiedDate;
            orderWrap.Data_approvazione_ordine_1_livello = ossW.Data_approvazione_ordine_1_livello__c;
            orderWrap.Data_approvazione_ordine_2_livello = ossW.Data_approvazione_ordine_2_livello__c;
            orderWrap.Data_consegna_a_cliente = ossW.Data_consegna_a_cliente__c;
            orderWrap.Data_consegna_in_negozio = ossW.Data_consegna_in_negozio__c;
            orderWrap.Nota_approvatore_1_livello = ossW.Nota_approvatore_1_livello__c;
            orderWrap.Nota_di_consegna_al_cliente = ossW.Nota_di_consegna_al_cliente__c;
            orderWrap.Nota_negozio = ossW.Nota_negozio__c;
            orderWrap.Nota_sarto = ossW.Nota_sarto__c;
            orderWrap.CreatedDate = ossW.CreatedDate;
            orderWrap.Prezzo_number = ossW.Prezzo_number__c;
            orderWrap.Prezzo_valuta = ossW.Prezzo_valuta__c;
            orderWrap.Record_Type_Giacca = ossW.Record_Type_Giacca__c;
            if(orderIdToAttachs.containsKey(ossW.Id)){  //MC-
                orderWrap.orderAttachments = orderIdToAttachs.get(ossW.Id);
            }   
            //List<CustomerMisureWrapper> cmwList = new List<CustomerMisureWrapper>();
            
            for(Account accW : accountList){
                system.debug('accW : ' +accW);
                if(accW.Id == ossw.Cliente__c){
                    CustomerMisureWrapper cmw = new CustomerMisureWrapper();
                    cmw.Id = accW.Id;
                    cmw.Name = accW.Name;
                    cmw.Phone = accW.Phone;
                    cmw.PersonEmail = accW.PersonEmail;
                    cmw.Id_Cliente_Relate = accW.Id_Cliente_Relate__c;
                    List<Account_Misure_Sartoriali__c> amsWList = new List<Account_Misure_Sartoriali__c>();
                    for(Account_Misure_Sartoriali__c amsW :  misureList){
                        system.debug('amsW : ' +amsW);
                        if(amsW.Account__c == accW.Id ){
                            amsWList.add(amsW);
                        }
                    }
                    cmw.misure = amsWList;
                    //cmwList.add(cmw);
                    orderWrap.Customer = cmw;
                }
                for(Associated__c assoc : associateList){
                    system.debug('ossW.Associate__c : ' + ossW.Associate__c);
                    if(assoc.Id == ossW.Associate__c ){
                        AssociateWrapper assocWrap = new AssociateWrapper();
                        assocWrap.Id = assoc.Id;
                        assocWrap.Name = assoc.Name;
                        assocWrap.Location_Name = assoc.Location_Name__c;
                        
                        orderWrap.Associate = assocWrap;
                    }
                }
            }
            
            
            system.debug('orderWrap : ' + orderWrap);
            orderWrapList.add(orderWrap);
        }
        //ow.ordine = orderWrapList;
        
        return orderWrapList;
        
    }
    
    public static List<Ordine_Sartoria_Solomeo__c> getOrdineSartoriaSolomeoByAssociate(String associateId){
        
        List<Ordine_Sartoria_Solomeo__c> result = new List<Ordine_Sartoria_Solomeo__c>();
        //result = GenericDao.getAllFieldsListResultById('Ordine_Sartoria_Solomeo__c', 'Associate__c', associateId);
        result = GenericDao.getAllFieldsListResultByIdWithAttachs('Ordine_Sartoria_Solomeo__c', 'Associate__c', associateId);   //MC- 
        return result;
        
    }
    public static List<Ordine_Sartoria_Solomeo__c> getOrdineSartoriaSolomeoBySarto(){
        
        List<Ordine_Sartoria_Solomeo__c> result = new List<Ordine_Sartoria_Solomeo__c>();
        result = GenericDao.getAllFieldsResultByConditionStatusWithAttachments('Ordine_Sartoria_Solomeo__c', 'Status__c', 'Annullato' , 'Consegnato al Cliente');   //MC-
        return result;
        
    }
    
    public static List<Ordine_Sartoria_Solomeo__c> getOrdineSartoriaSolomeoArea(List<String> Aree){
        
        List<Ordine_Sartoria_Solomeo__c> result = new List<Ordine_Sartoria_Solomeo__c>();
         result = GenericDao.getAllFieldsListWhereInConditionsWithNoLimits('Ordine_Sartoria_Solomeo__c', 'Area_MTM__c', Aree);
        return result;
        
    }
    
    public static List<Account> getOrdineSartoriaSolomeoAccounts(Set<ID> setAccountIds){
        
        List<Account> result = new List<Account>();
        result = GenericDao.getAllFieldsListWhereInConditionsWithNoLimits('Account', 'Id', setAccountIds);
        return result;
        
    }
    public static List<Account_Misure_Sartoriali__c> getOrdineSartoriaSolomeoAccountsMisure(Set<ID> setAccountIds){
        
        List<Account_Misure_Sartoriali__c> result = new List<Account_Misure_Sartoriali__c>();
        result = GenericDao.getAllFieldsListWhereInConditions('Account_Misure_Sartoriali__c', 'Account__c', setAccountIds);
        return result;
        
    }
    public static List<Associated__c> getOrdineSartoriaSolomeoAssociate(Set<ID> setAssociateIds){
        
        List<Associated__c> result = new List<Associated__c>();
        result = GenericDao.getAllFieldsListWhereInConditions('Associated__c', 'Id', setAssociateIds);
        return result;
        
    }
     public static List<Associated__c> getOrdineSartoriaSolomeoAssociate(String associateId){
        List<Associated__c> result = new List<Associated__c>();
        result = GenericDao.getAllFieldsListResultById('Associated__c', 'id', associateId);
        return result;
        
    }
    
    
    
    public class RestOrderedHandler extends Rest_MTM_CalloutHandler{
        
        public override Object get(RestRequest req,  RestResponse res){
            
            String reqUri = req.requestURI.substring(1);
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String version = arr[1];
            String objects = arr[2];
            String userId = arrSize > 3 ? arr[3] : null;
            String relatedResource = arrSize > 4 ? arr[4] : null;
            String idRelatedResource = arrSize > 5 ? arr[5] : null;
            system.debug('MC- requestURI arr: ' + arr);
            
            List<OrderResponseWrapper> orw = new List<OrderResponseWrapper>();
            List<Ordine_Sartoria_Solomeo__c> orderedList;
            Set<ID> setAccountIds = new Set<ID>();
            Set<ID> setAssociateIds = new Set<ID>();
            List<OrderResponseWrapper> result;
            
            User usr = new User();
            System.debug('userId: ' + userId);
            if(userId != null && userId.startsWith('005')){
                usr = [Select id, Codice_Boutique__c, Codice_Associate__c, Nome_Profilo__c, Area_MTM__c FROM User WHERE id = : userId];
                if(usr.Nome_Profilo__c == 'BC - Associate'){
                    List<Associated__c> associate = new List<Associated__c>();
                    associate = GenericDao.getAllFieldsListResultById('Associated__c', 'Id_Associate__c', usr.Codice_Associate__c);
                    System.debug('SV associate: ' + associate);
                    Id associateId = associate[0].Id;
                    orderedList = RestOrderedHandler.getOrdineSartoriaSolomeoByAssociate(associateId);
                    
                    for (Ordine_Sartoria_Solomeo__c singleOrder : orderedList){
                        setAccountIds.add(singleOrder.Cliente__c);
                        
                    }
                    List<Account> accountList =  Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccounts(setAccountIds);
                    List<Account_Misure_Sartoriali__c> misureList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccountsMisure(setAccountIds);
                    List<Associated__c> associateList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAssociate(associateId);
                    
                    result = getOrdine (orderedList, accountList ,associateList ,  misureList );
                    
                } else if(usr.Nome_Profilo__c == 'First Level Approver MTM'){
                    String strTest = '';
                    List<String> arrTest = new List<String>();
                    if(String.isNotBlank(usr.Area_MTM__c)){
                        // IF IS DEFINED AREA MTM
                        strTest = usr.Area_MTM__c;
                        arrTest = strTest.split(';');
                        orderedList = RestOrderedHandler.getOrdineSartoriaSolomeoArea(arrTest);
                    } else {
                        //  ELSE
                        List<Associated__c> associate = new List<Associated__c>();
                        associate = GenericDao.getAllFieldsListResultById('Associated__c', 'Id_Associate__c', usr.Codice_Associate__c);
                        Id associateId = associate[0].Id;
                        orderedList = RestOrderedHandler.getOrdineSartoriaSolomeoByAssociate(associateId);
                    }
                    
                    for (Ordine_Sartoria_Solomeo__c singleOrder : orderedList){
                        setAccountIds.add(singleOrder.Cliente__c);
                        setAssociateIds.add(singleOrder.Associate__c);
                    }
                    
                    List<Account> accountList =  Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccounts(setAccountIds);
                    List<Account_Misure_Sartoriali__c> misureList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccountsMisure(setAccountIds);
                    List<Associated__c> associateList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAssociate(setAssociateIds);
                    
                    result = getOrdine (orderedList, accountList , associateList ,  misureList );
                    
                } else If(usr.Nome_Profilo__c == 'Sarto'){
                    orderedList = RestOrderedHandler.getOrdineSartoriaSolomeoBySarto();
                    for (Ordine_Sartoria_Solomeo__c singleOrder : orderedList){
                        setAccountIds.add(singleOrder.Cliente__c);
                        setAssociateIds.add(singleOrder.Associate__c);
                    }
                    List<Account> accountList =  Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccounts(setAccountIds);
                    List<Account_Misure_Sartoriali__c> misureList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccountsMisure(setAccountIds);
                    List<Associated__c> associateList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAssociate(setAssociateIds);
                    system.debug('orderedList : ' +orderedList);
                    system.debug('accountList : ' +accountList);
                    system.debug('accountList : ' +misureList);
                    
                    result = getOrdine (orderedList, accountList , associateList ,  misureList );                    
                }
            } else If(userId != null){
                orderedList = RestOrderedHandler.getOrdineSartoriaSolomeoByAssociate(userId);
                
                for (Ordine_Sartoria_Solomeo__c singleOrder : orderedList){
                    setAccountIds.add(singleOrder.Cliente__c);
                    
                }
                List<Account> accountList =  Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccounts(setAccountIds);
                List<Account_Misure_Sartoriali__c> misureList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccountsMisure(setAccountIds);
                List<Associated__c> associateList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAssociate(userId);
                system.debug('orderedList : ' +orderedList);
                system.debug('accountList : ' +accountList);
                system.debug('misureList : ' +misureList);
                
                result = getOrdine (orderedList, accountList ,associateList ,  misureList );
                
            } else {
                orderedList = RestOrderedHandler.getOrdineSartoriaSolomeoBySarto();
                for (Ordine_Sartoria_Solomeo__c singleOrder : orderedList){
                    setAccountIds.add(singleOrder.Cliente__c);
                    setAssociateIds.add(singleOrder.Associate__c);
                }
                List<Account> accountList =  Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccounts(setAccountIds);
                List<Account_Misure_Sartoriali__c> misureList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccountsMisure(setAccountIds);
                List<Associated__c> associateList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAssociate(setAssociateIds);
                system.debug('orderedList : ' +orderedList);
                system.debug('accountList : ' +accountList);
                system.debug('accountList : ' +misureList);
                
                result = getOrdine (orderedList, accountList , associateList ,  misureList );
            }
            
            /*
            
            List<OrderResponseWrapper> orw = new List<OrderResponseWrapper>();
            List<Ordine_Sartoria_Solomeo__c> orderedList;
            Set<ID> setAccountIds = new Set<ID>();
            Set<ID> setAssociateIds = new Set<ID>();
            List<OrderResponseWrapper> result;
            if(associateId !=null){
                orderedList = RestOrderedHandler.getOrdineSartoriaSolomeoByAssociate(associateId);
                
                for (Ordine_Sartoria_Solomeo__c singleOrder : orderedList){
                    setAccountIds.add(singleOrder.Cliente__c);
                    
                }
                List<Account> accountList =  Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccounts(setAccountIds);
                List<Account_Misure_Sartoriali__c> misureList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccountsMisure(setAccountIds);
                List<Associated__c> associateList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAssociate(associateId);
                system.debug('orderedList : ' +orderedList);
                system.debug('accountList : ' +accountList);
                system.debug('misureList : ' +misureList);
                result = getOrdine (orderedList, accountList ,associateList ,  misureList );
            }else{
                orderedList = RestOrderedHandler.getOrdineSartoriaSolomeoBySarto();
                for (Ordine_Sartoria_Solomeo__c singleOrder : orderedList){
                    setAccountIds.add(singleOrder.Cliente__c);
                    setAssociateIds.add(singleOrder.Associate__c);
                }
                List<Account> accountList =  Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccounts(setAccountIds);
                List<Account_Misure_Sartoriali__c> misureList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAccountsMisure(setAccountIds);
                List<Associated__c> associateList = Rest_MTM_Ordered.getOrdineSartoriaSolomeoAssociate(setAssociateIds);
                system.debug('orderedList : ' +orderedList);
                system.debug('accountList : ' +accountList);
                system.debug('accountList : ' +misureList);
                result = getOrdine (orderedList, accountList , associateList ,  misureList );
            }
            */
            
            /* Map<String, Object> m = new Map<String, Object>();
for (Ordine_Sartoria_Solomeo__c singleOrder : orderedList){
m.put(singleOrder.Id, singleOrder); 
}*/
            
            
            
            return result;
            
        }
        
        public Override SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj){
            
            System.debug('beforeUpdate: ' + obj);
            SObject a = GenericDao.getAllFieldsResultById('Ordine_Sartoria_Solomeo__c', 'id', (String)obj.get('Id'));
            system.debug('customer: ' + a);
            
            if(a == null){
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Id');
            }
            
            return obj;
            
        }
        
        public Override ResponseWrapper afterUpdateResponse(RestRequest req,  RestResponse res, SObject obj){
            return null;
        }
        
        public Override SObject afterInsertUpdate(SObject obj){
            system.debug('afterInsertUpdate');
            System.debug('beforeUpdate: ' + obj);
            SObject a = GenericDao.getAllFieldsResultById('Ordine_Sartoria_Solomeo__c', 'id', (String)obj.get('Id'));
            
            
            return a;
        }
        
        public Override Boolean beforeInsert(SObject obj){
            return true;
        }
        
        public Override SObject afterInsert(SObject obj){
            return obj;
        }
        
        public Override String getObjectName(){
            return 'Ordine Sartoria Solomeo';
        }
        
        
    }
    
    global class OrderWrapper {
        
        @TestVisible  String step;
        @TestVisible  Ordine_Sartoria_Solomeo__c data;
        
        
    }
    
    
    public class CustomerMisureWrapper {
        
          Id Id;
          String Name;
          String Phone;
          String PersonEmail;
          String Id_Cliente_Relate;
          List<Account_Misure_Sartoriali__c> misure;  
        
    }
    public class AssociateWrapper {
        
          Id Id;
          String Name;
          String Location_Name;  
        
    }
    
    //MC- 2018.08.02
    public class AttachWrapper {
        string Id;
        string Name;
    }
    
    public class OrderResponseWrapper {
        
        Id id;
        Id OwnerId;
        Boolean IsDeleted;
        String Name;
        String CurrencyIsoCode;
        String Cliente;
        //String AssociateId;
        String Status;
        String Tessuto_Colore;
        String Capo;
        String Fodera;
        String Bottone;
        Boolean Completato;
        String Tessuto;
        String Descrizione_Tessuto;
        String Descrizione_Colore;
        String Area_MTM;
        Decimal Quantit;
        //String Cognome_Cliente;
        String Nome_Associate;
        String Cognome_Associate;
        DateTime LastModifiedDate;
        DateTime Data_approvazione_ordine_1_livello;
        DateTime Data_approvazione_ordine_2_livello;
        DateTime Data_consegna_a_cliente;
        DateTime Data_consegna_in_negozio;
        String Nota_approvatore_1_livello;
        String Nota_di_consegna_al_cliente;
        String Nota_negozio;
        String Nota_sarto;
        DateTime CreatedDate;
        Decimal Prezzo_number;
        String Prezzo_valuta;
        String Record_Type_Giacca;
               
        
        List<AttachWrapper> orderAttachments;
        CustomerMisureWrapper customer;  
        AssociateWrapper associate;
    }
   
    
    
}