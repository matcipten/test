@RestResource(urlMapping='/MTM/V1/Collections/*')
global without sharing class Rest_MTM_Collections {
    
    @HttpGet
    global static ResponseWrapper doGet(){
        return new RestCollectionsHandler().doGetHandler(RestContext.request , RestContext.response);
    }
    
    public static CollectionWrapper getCollection(List<RecordTypeMisureWrapper> recorTypeList, List<Misure_di_Riferimento_Sartoria__c> misureList, List<Stagione__c> stagionelist, List<Capo__c> capilist, List<Capo_Tessuto__c> capoTessutolist, List<Tessuto__c> tessutolist, List<Tessuto_Colore__c> tessutoColorelist, List<sObject> tessutoColoreFoderalist, List<sObject> tessutoColoreBottonelist, List<Fodera__c> foderaList, List<Bottone__c> bottonelist){
        
        CollectionWrapper collection = new CollectionWrapper();
        collection.Misure = misureList;
        collection.RecordTypeMisure = recorTypeList;
        
        List<SeasonWrapper> finList = new List<SeasonWrapper>();
                
        for(Stagione__c stg : stagionelist){
            SeasonWrapper fin = new SeasonWrapper();
            fin.id = stg.Id;
            fin.Name = stg.Name;
            
            List<CapiWrapper> fin_capiList = new List<CapiWrapper>();
            for(Capo__c cp : capiList){
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
                    
                    Set<Id> tessutiPerCapo = new Set<Id>();
                    for(Capo_Tessuto__c ctp : capoTessutolist){
                        if(ctp.Capo__c == capo.Id){
                            tessutiPerCapo.add(ctp.Tessuto__c);
                        }
                    }
                    List<TessutiWrapper> fin_tessutoList = new List<TessutiWrapper>();
                    for(Tessuto__c ts : tessutolist){
                        if(tessutiPerCapo.contains(ts.Id)){
                            
                            TessutiWrapper tessuto = new TessutiWrapper();
                            tessuto.Id = ts.Id;
                            tessuto.Name = ts.Name;
                            tessuto.Codice = ts.Codice__c;
                            tessuto.Descrizione_Tessuto = ts.Descrizione_Tessuto__c;
                            tessuto.Peso = ts.Peso__c;
                            tessuto.Tipologia_Tessuto = ts.Tipologia_Tessuto__c;                            
                            List<ColoriWrapper> fin_coloriList = new List<ColoriWrapper>();
                            for(Tessuto_Colore__c col : tessutoColorelist){
                                if(col.tessuto__c == tessuto.Id){
                                    ColoriWrapper colore = new ColoriWrapper();
                                    colore.Id = col.Id;
                                    colore.Tessuto = col.Tessuto__c;
                                    colore.Name = col.Name;
                                    colore.Codice_Colore = col.Codice_Colore__c;
                                    colore.Descrizione_Colore = col.Descrizione_Colore__c;
                                    Set<Id> setFodere = new Set<Id>();
                                    Set<Id> setBottoni = new Set<Id>();
                                    system.debug('tessutoColoreFoderalist : ' +tessutoColoreFoderalist);
                                    for(sObject ctf : tessutoColoreFoderalist){
                                        if(ctf.get('Tessuto_Colore__c') == colore.Id){
                                            setFodere.add((Id)ctf.get('Fodera__c'));
                                        }
                                    }
                                    for(sObject ctb : tessutoColoreBottonelist){
                                        if(ctb.get('Tessuto_Colore__c') == colore.Id){
                                            setBottoni.add((Id)ctb.get('Bottone__c'));
                                        }
                                    }
                                    List<FodereWrapper> fin_foderaList = new List<FodereWrapper>();
                                    for(Fodera__c fd : foderaList){
                                        if(setFodere.contains(fd.Id)){
                                            FodereWrapper fodera = new FodereWrapper();
                                            fodera.Id = fd.Id;
                                            fodera.Name = fd.Name;
                                            fodera.Codice = fd.Codice__c;
                                            fodera.Descrizione = fd.Descrizione__c; 
                                            fin_foderaList.add(fodera);
                                        }
                                    }
                                    List<BottoniWrapper> fin_bottoneList = new List<BottoniWrapper>();
                                    for(Bottone__c bt : bottoneList){
                                        system.debug('bt Bottne : ' + bt);
                                        if(setBottoni.contains(bt.Id)){
                                            BottoniWrapper bottone = new BottoniWrapper();
                                            bottone.Id = bt.Id;
                                            bottone.Name = bt.Name;
                                            bottone.Codice = bt.Codice__c;
                                            bottone.Descrizione = bt.Descrizione__c; 
                                            fin_bottoneList.add(bottone);
                                        }
                                    }
                                    colore.Fodere = fin_foderaList;
                                    colore.Bottoni = fin_bottoneList;
                                    fin_coloriList.add(colore);
                                }
                            }
                            tessuto.Colori = fin_coloriList;
                            fin_tessutoList.add(tessuto);
                        }
                    }
                    capo.Tessuti = fin_tessutoList;
                    fin_capiList.add(capo);
                }
            }
            fin.capi = fin_capiList;
            finList.add(fin);
        }
        
        collection.Stagioni = finList;
        
        return collection;
        
    }
    
    public static List<Misure_di_Riferimento_Sartoria__c> getMisurediRiferimentoSartoria(){
        
        List<Misure_di_Riferimento_Sartoria__c> result = new List<Misure_di_Riferimento_Sartoria__c>();
        result = GenericDao.getAllFieldsListWithoutConditions('Misure_di_Riferimento_Sartoria__c');
        return result;
        
    }
    
    public static List<Stagione__c> getStagioni(){
        
        List<Stagione__c> result = new List<Stagione__c>();
        result = GenericDao.getAllFieldsListResultById('Stagione__c', 'Attiva__c', 'true');
        return result;
        
    }
    
    public static List<Capo__c> getCapo(Set<ID> stagioniAttive){
        
        List<Capo__c> result = new List<Capo__c>();
        result = GenericDao.getAllFieldsListWhereInConditions('Capo__c', 'Stagione__c', stagioniAttive);
        return result;
        
    }
    
    public static List<Capo_Tessuto__c> getCapoTessuto(Set<ID> capiDisponibili){
        
        List<Capo_Tessuto__c> result = new List<Capo_Tessuto__c>();
        result = GenericDao.getAllFieldsListWhereInConditions('Capo_Tessuto__c', 'Capo__c', capiDisponibili);
        
        return result;
        
    }
    
    public static List<Tessuto__c> getTessuto(Set<ID> tessutiDisponibili){
        
        List<Tessuto__c> result = new List<Tessuto__c>();
        result = GenericDao.getAllFieldsListWhereInConditions('Tessuto__c', 'Id', tessutiDisponibili);
        return result;
        
    }
    
    public static List<Tessuto_Colore__c> getTessutoColore(Set<ID> tessutoColoreDisponibili){
        
        List<Tessuto_Colore__c> result = new List<Tessuto_Colore__c>();
        result = GenericDao.getAllFieldsListWhereInConditions('Tessuto_Colore__c', 'Tessuto__c', tessutoColoreDisponibili);
        
        return result;
        
    }
    
    public static List<sObject> getTessutoColoreFoderaBottone(String objApiName, Set<ID> tessutoColoreDisponibili){
        
        List<sObject> result = new List<sObject>();
        result = GenericDao.getAllFieldsListWhereInConditions(objApiName, 'Tessuto_Colore__c', tessutoColoreDisponibili);
        
        return result;
        
    }
    
    public static List<Fodera__c> getFodera(Set<ID> fodereDisponibili){
        
        List<Fodera__c> result = new List<Fodera__c>();
        result = GenericDao.getAllFieldsListWhereInConditions('Fodera__c', 'Id', fodereDisponibili);
        return result;
        
    }
    
    public static List<Bottone__c> getBottone(Set<ID> bottoniDisponibili){
        
        List<Bottone__c> result = new List<Bottone__c>();
        result = GenericDao.getAllFieldsListWhereInConditions('Bottone__c', 'Id', bottoniDisponibili);
        system.debug('result Bottne : ' + result);
        return result;
        
    }
    
    public class RestCollectionsHandler extends Rest_MTM_CalloutHandler{
        public override Object get(RestRequest req,  RestResponse res){
            system.Debug('Insidie RestCollectionsHandler ');
            String reqUri = req.requestURI.substring(1);
            String[] arr = reqUri.split('\\/');
            Integer arrSize = arr.size();
            String service = arr[0];
            String version = arr[1];
            String objects = arr[2];
            
            MTM__c mhc = MTM__c.getInstance();
            System.debug('MTM__c: ' + mhc);
          
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
            
            
            
            List<Misure_di_Riferimento_Sartoria__c> misurediRiferimentoSartoriaList = RestCollectionsHandler.getMisurediRiferimentoSartoria();
            List<Stagione__c> stagionelist = RestCollectionsHandler.getStagioni();
            
            Set<ID> setStagioni = new Set<ID>();
            for(Stagione__c stg : stagionelist){
                setStagioni.add(stg.Id);
            }
            List<Capo__c> prodottoSartorialelist = RestCollectionsHandler.getCapo(setStagioni);
            Set<ID> setCapo = new Set<ID>();
            for(Capo__c cp : prodottoSartorialelist){
                setCapo.add(cp.Id);
            }
            List<Capo_Tessuto__c> capoTessutolist = RestCollectionsHandler.getCapoTessuto(setCapo);
            Set<ID> setTessuto = new Set<ID>();
            for(Capo_Tessuto__c cp : capoTessutolist){
                setTessuto.add(cp.Tessuto__c);
            }
            
            List<Tessuto__c> tessutolist = RestCollectionsHandler.getTessuto(setTessuto);
            List<Tessuto_Colore__c> tessutoColorelist = RestCollectionsHandler.getTessutoColore(setTessuto);
            Set<ID> setTessutoColore = new Set<ID>();
            for(Tessuto_Colore__c tsc : tessutoColorelist){
                setTessutoColore.add(tsc.Id);
            }
            List<sObject> tessutoColoreFoderalist = RestCollectionsHandler.getTessutoColoreFoderaBottone('Tessuto_Colore_Fodera__c', setTessutoColore);
            List<sObject> tessutoColoreBottonelist = RestCollectionsHandler.getTessutoColoreFoderaBottone('Tessuto_Colore_Bottone__c', setTessutoColore);
            Set<ID> fodere = new Set<ID>();
            Set<ID> bottoni = new Set<ID>();
            for(sObject tsc : tessutoColoreFoderalist){
                fodere.add((String)tsc.get('Fodera__c'));
            }
            for(sObject tsc : tessutoColoreBottonelist){
                bottoni.add((String)tsc.get('Bottone__c'));
            }
            List<Fodera__c> foderaList = RestCollectionsHandler.getFodera(fodere);
            List<Bottone__c> bottonelist = RestCollectionsHandler.getBottone(bottoni);
            
            
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
            CollectionWrapper collections = getCollection(recordTypeList, misurediRiferimentoSartoriaList, stagionelist, prodottoSartorialelist, capoTessutolist, tessutolist, tessutoColorelist, tessutoColoreFoderalist, tessutoColoreBottonelist, foderaList, bottonelist);

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
        
    }
    
    public class FodereWrapper {
        
        Id Id;
        String Name;
        String Codice;
        String Descrizione;
    }
    
    public class ColoriWrapper {
        
        Id Id;
        String Name;
        String Codice_Colore;
        String  Descrizione_Colore;
        String  Tessuto;
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
    
    public static List<sObject> getChild(String idObj,  List<String> childList){
        
        List<sObject> resultChild = new List<sObject>();
        
        if(childList != null){
            for(String child : childList){
                resultChild = GenericDao.getAllFieldsListResultById(child, 'Stagione__c', idObj);
            }
        }
        
        return resultChild;
    }

}