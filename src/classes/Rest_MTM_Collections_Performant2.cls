@RestResource(urlMapping='/MTM/V2/Collections/*')
global without sharing class Rest_MTM_Collections_Performant2 {
    
    @HttpGet
    global static ResponseWrapper doGet(){
        return new RestCollectionsHandler().doGetHandler(RestContext.request , RestContext.response);
    }
    
    
    
    
    
    public static MetaWrapper getCollectionFirstStep(Map<String, Schema.SObjectType> schemaMap){
        
        MetaWrapper collection = new MetaWrapper();
        if(Cache.Org.get('1Collection') != null){
            collection = (MetaWrapper)Cache.Org.get('1Collection');
            
        }else{
            
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
            
            
            
            Map<Id,sObject> misurediRiferimentoSartoriaList = RestCollectionsHandler.getMisurediRiferimentoSartoria(schemaMap);
            
            
            
            collection.Misure = (List<Misure_di_Riferimento_Sartoria__c>)misurediRiferimentoSartoriaList.values();
            collection.RecordTypeMisure = recordTypeList;
            
            
            //Akshay
            
            
            Map<String, Schema.RecordTypeInfo> recordTypes = Schema.SObjectType.Capo__c.getRecordTypeInfosByDeveloperName();
            system.debug('recordTypes : ' +recordTypes.size());
            system.debug('recordTypes : ' +recordTypes);
            
            
            Map<String,String> CapoRecordType =  new Map<String,String>();
            
            for(String rt : recordTypes.keySet()){
                CapoRecordType.put(rt, String.valueOf(recordTypes.get(rt).RecordTypeId).substring(0,15));
            }
            
            
            Map<String,String> pickListValuesListFinal = new Map<String,String>();
            List<String> pickListValuesList= new List<String>();
            Schema.DescribeFieldResult fieldResult = Capo__c.Categoria__c.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : ple){
                
                pickListValuesListFinal.put(pickListVal.getValue() , pickListVal.getLabel());
            }
            
            
            TipoDiCapoWrapper tcw =  new TipoDiCapoWrapper(); 
            tcw.RecordTypeCapo  = CapoRecordType;
            tcw.CategoryCapo  = pickListValuesListFinal;
            
            collection.TipoDiCapo = tcw;
            
            if(collection != null){
                Cache.Org.put('1Collection',collection);
            }
        }
        return collection;
        
    }
    public static CollectionWrapper getCollectionSecondStep(String recordTypeId, String categoria, Map<String, Schema.SObjectType> schemaMap){
        system.debug('getCollectionSecondStep');
        CollectionWrapper collectionWrap =  new CollectionWrapper();

        String orgCurr = UserInfo.getDefaultCurrency();
        String orgLang = UserInfo.getLocale();
        
        
        orgLang = orgLang.replaceAll('[^a-zA-Z0-9]','');

        String categoriaCache =  categoria.replaceAll('[^a-zA-Z0-9]','');
        
		system.debug('1');

        //if(Cache.Org.get( (orgLang != null ? orgLang : '')+(orgCurr != null ? orgCurr : '')+(recordTypeId != null ? recordTypeId : '')+(categoriaCache != null ? categoriaCache : '')) != null){
			system.debug('2');
            //collectionWrap = (CollectionWrapper)Cache.Org.get( (orgLang != null ? orgLang : '')+(orgCurr != null ? orgCurr : '')+(recordTypeId != null ? recordTypeId : '')+(categoriaCache != null ? categoriaCache : ''));
        //}else{
            Set<Id> tessutoColoreIds = new Set<Id>();
            Set<String> types = new Set<String>();
            Set<String> categorie = new Set<String>();
            system.debug('3');
            if(recordTypeId != null && recordTypeId != ''){
                types.add(recordTypeId);
            }
            else
                types = null;
            
            if(categoria != null && categoria != ''){
                categorie.add(categoria);
            }
            else
                categorie = null;
            
            collectionWrap.CapiTessuti = getCapoTessutiFiltered(types,categorie,schemaMap);
                    
            for(SObject tessuto : collectionWrap.CapiTessuti.values()){
                tessutoColoreIds.add((Id)tessuto.get('Tessuto__c'));
            }
            
            
            if(tessutoColoreIds.size() > 0 ){
                collectionWrap.TessutoColore = getTessutiFiltered(tessutoColoreIds,schemaMap);
            }
            
            system.debug(collectionWrap);
           /* if(collectionWrap != null){
                Cache.Org.put( (orgLang != null ? orgLang : '')+(orgCurr != null ? orgCurr : '')+(recordTypeId != null ? recordTypeId : '')+(categoriaCache != null ? categoriaCache : ''),collectionWrap );
            }*/

        //}
        
        
        return collectionWrap;
        
    }
    public static CollectionFoderaButtoneWrapper getCollectionThirdStep(String tessutoColoreId ,String stagioneId, Map<String, Schema.SObjectType> schemaMap ){
        
        String orgCurr = UserInfo.getDefaultCurrency();
        String orgLang = UserInfo.getLocale();
        CollectionFoderaButtoneWrapper result = new CollectionFoderaButtoneWrapper();
        //MTM_Always_Suggested__mdt
        
        orgLang = orgLang.replaceAll('[^a-zA-Z0-9]','');


        //if(Cache.Org.get( (orgLang != null ? orgLang : '')+(orgCurr != null ? orgCurr : '')+(tessutoColoreId != null ? tessutoColoreId : '')+(stagioneId != null ? stagioneId : '')) != null){

          //  result = (CollectionFoderaButtoneWrapper)Cache.Org.get( (orgLang != null ? orgLang : '')+(orgCurr != null ? orgCurr : '')+(tessutoColoreId != null ? tessutoColoreId : '')+(stagioneId != null ? stagioneId : ''));
        //}else{
        
        MTM_Always_Suggested__mdt[] mtmAlwaysSuggestedList =[SELECT Id,DeveloperName ,Bottone__c, Fodera__c   
                                                        FROM MTM_Always_Suggested__mdt
                                                        WHERE DeveloperName = :stagioneId];
        
         Map<Id,sObject> availableButtone = new  Map<Id,sObject>();
         Map<Id,sObject> availableFodera = new Map<Id,sObject> ();
        if( mtmAlwaysSuggestedList.size() > 0  ){
            MTM_Always_Suggested__mdt mtmAlwaysSuggested = mtmAlwaysSuggestedList[0];
            if(!mtmAlwaysSuggested.Bottone__c && mtmAlwaysSuggested.Fodera__c){
                availableButtone = getBottone(schemaMap , tessutoColoreId);
            }
            if(!mtmAlwaysSuggested.Fodera__c && mtmAlwaysSuggested.Bottone__c){
                availableFodera = getFodera(schemaMap , tessutoColoreId);
            }
            if(!mtmAlwaysSuggested.Fodera__c && !mtmAlwaysSuggested.Bottone__c){
                availableButtone = getBottone(schemaMap , tessutoColoreId);
                availableFodera = getFodera(schemaMap , tessutoColoreId);
            }

        }else{
            availableButtone = getBottone(schemaMap , tessutoColoreId);
            availableFodera = getFodera(schemaMap , tessutoColoreId);
        

        }
        
        
        
        Map<Id,sObject> allBottone = queryAllBottone(schemaMap );
        Map<Id,sObject> allFodera = queryAllFodera(schemaMap );
        
        
        
        Map<String,Object> availableFoderaMap =  new  Map<String,Object>();
        Map<String,Object> availableButtoneMap =  new  Map<String,Object>();
        system.debug('Akshay :' + allBottone.values().size());
        
        for(sObject obj : allBottone.values()){
            Map<String,Object> objMap = new Map<String,Object>();
            objMap.putAll(obj.getPopulatedFieldsAsMap());
            if(availableButtone.containsKey((Id)objMap.get('Id'))){
                objMap.put('Consigliato',true);
            }
            if(mtmAlwaysSuggestedList.size() > 0 && mtmAlwaysSuggestedList[0].Bottone__c){
                objMap.put('Consigliato',true);
            }
             if(objMap.get('Consigliato') == null ){
                 objMap.put('Consigliato',false);
            }
            availableButtoneMap.put((String)objMap.get('Name') , objMap);
        }
        
        for(sObject obj : allFodera.values()){
            Map<String,Object> objMap = new Map<String,Object>();
            objMap.putAll(obj.getPopulatedFieldsAsMap());
            if(availableFodera.containsKey((Id)objMap.get('Id'))){
                objMap.put('Consigliato',true);
            }
            if(mtmAlwaysSuggestedList.size() > 0 && mtmAlwaysSuggestedList[0].Fodera__c){
                objMap.put('Consigliato',true);
            }
            if(objMap.get('Consigliato') == null){
                 objMap.put('Consigliato',false);
            }
            
            availableFoderaMap.put((String)obj.get('Name') , objMap);
        }
        
        result.Bottone = availableButtoneMap;
        result.Fodera = availableFoderaMap;

        /*if(result != null){
                Cache.Org.put( (orgLang != null ? orgLang : '')+(orgCurr != null ? orgCurr : '')+(tessutoColoreId != null ? tessutoColoreId : '')+(stagioneId != null ? stagioneId : ''),result );
            }*/
        
        //}
        
        
        return result;
    }
    
    
    
    public static Map<Id,sObject> getMisurediRiferimentoSartoria(Map<String, Schema.SObjectType> schemaMap){
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = Performant_GenericDAO.getAllFieldsListWithoutConditions(schemaMap,'Misure_di_Riferimento_Sartoria__c');
        return result;
        
    }
    
    
    public static Map<Id,sObject> getCapoTessutiFiltered(Set<String> recordTypeId,Set<String> categoria,Map<String, Schema.SObjectType> schemaMap){
        
        Map<Id,sObject> result = new Map<Id,Capo_Tessuto__c>();
        
        result = Performant_GenericDAO.getAllFieldsListWhereInANDConditionsWithNoLimits(schemaMap,'Capo_Tessuto__c', 'Tipo_Capo__c', recordTypeId,'Categoria_Capo__c', categoria);
        system.debug('result : ' + result);
        return result;
        
    }
    public static Map<Id,sObject> getTessutiFiltered(Set<Id> tessutoColoreIds, Map<String, Schema.SObjectType> schemaMap){
        
        Map<Id,sObject> result = new Map<Id,Capo_Tessuto__c>();
        String filter = ' AND Stagione__r.Attiva__c = true '; 
       
        result = Performant_GenericDAO.getAllFieldsListWhereInConditionsAndFilterWithNoLimits(schemaMap,'Tessuto_Colore__c', 'Tessuto__c', tessutoColoreIds, filter);
        system.debug('result : ' + result);
        return result;
        
    }
    
    
    public static Map<Id,sObject> getFodera(Map<String, Schema.SObjectType> schemaMap,Id tessutoColoreId){
        
        List<Tessuto_Colore_Fodera__c> tessutoFoderaList = new List<Tessuto_Colore_Fodera__c> ();
        Set<Id> fodereDisponibili =  new Set<Id>();
        tessutoFoderaList = [SELECT Id,Fodera__c 
                             FROM Tessuto_Colore_Fodera__c
                             WHERE Tessuto_Colore__c =:tessutoColoreId];
        
       
       
        if(tessutoFoderaList.size() > 0 ){
            for(Tessuto_Colore_Fodera__c mapFodera : tessutoFoderaList){
                fodereDisponibili.add(mapFodera.Fodera__c);
            }
        }
        
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = Performant_GenericDAO.getAllFieldsListWhereInConditionsWithNoLimits(schemaMap,'Fodera__c', 'Id', fodereDisponibili);
        system.debug(result);
        return result;
        
    }
    
    public static Map<Id,sObject> queryAllBottone(Map<String, Schema.SObjectType> schemaMap){
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = Performant_GenericDAO.getAllFieldsListWithoutConditions(schemaMap, 'Bottone__c');
        
        
        system.debug('Akshay RESULT: ' + result);
        return result;
        
    }
    public static Map<Id,sObject> queryAllFodera(Map<String, Schema.SObjectType> schemaMap){
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = Performant_GenericDAO.getAllFieldsListWithoutConditions(schemaMap, 'Fodera__c');
        
        
        system.debug('Akshay RESULT: ' + result);
        return result;
        
    }
    public static Map<Id,sObject> getBottone(Map<String, Schema.SObjectType> schemaMap,Id tessutoColoreId){
        Set<Id> bottoniDisponibili =  new Set<Id>();
        List<Tessuto_Colore_Bottone__c> tessutoButtoneList = new  List<Tessuto_Colore_Bottone__c>();
         
        tessutoButtoneList = [SELECT Id,Bottone__c
                              FROM Tessuto_Colore_Bottone__c  
                              WHERE Tessuto_Colore__c =:tessutoColoreId];
        
        
        
        if(tessutoButtoneList.size() > 0 ){
            for(Tessuto_Colore_Bottone__c mapButtone : tessutoButtoneList){
                bottoniDisponibili.add(mapButtone.Bottone__c);
            }
        }
        
        
        
        Map<Id,sObject> result = new Map<Id,sObject>();
        result = Performant_GenericDAO.getAllFieldsListWhereInConditionsWithNoLimits(schemaMap, 'Bottone__c', 'Id', bottoniDisponibili);
        
        
        system.debug('Akshay RESULT: ' + result);
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
            String searchValue = '';
            String recordTypeId = '';
            String categoria = '';
            object  collections;
            Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
            
            ObjectTypeToIdPrefix__mdt[] objectPrefixes = [SELECT DeveloperName,MasterLabel FROM ObjectTypeToIdPrefix__mdt ];
            String tessutoColorePrefix = '';
            if(objectPrefixes != null && objectPrefixes.size() > 0){
                for(ObjectTypeToIdPrefix__mdt item : objectPrefixes){
                    if(item.MasterLabel == 'Tessuto_Colore__c')
                        tessutoColorePrefix = item.DeveloperName;
                }
            }
            
            if(tessutoColorePrefix == null || tessutoColorePrefix == ''){
                tessutoColorePrefix = 'a1b';
            }
			system.debug(tessutoColorePrefix);
            
            if(arr.size() > 3){
                searchValue = arr[3];
                if(searchValue != '' && searchValue.contains('__')){
                    List<String> temp =  searchValue.split('__');
                    recordTypeId =  temp[0];
                    categoria =  temp[1];
                    collections  = (CollectionWrapper) getCollectionSecondStep(recordTypeId, categoria, schemaMap);
                }else if(searchValue != '' ){
                    
                    if(searchValue.contains(tessutoColorePrefix)){
                        List<Tessuto_Colore__c> tessutoColoreRecord =  [SELECT Id, Stagione__c  FROM Tessuto_Colore__c WHERE Id=:searchValue LIMIT 1];

                        collections  = (CollectionFoderaButtoneWrapper) getCollectionThirdStep(searchValue, tessutoColoreRecord[0].Stagione__c, schemaMap);
                        
                    }else{
                        String id = String.escapeSingleQuotes(searchValue);
                        if((id.length() == 15 || id.length() == 18) && Pattern.matches('^[a-zA-Z0-9]*$', id)) {
                            recordTypeId = id;
                        }else{
                            categoria = searchValue;
                        }
                        system.debug('recordTypeId  :' +recordTypeId );
                        system.debug('categoria  :' +categoria );
                        collections  = (CollectionWrapper) getCollectionSecondStep(recordTypeId, categoria, schemaMap);
                        
                    }
                    
                }
                
            }else{
                
                collections = (MetaWrapper) getCollectionFirstStep(schemaMap);
                
            }
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
    
    
    public class RecordTypeMisureWrapper {
        
        Id Id;
        String Name;
        
    }
    
    public class TipoDiCapoWrapper{
        
        Map<String,String> CategoryCapo;
        Map<String,String> RecordTypeCapo;
        
    }
    public class CollectionWrapper {
        
        Map<Id,sObject> CapiTessuti;
        Map<Id,sObject> TessutoColore;
        
    }
    public class CollectionFoderaButtoneWrapper {
        
        Map<String,Object> Bottone;
        Map<String,Object> Fodera;
        
    }
    
    public class MetaWrapper {
        
        List<RecordTypeMisureWrapper> RecordTypeMisure;
        List<Misure_di_Riferimento_Sartoria__c> Misure;
        TipoDiCapoWrapper TipoDiCapo;
        
    }
    
    
    
}