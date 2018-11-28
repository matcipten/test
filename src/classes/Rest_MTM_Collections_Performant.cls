@RestResource(urlMapping='/MTM/V1/Collections_Performant/*')
global without sharing class Rest_MTM_Collections_Performant {
    
    @HttpGet
    global static ResponseWrapper doGet(){
        return new RestCollectionsHandler().doGetHandler(RestContext.request , RestContext.response);
    }
    
    public static CollectionWrapper getCollection(String recordId, List<RecordTypeMisureWrapper> recorTypeList, Map<Id,sObject> misureList, Map<Id,sObject> stagionelist, Map<Id,sObject> capilist, Map<Id,sObject> capoTessutolist, Map<Id,sObject> tessutolist, Map<Id,sObject> tessutoColorelist, Map<Id,sObject> tessutoColoreFoderalist, Map<Id,sObject> tessutoColoreBottonelist, Map<Id,sObject> foderaList, Map<Id,sObject> bottonelist){
        
        
        CollectionWrapper collection = new CollectionWrapper();
        collection.Misure = (List<Misure_di_Riferimento_Sartoria__c>)misureList.values();
        collection.RecordTypeMisure = recorTypeList;
        
        List<SeasonWrapper> finList = new List<SeasonWrapper>();
    
        /*system.debug('misureList size: '+misureList.size());
        system.debug('stagionelist size: '+stagionelist.size());
        system.debug('capilist size: '+capilist.size());
        system.debug('capoTessutolist size: '+capoTessutolist.size());
        system.debug('tessutolist size: '+tessutolist.size());
        system.debug('tessutoColorelist size: '+tessutoColorelist.size());
        system.debug('tessutoColoreFoderalist size: '+tessutoColoreFoderalist.size());
        system.debug('tessutoColoreBottonelist size: '+tessutoColoreBottonelist.size());
        system.debug('foderaList size: '+foderaList.size());
        system.debug('bottoneList size: '+bottoneList.size());*/
           
        for(sObject objStg : stagionelist.values()){
            
         
            Stagione__c stg = (Stagione__c) objStg;
            SeasonWrapper fin = new SeasonWrapper();
            fin.id = stg.Id;
            fin.Name = stg.Name;
            
            
            List<CapiWrapper> fin_capiList = new List<CapiWrapper>();
            //test 1 element
            //String first;
            //sObject temp = capiList.get(recordId);
           // capiList = new Map<Id,sObject>();
            //capiList.put((Id)recordId,temp);
            //end test 1 element
            
            for(sObject objCp : capiList.values()){
                 
                Capo__c cp = (Capo__c) objCp;
                if(cp.Stagione__c == stg.Id){
                    CapiWrapper capo = new CapiWrapper();
                    capo.Id = cp.Id;
                    capo.Name = cp.Name;
                    capo.Codice_Abito = cp.Codice_Abito__c;
                    capo.Codice_Giacca = cp.Codice_Giacca__c;
                    capo.Codice_Pantalone = cp.Codice_Pantalone__c;
                    capo.Descrizione_Modello_Giacca = cp.Descrizione_Modello_Giacca__c;
                    capo.Descrizione_Modello_Pantalone = cp.Descrizione_Modello_Pantalone__c;
                    capo.Modello_Giacca = cp.Modello_Giacca__c;
                    capo.Record_Type_Label = cp.Record_Type_Label__c;
                    capo.Stagione = cp.Stagione__c;
                    capo.Tipo_Filato = cp.Tipo_Filato__c;
                    capo.Tipologia_costruzione_MTM = cp.Tipologia_costruzione_MTM__c;
                    capo.Tipologia_MTM = cp.Tipologia_MTM__c;
                    capo.Tipologia_Pantalone = cp.Tipologia_Pantalone__c;
                    capo.Tipo_Giacca = cp.Tipo_Giacca__c;
                    capo.Posizione = cp.Posizione__c;
                    
                    Set<Id> tessutiPerCapo = new Set<Id>();
                    Map<Id,Capo_Tessuto__c> tessutiPerCapo2 = new Map<Id,Capo_Tessuto__c>();
                    
                    List<TessutiWrapper> fin_tessutoList = new List<TessutiWrapper>();
                    if(recordId != null && recordId != ''){
                        for(sObject objCtp: capoTessutolist.values()){
                            
                            Capo_Tessuto__c ctp = (Capo_Tessuto__c)objCtp;
                            if(ctp.Capo__c == capo.Id){
                                Tessuto__c ts = (Tessuto__c)tessutolist.get(ctp.Tessuto__c);
                                
                                TessutiWrapper tessuto = new TessutiWrapper();
                                String tempTessId = 'tessuto'+ts.Id;
                                // PN20181012 removed cache
                                /*if(ts.Id != null && Cache.Org.contains(tempTessId)){
                                        tessuto = (TessutiWrapper)Cache.Org.get(tempTessId);
                                        //PN 20181012 added some values
                                        tessuto.Prezzo_valuta = ctp.Prezzo_valuta__c;
                                        tessuto.Prezzo_number = ctp.Prezzo_number__c;
                                        //END PN 20181012 added some values
                                }
                                else{*/
                                // PN20181012 end removed cache
                                    
                                tessuto.Id = ts.Id;
                                tessuto.Name = ts.Name;
                                tessuto.Codice = ts.Codice__c;
                                tessuto.Descrizione_Tessuto = ts.Descrizione_Tessuto__c;
                                tessuto.Peso = ts.Peso__c;
                                tessuto.Tipologia_Tessuto = ts.Tipologia_Tessuto__c;    
                                tessuto.Prezzo_number = ctp.Prezzo_number__c;
                                tessuto.Prezzo_valuta = ctp.Prezzo_valuta__c;
                                tessuto.Id_CapoTessuto = ctp.Id;    
                                List<ColoriWrapper> fin_coloriList = new List<ColoriWrapper>();
                                
                                for(sObject objCol : tessutoColorelist.values()){
                                     
                                    Tessuto_Colore__c col = (Tessuto_Colore__c) objCol;
                                    if(col.tessuto__c == tessuto.Id){
                                        ColoriWrapper colore = new ColoriWrapper();
                                        colore.Id = col.Id;
                                        colore.Tessuto = col.Tessuto__c;
                                        colore.Name = col.Name;
                                        colore.Codice_Colore = col.Codice_Colore__c;
                                        colore.Descrizione_Colore = col.Descrizione_Colore__c;
                                        colore.Disponibilita_Magazzino_Reale_metri = col.Disponibilit_Magazzino_Reale_metri__c;
                                        
                                        Set<Id> bottoniStandard = new Set<Id>();
                                        Set<Id> fodereStandard = new Set<Id>();
                                        for(sObject ctb : tessutoColoreBottonelist.values()){
                                            if(ctb.get('Tessuto_Colore__c') == colore.Id){
                                                bottoniStandard.add((Id)ctb.get('Bottone__c'));
                                            }
                                        }
                                        for(sObject ctf : tessutoColoreFoderalist.values()){
                                            if(ctf.get('Tessuto_Colore__c') == colore.Id){
                                                fodereStandard.add((Id)ctf.get('Fodera__c'));
                                            }
                                        }
                                      
                                        List<FodereWrapper> fin_foderaList = new List<FodereWrapper>();
                                        for(sObject fd : Foderalist.values()){
                                            
                                            FodereWrapper fodera = new FodereWrapper();
                                            fodera.Id = fd.Id;
                                            fodera.Name = (String)fd.get('Name');
                                            fodera.Codice = (String)fd.get('Codice__c');
                                            fodera.Descrizione = (String)fd.get('Descrizione__c'); 
                                            if(fodereStandard.contains(fd.Id)){
                                                fodera.Consigliato = true; 
                                            } else {
                                                fodera.Consigliato = false; 
                                            }
                                            fin_foderaList.add(fodera);
                                        }
                                        
                                        List<BottoniWrapper> fin_bottoneList = new List<BottoniWrapper>();
                                        for(sObject bt : bottoneList.values()){
                                            
                                            BottoniWrapper bottone = new BottoniWrapper();
                                            bottone.Id = bt.Id;
                                            bottone.Name = (String)bt.get('Name');
                                            bottone.Codice = (String)bt.get('Codice__c');
                                            bottone.Descrizione = (String)bt.get('Descrizione__c'); 
                                            if(bottoniStandard.contains(bt.Id)){
                                                bottone.Consigliato = true; 
                                            } else {
                                                bottone.Consigliato = false; 
                                            }
                                            fin_bottoneList.add(bottone);
                                                
                                        }
                                        colore.Fodere = fin_foderaList;
                                        colore.Bottoni = fin_bottoneList;
                                        fin_coloriList.add(colore);
                                    }
                                // PN20181012 removed cache
                                //}
                                // PN20181012 end removed cache
                                tessuto.Colori = fin_coloriList;
                                // PN20181012 removed cache
                                /*if(ts.Id != null){
                                    Cache.Org.put(tempTessId,(TessutiWrapper)tessuto);
                                }*/
                                // PN20181012 end  cache
                                }
                                fin_tessutoList.add(tessuto);
                            }
                        }
                        capo.Tessuti = fin_tessutoList;
                    }
                    fin_capiList.add(capo);
                }
            }
            fin.capi = fin_capiList;
            finList.add(fin);
        }
        
        collection.Stagioni = finList;
        
        return collection;
        
    }
    
    public static Map<Id,sObject> getMisurediRiferimentoSartoria(Map<String, Schema.SObjectType> schemaMap){
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = Performant_GenericDAO.getAllFieldsListWithoutConditions(schemaMap,'Misure_di_Riferimento_Sartoria__c');
        return result;
        
    }
    
    public static Map<Id,sObject> getStagioni(Map<String, Schema.SObjectType> schemaMap){
        
        Map<Id,sObject> result =new Map<Id,Stagione__c>();
        result =  Performant_GenericDAO.getAllFieldsListResultById(schemaMap,'Stagione__c', 'Attiva__c', 'true');
        return result;
        
    }
    
    public static Map<Id,sObject> getCapo(Map<String, Schema.SObjectType> schemaMap,Set<ID> stagioniAttive){
        try{
            Map<Id,sObject> result = new Map<Id,Capo__c>();
            result = Performant_GenericDAO.getAllFieldsListWhereInConditionsWithNoLimits(schemaMap,'Capo__c', 'Stagione__c', stagioniAttive);
            return result;
        }
        catch(Exception e){
            return new Map<Id,sObject>();
        }
        
    }
    
    public static Map<Id,sObject> getCapo2(Map<String, Schema.SObjectType> schemaMap,Set<ID> capo){
        try{
            Map<Id,sObject> result = new Map<Id,Capo__c>();
            result = Performant_GenericDAO.getAllFieldsListWhereInConditionsWithNoLimits(schemaMap,'Capo__c', 'Id', capo);
            return result;
        }
        catch(Exception e){
            return new Map<Id,sObject>();
        }
        
    }
    
    public static Map<Id,sObject> getCapoTessuto(Map<String, Schema.SObjectType> schemaMap,Set<ID> capiDisponibili){
        Map<Id,sObject> result = new Map<Id,Capo_Tessuto__c>();
        result = Performant_GenericDAO.getAllFieldsListWhereInConditionsWithNoLimits(schemaMap,'Capo_Tessuto__c', 'Capo__c', capiDisponibili);
        system.debug('result : ' + result);
        return result;
        
    }
   
    
    public static Map<Id,sObject> getTessuto(Map<String, Schema.SObjectType> schemaMap,Set<ID> tessutiDisponibili){
        Map<Id,sObject> result = new Map<Id,Tessuto__c>();
        result = Performant_GenericDAO.getAllFieldsListWhereInConditionsWithNoLimits(schemaMap,'Tessuto__c', 'Id', tessutiDisponibili);
        return result;
        
    }
    
    public static Map<Id,sObject> getTessutoColore(Map<String, Schema.SObjectType> schemaMap,Set<ID> tessutoColoreDisponibili){
        
        Map<Id,sObject> result = new Map<Id,Tessuto_Colore__c>();
        result = Performant_GenericDAO.getAllFieldsListWhereInConditionsWithNoLimits(schemaMap,'Tessuto_Colore__c', 'Tessuto__c', tessutoColoreDisponibili);
        return result;
        
    }
    
    public static Map<Id,sObject> getTessutoColoreFoderaBottone(Map<String, Schema.SObjectType> schemaMap,String objApiName, Set<ID> tessutoColoreDisponibili){
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = (Map<Id,sObject>)Performant_GenericDAO.getAllFieldsListWhereInConditionsWithNoLimits(schemaMap,objApiName, 'Tessuto_Colore__c', tessutoColoreDisponibili);
        system.debug(result);        
        return result;
        
    }
    
    public static Map<Id,sObject> getFodera(Map<String, Schema.SObjectType> schemaMap,Set<ID> fodereDisponibili){
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = Performant_GenericDAO.getAllFieldsListWithoutConditions(schemaMap,'Fodera__c');
        system.debug(result);
        return result;
        
    }
    
    public static Map<Id,sObject> getBottone(Map<String, Schema.SObjectType> schemaMap,Set<ID> bottoniDisponibili){
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = Performant_GenericDAO.getAllFieldsListWithoutConditions(schemaMap, 'Bottone__c');
        
        
        system.debug('SV RESULT: ' + result);
        return result;
        
    }
    
    public class RestCollectionsHandler extends Rest_MTM_CalloutHandler{
        public override Object get(RestRequest req,  RestResponse res){
            String reqUri = req.requestURI.substring(1);
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            system.debug(JSON.serializePretty(arr));
            String service = arr[0];
            String version = arr[1];
            String objects = arr[2];
            String recordId = '';
            if(arr.size() > 3)
                recordId = arr[3];
            
            // PN20181012 removed cache
            /*if(recordId != null && recordId != '' && Cache.Org.contains(recordId)){
                system.debug('retrieved: '+recordId);
                return (CollectionWrapper)Cache.Org.get(recordId);
            }
            else if((recordId == null || recordId == '') && Cache.Org.contains('CollectionSchema')){
                system.debug('retrieved: CollectionSchema');
                return (CollectionWrapper)Cache.Org.get('CollectionSchema');
            }*/
            // END PN20181012 removed cache
            
            MTM__c mhc = MTM__c.getInstance();
          
            List<RecordTypeMisureWrapper> recordTypeList = new List<RecordTypeMisureWrapper>();
            RecordTypeMisureWrapper recordType = new RecordTypeMisureWrapper();
            recordType.Name = 'CapoMisure_Cliente_Giacca_1_5_petto';
            recordType.Id = mhc.Rec_Type_Misure_Cliente_Giacca_1_5_petto__c;
            recordTypeList.add(recordType);
            RecordTypeMisureWrapper recordType2 = new RecordTypeMisureWrapper();
            recordType2.Name = 'CapoMisure_Cliente_Giacca_1_petto';
            recordType2.Id = mhc.Rec_Type_Misure_Cliente_Giacca_1_petto__c;
            recordTypeList.add(recordType2);
            RecordTypeMisureWrapper recordType3 = new RecordTypeMisureWrapper();
            recordType3.Name = 'CapoMisure_Cliente_Pantalone';
            recordType3.Id = mhc.Rec_Type_Misure_Cliente_Pantalone__c;
            recordTypeList.add(recordType3);
            
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            
            Map<Id,sObject> misurediRiferimentoSartoriaList = RestCollectionsHandler.getMisurediRiferimentoSartoria(schemaMap);
            Map<Id,sObject> setStagioni = RestCollectionsHandler.getStagioni(schemaMap);
            
            Map<Id,sObject> setCapo = new Map<Id,sObject>();
            Set<Id> singleId = new Set<Id>();
            if(recordId != null && recordId != '' && recordId != 'ALL'){
                singleId.add(recordId);
                setCapo = RestCollectionsHandler.getCapo2(schemaMap,singleId);
            }
            else if(recordId == 'ALL'){
                setCapo = RestCollectionsHandler.getCapo(schemaMap,setStagioni.keySet());
            }
            else{
                setCapo = RestCollectionsHandler.getCapo(schemaMap,setStagioni.keySet());
            }
            
            Map<Id,sObject> setTessuto = new Map<Id,sObject>();
            Map<Id,sObject> temp = new Map<Id,sObject>();
            for(sObject cp : RestCollectionsHandler.getCapoTessuto(schemaMap,setCapo.keySet()).values()){
                setTessuto.put((Id)cp.get('Id'),cp);
                temp.put((Id)cp.get('Tessuto__c'),cp);
            }
            
            Map<Id,sObject> tessutolist = RestCollectionsHandler.getTessuto(schemaMap,temp.keySet());
            Map<Id,sObject> setTessutoColore = RestCollectionsHandler.getTessutoColore(schemaMap,temp.keySet());
            
            Map<Id,sObject> fodere = new Map<Id,sObject>();
            Map<Id,sObject> temp1 = new Map<Id,sObject>();
            Map<Id,sObject> temp2 = new Map<Id,sObject>();
            for(sObject f : RestCollectionsHandler.getTessutoColoreFoderaBottone(schemaMap,'Tessuto_Colore_Fodera__c', setTessutoColore.keySet()).values()){
                temp1.put((Id)f.get('Fodera__c'),f);
                fodere.put((Id)f.get('Id'),f);
            }
            
             Map<Id,sObject> bottoni = new Map<Id,sObject>();
            for(sObject b : RestCollectionsHandler.getTessutoColoreFoderaBottone(schemaMap,'Tessuto_Colore_Bottone__c', setTessutoColore.keySet()).values()){
                temp2.put((Id)b.get('Bottone__c'),b);
                bottoni.put((Id)b.get('Id'),b);
            }
            
            
            Map<Id,sObject> foderaList = RestCollectionsHandler.getFodera(schemaMap,temp1.keySet());
            Map<Id,sObject> bottonelist = RestCollectionsHandler.getBottone(schemaMap,temp2.keySet());
            
            
            /*
            Map<String, List<sObject>> m = new Map<String, List<sObject>>();
            m.put('Fodera', foderaList);
            m.put('TessutoColoreFodera', tessutoColoreFoderalist);
            m.put('Bottone', bottonelist);
            m.put('TessutoColoreBottone', tessutoColoreBottonelist);
            m.put('TessutoColore', tessutoColorelist);
            m.put('Tessuto', tessutolist);
            m.put('CapoTessuto', capoTessutolist);
            m.put('Capo', prodottoSartorialelist);
            m.put('Stagioni', stagionelist);
            m.put('Misure', misurediRiferimentoSartoriaList);
            */
            CollectionWrapper collections = getCollection(recordId,recordTypeList, misurediRiferimentoSartoriaList, setstagioni, setCapo, setTessuto, tessutolist, setTessutoColore, fodere, bottoni, foderaList, bottonelist);
            // PN20181012 removed cache
            /*if(recordId != null && recordId != ''){
                system.debug('cached: '+recordId);
                Cache.Org.put(recordId,collections);
            }
            else{ 
                system.debug('cached: CollectionSchema');
                Cache.Org.put('CollectionSchema',collections);
            }*/
            // END PN20181012 removed cache
            return collections;
            
        }
        
        public Override SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj){
            return obj;
            
        }
        
        public Override ResponseWrapper afterUpdateResponse(RestRequest req,  RestResponse res, SObject obj){
            return null;
        }
        
        public Override Boolean beforeInsert(SObject obj){
            return true;
        }
        
        public Override SObject afterInsert(SObject obj){
            return obj;
        }
        
        public Override SObject afterInsertUpdate(SObject obj){
            return obj;
        }
        
        public Override String getObjectName(){
            return 'Collections';
        }
    }
    
    public class BottoniWrapper {
        
        Id Id;
        String Name;
        String Codice;
        String Descrizione;
        Boolean Consigliato;

    }
    
    public class FodereWrapper {
        
        Id Id;
        String Name;
        String Codice;
        String Descrizione;
        Boolean Consigliato;

    }
    
    public class ColoriWrapper {
        
        Id Id;
        String Name;
        String Codice_Colore;
        String  Descrizione_Colore;
        String  Tessuto;
        Decimal Disponibilita_Magazzino_Reale_metri;
        List<FodereWrapper> Fodere;
        List<BottoniWrapper> Bottoni;
    }
    
    public class TessutiWrapper {
        
        Id Id;
        String Name;
        String Codice;
        String Descrizione_Tessuto;
        String Peso;
        String Tipologia_Tessuto;
        Decimal Prezzo_number;
        String Prezzo_valuta;
        Id Id_CapoTessuto;
        List<ColoriWrapper> Colori;
        
    }
    
    public class CapiWrapper {
        
        Id Id;
        String Name;
        String Codice_Abito;
        String Codice_Giacca;
        String Codice_Pantalone;
        String Descrizione_Modello_Giacca;
        String Descrizione_Modello_Pantalone;
        String Modello_Giacca;
        String Record_Type_Label;
        String Stagione;
        String Tipo_Filato;
        String Tipologia_costruzione_MTM;
        String Tipologia_MTM;
        String Tipologia_Pantalone;
        String Tipo_Giacca;
        Decimal Posizione;
        List<TessutiWrapper> Tessuti;
        
    }
    
    public class SeasonWrapper {
        
        Id Id;
        String Name;
        List<CapiWrapper> Capi;
        
    }
    
    public class RecordTypeMisureWrapper {
        
        Id Id;
        String Name;
        
    }
    
    public class CollectionWrapper {
        
        List<RecordTypeMisureWrapper> RecordTypeMisure;
        List<Misure_di_Riferimento_Sartoria__c> Misure;
        List<SeasonWrapper> Stagioni;
        
    }
    
    /*public static Map<Id,sObject> getChild(String idObj,  List<String> childList){
        
        Map<Id,sObject> resultChild = new Map<Id,sObject>();
        
        if(childList != null){
            for(String child : childList){
                resultChild = Performant_GenericDAO.getAllFieldsListResultById(child, 'Stagione__c', idObj);
            }
        }
        
        return resultChild;
    }*/

}