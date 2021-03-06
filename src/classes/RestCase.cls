@RestResource(urlMapping='/Ticket_v1.0/*')
global without sharing class RestCase  {


    @HttpPost
    global static ResponseWrapper doPost(Case ticket) {
        return new RestCaseHandler().doPostHandler(ticket);
    }

  /*  
    @HttpGet
    global static ResponseWrapper doGet() {
        return new RestCaseHandler().doGetHandler(RestContext.request, RestContext.response);
    }

    @HttpPut
    global static ResponseWrapper doPatch(Case c) {
        return new RestCaseHandler().doPatchHandler(c);
    }

    */
    public static Case getCaseById(String id){
        return (Case)GenericDao.getAllFieldsResultById('Case', 'Id', id);
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
    

    public static SObject getMemberByExtId(String id){
        SObject a = (Account)GenericDao.getAllFieldsResultById('Account', 'Id_Cliente_DW__c', id);

        if(a == null){
            System.debug('Master not found. Searching for slave.');

            Sobject sd = GenericDao.getAllFieldsResultById('Slave_Data__c', 'Id_Cliente_DW__c', id);

            System.debug('Slave is ' + sd);

            return sd;
        }

        return a;
    }

    public static void copyCaseAccountField(Case c){
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

    public class RestCaseHandler extends ProvaHandler{
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
            Case c = (Case)obj;

            System.debug('CASE: ' + c);

            Sobject a = null;
            String idClient = null;
            RecordTypeSetting__c cs = RecordTypeSetting__c.getValues('General');
            String rtResoCambio = cs.Caso_ResoCambio__c;
            String rtResoCambioStore = cs.Caso_ResoCambioStore__c;
            String rtCustomerCare = cs.Caso_CustomerCare__c;
            String rtBrandSpecialist = cs.Caso_BrandSpecialist__c;
            String rtOMS = cs.Caso_OMS__c;

            Map<String, String> rtMap = new Map<String, String>();
            rtMap.put('ResoCambio', rtResoCambio);
            rtMap.put('ResoCambioStore', rtResoCambioStore);
            rtMap.put('CustomerCare', rtCustomerCare);
            rtMap.put('BrandSpecialist', rtBrandSpecialist);
            rtMap.put('OMS', rtOMS);

            String rtName = rtMap.get(c.Origine_Ticket__c);

            if(rtName == null){
                throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Origine_Ticket__c');
            }

            RestCase.copyCaseAccountField(c);

            if(c.Id_Cliente__c != null){
               a =  RestCase.getMemberByExtId(c.Id_Cliente__c);
            } 

            // TEN GROUP: Add condition for create account when Origine_Ticket__c is CustomerCare 
            //            and Taglia_non_presente__c false, for others Origine_Ticket__c create always the account
            if(a == null){
                if(c.Origine_Ticket__c == 'CustomerCare'){
                    if(!c.Taglia_non_presente__c){
                        a = GenericDao.insertAccountForCaseTask(c);
                    }
                } else {
                    a = GenericDao.insertAccountForCaseTask(c);
                    //throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Id_Cliente__c');
                }
            }

            if(a != null){
                system.debug('QUA');
                String objectType = a.getSobjectType().getDescribe().getName();

                // Gestione CLient ID
                if(objectType == 'Account'){
                    idClient = a.id;
                } else if (objectType == 'Slave_Data__c'){
                    idClient = (String)a.get('Account__c');
                }
            } else {
                obj.put('Alert_Dati_Ecommerce__c', true);
            }

            // Gestione Subject
            if(c.Origine_Ticket__c == 'ResoCambio' || 
                c.Origine_Ticket__c == 'ResoCambioStore'
                ){
                obj.put('Subject', ((c.Tipologia__c == 'E' ? 'Cambio - ' : 'Reso - ') + c.Motivazione_Reso_Cambio__c));
            }

            // Gestione LookUp Prodotto
            if(c.Origine_Ticket__c == 'BrandSpecialist'){
                obj.put('Subject', 'Brand Specialist Request');

                if(!String.isEmpty(c.Prodotto_Selezionato__c)){
                    List<Product__c> prodotti = [select id from Product__c where Item_ID__c = :c.Prodotto_Selezionato__c];

                    if(prodotti != null && !prodotti.isEmpty()){
                        obj.put('Prodotto__c', prodotti.get(0).id);
                    } else {
                        //SETALERT DATI ECOMMERCE YES
                        obj.put('Alert_Dati_Ecommerce__c', true);
                    }
                }
            }

            // Gestione LookUp Store
            if(c.id_Store__c != null){
                Location__c l = RestCase.getLocation(c.id_Store__c);
                System.debug('Location__c ' + l);

                if(l == null){
                    if(c.Origine_Ticket__c == 'ResoCambioStore'){
                        //SETALERT DATI ECOMMERCE YES
                        obj.put('Alert_Dati_Ecommerce__c', true);
                    }
                } else {
                    obj.put('Location__c', l.id);
                }
            }

            // Gestione LookUp Ordine
            if(c.id_ordine__c != null){
                Transaction__c tr = RestCase.getTransaction(c.id_ordine__c);

                if(tr == null){
                    if( c.Origine_Ticket__c == 'ResoCambio' || c.Origine_Ticket__c == 'ResoCambioStore' ||
                        c.Origine_Ticket__c == 'OMS'){
                        //SETALERT DATI ECOMMERCE YES
                        obj.put('Alert_Dati_Ecommerce__c', true);
                    }
                } else {
                    obj.put('Ordine__c', tr.id);
                }
            }

            // Gestione LookUp Reso
            if(c.id_reso__c != null){
                Transaction_Detail__c tr = RestCase.getTransactionDetail(c.id_reso__c);

                if(tr == null){
                    if(!String.isBlank(c.id_reso__c) && (c.Origine_Ticket__c == 'ResoCambio' || c.Origine_Ticket__c == 'ResoCambioStore' ||
                        c.Origine_Ticket__c == 'OMS')){
                        //SETALERT DATI ECOMMERCE
                        obj.put('Alert_Dati_Ecommerce__c', true);
                    }
                } else {
                    obj.put('Reso__c', tr.id);
                }
            }

            obj.put('AccountId', idClient);
            obj.put('RecordTypeId', rtName);

            System.debug('obj ' + obj);

            return true;
        }

        public Override SObject afterInsert(SObject obj){
            obj = RestCase.getCaseById(obj.id);

            return obj;
        }

        public Override String getObjectName(){
            return 'ticket';
        }
    }



}