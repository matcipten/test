@RestResource(urlMapping='/Task_v1.0/*')
global without sharing class RestTask  {


    @HttpPost
    global static ResponseWrapper doPost(Task attivita) {
        return new RestTaskHandler().doPostHandler(attivita);
    }

 /* 
    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestCaseHandler().doGetHandler(RestContext.request, RestContext.response);
    }
  */  

 /* 
    @HttpPut
    global static ResponseWrapper doPatch(Case c) {
        return new RestCaseHandler().doPatchHandler(c);
    }
  */  

    public static SObject getMemberByExtIdAS400(String id){
        SObject a = (Account)GenericDao.getAllFieldsResultById('Account', 'Id_Cliente_DW__c', id);

        if(a == null){
            System.debug('Master not found. Searching for slave.');

            Sobject sd = GenericDao.getAllFieldsResultById('Slave_Data__c', 'Id_Cliente_DW__c', id);

            System.debug('Slave is ' + sd);

            return sd;
        }

        return a;
    }

    public static void copyTaskAccountField(Task c){
        c.Titolo_Cliente_Input__c = c.Titolo_Cliente__c;
        c.Nome_Cliente_Input__c = c.Nome_Cliente__c;
        c.Cognome_Cliente_Input__c = c.Cognome_Cliente__c;
        c.Sesso_Input__c = c.Sesso__c;
        c.Email_Cliente_Input__c = c.Email_Cliente__c;
        c.Telefono_Input__c = c.Telefono__c;
        c.Nazione_Input__c = c.Nazione__c;
        c.Citta_Input__c = c.Citta__c;
        c.Lingua_di_Preferenza_Input__c = c.Lingua_di_Preferenza__c;
    }

    public static Location__c getLocation(String id){
        return (Location__c)GenericDao.getAllFieldsResultById('Location__c', 'Id_Location_Micros__c', id);
    }

    public static Transaction__c getTransaction(String name){
        return (Transaction__c)GenericDao.getAllFieldsResultById('Transaction__c', 'Name', name);
    }


    public static Transaction_Detail__c getTransactionDetail(String name){
        return (Transaction_Detail__c)GenericDao.getAllFieldsResultById('Transaction_Detail__c', 'Name', name);
    }

    public static Task getTaskById(String id){
        return (Task)GenericDao.getAllFieldsResultById('Task', 'Id', id);
    }


    public class RestTaskHandler extends ProvaHandler{
        public Override Object get(RestRequest req,  RestResponse res){
            return null;
        }

        public Override SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj){
            return obj;
        }

        public Override ResponseWrapper afterUpdateResponse(RestRequest req,  RestResponse res, SObject obj){
            return null;
        }

        public Override Boolean beforeInsert(SObject obj){
            Task t = (Task)obj;

            System.debug('obj:' + obj);
            
            Sobject a = null;
            String idClient = null;
            String ownerId = null;
            String idStore = t.id_store__c;

            RecordTypeSetting__c cs = RecordTypeSetting__c.getValues('General');
            String rtResoCambioStore = cs.Task_ResoCambioStore__c;
            String rtWishlist = cs.Task_Wishlist__c;

            Map<String, String> rtMap = new Map<String, String>();
            rtMap.put('Wishlist', rtWishlist);
            rtMap.put('ResoCambioStore', rtResoCambioStore);

            String rtName = rtMap.get(t.Origine_Task__c);

            if(rtName == null){
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Origine_Task__c');
            }

            if(idStore == null){
                obj.put('Alert_Dati_Ecommerce__c', true);
                //throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - id_store__c');
            } else {
                User u = GenericDao.getUserByCodiceBuotique(idStore);

                System.debug('u:' + u);

                if(u == null){
                    obj.put('Alert_Dati_Ecommerce__c', true);
                    //throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_VALID + ' - id_store__c');
                } else {
                    ownerId = u.id;
                }

                Location__c l = RestCase.getLocation(idStore);
                System.debug('Location__c ' + l);

                if(l == null){
                    //SETALERT DATI ECOMMERCE YES
                    obj.put('Alert_Dati_Ecommerce__c', true);
                    //throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - id_Store__c');
                } else {
                    obj.put('Location__c', l.id);
                }
            }         

            RestTask.copyTaskAccountField(t);

            if(t.Id_Cliente__c != null){
               a =  RestTask.getMemberByExtIdAS400(t.Id_Cliente__c);
            }  

            if(a == null){
                a = GenericDao.insertAccountForCaseTask(t);
                //throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Id_Cliente__c');
            }

            if(a != null){
                String objectType = a.getSobjectType().getDescribe().getName();

                if(objectType == 'Account'){
                    idClient = a.id;
                } else if (objectType == 'Slave_Data__c'){
                    idClient = (String)a.get('Account__c');
                }
            } else {
                obj.put('Alert_Dati_Ecommerce__c', true);
            }

            if(t.id_ordine__c != null){
                Transaction__c tr = RestTask.getTransaction(t.id_ordine__c);

                if(tr == null){
                    //SETALERT DATI ECOMMERCE YES
                    obj.put('Alert_Dati_Ecommerce__c', true);
                    //throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - id_ordine__c');
                } else {
                    obj.put('Ordine__c', tr.id);
                }
            }

            if(t.id_reso__c != null){
                Transaction_Detail__c tr = RestTask.getTransactionDetail(t.id_reso__c);

                if(tr == null){
                    //SETALERT DATI ECOMMERCE YES
                    obj.put('Alert_Dati_Ecommerce__c', true);
                    //throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - id_reso__c');
                } else {
                    obj.put('Reso__c', tr.id);
                }
            }

            if(ownerId != null){
                obj.put('OwnerId', ownerId);
            } 

            obj.put('WhatId', idClient);
            obj.put('Account__c', idClient);
            obj.put('RecordTypeId', rtName);
            obj.put('ActivityDate', System.today());

            System.debug('obj ' + obj);

            return true;
        }

        public Override SObject afterInsert(SObject obj){
            Task t = (Task)obj;
            
            if(t.WhatId != null && t.Origine_Task__c == 'Wishlist'){
                //Crea wishlist e prodotti collegati
                String jsonProdotti = t.scheda_prodotto__c;
                Type listType = Type.forName('List<RestTask.ProductWrapper>');
                List<String> skuList = new List<String>();
                Map<String, Integer> skuQtyMap = new Map<String, Integer>();

                System.debug('jsonProdotti ' + jsonProdotti);

                List<ProductWrapper> prodotti = (List<ProductWrapper>)JSON.deserialize(jsonProdotti, listType);

                for(ProductWrapper pw : prodotti){
                    skuList.add(pw.prodotto);
                    skuQtyMap.put(pw.prodotto, pw.quantita);
                }

                System.debug('prodotti ' + prodotti);

                if(prodotti != null && !prodotti.isEmpty()){
                    List<Dettaglio_Wishlist__c> dettagli2Insert = new List<Dettaglio_Wishlist__c>();

                    WishList__c wl = new Wishlist__c(); 
                    wl.Cliente__c = t.WhatId;
                    wl.Data_inserimento__c = System.today();

                    insert wl;
                    
                    System.debug('Wishlist ' + wl);

                    t.Wishlist__c = wl.id;
                    update t;

                    for(Product__c prodotto : [select id, Item_ID__c from Product__c where Item_ID__c in :skuList]){
                        dettagli2Insert.add(new Dettaglio_Wishlist__c(
                            Prodotto__c = prodotto.id,
                            Wishlist__c = wl.id,
                            Quantita__c = skuQtyMap.get(prodotto.Item_ID__c)
                        ));
                    }

                    System.debug('dettagli2Insert ' + dettagli2Insert);

                    if(!dettagli2Insert.isEmpty()){
                        insert dettagli2Insert;
                    }
                }
            }

             obj = RestTask.getTaskById(obj.id);

            return obj;
        }

        public Override String getObjectName(){
            return 'attivita';
        }
    }


    public class ProductWrapper{
        public String prodotto{get;set;}
        public Integer quantita{get;set;}

        public ProductWrapper(String p, Integer q){
            prodotto = p;
            quantita = q;
        }
    }
}