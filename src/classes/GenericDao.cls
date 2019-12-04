public without sharing class GenericDao {
    

    public static SObject getAllFieldsResultById(String objectName, String key, String value){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' = :value';
 
        List<SObject> l = Database.query( query );
         
        return l == null || l.isEmpty() ? null : l.get(0);
    }
    
    //Ak 23/10/2018 
    public static List<SObject> getAllFieldsResultByCondition(String objectName, String key, Set<String> value){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' IN :value LIMIT 100';
 
        List<SObject> l = Database.query( query );
         
        return l == null || l.isEmpty() ? null : l;
    }
    
    //MC-
    public static List<SObject> getAllFieldsResultByConditionStatusWithAttachments(String objectName, String key, String value1 ,String value2){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ',(Select Id,Name FROM Attachments)' + ' From ' + objectName + ' Where ' + key + ' != :value1 AND ' + key + ' != :value2' + ' ORDER BY Createddate DESC LIMIT 20' ;
 
        List<SObject> l = Database.query( query );
         
        return l == null || l.isEmpty() ? null : l;
    }
    
    public static List<SObject> getAllFieldsResultByConditionStatus(String objectName, String key, String value1 ,String value2){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' != :value1 AND ' + key + ' != :value2' ;
 
        List<SObject> l = Database.query( query );
         
        return l == null || l.isEmpty() ? null : l;
    }
    
     public static SObject getFieldsResultById(String objectName, String key, String value){
       
        String query = 'Select ' + key + ' From ' + objectName + ' Where ' + value ;
 		system.debug('query : ' +query);
        List<SObject> l = Database.query( query );
         
        return l == null || l.isEmpty() ? null : l.get(0);
    }
    
    //MC- 2018.08.03
    public static List<SObject> getAllFieldsListResultByIdWithAttachs(String objectName, String key, String value){
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }    
        
        String query = '';
        if(schemaMap.get(objectName).getDescribe().fields.getMap().get(key).getDescribe().getType() == Schema.DisplayType.Boolean){
            Boolean boolval;
            if(value == 'true'){
                boolval = true;
            } else {
                boolval = false; 
            }
            query = 'Select ' + commaSepratedFields + ',(SELECT Id,Name FROM Attachments)' + ' From ' + objectName + ' Where ' + key + ' = :boolval';
        } else {
            query = 'Select ' + commaSepratedFields + ',(SELECT Id,Name FROM Attachments)' + ' From ' + objectName + ' Where ' + key + ' = :value';
        }
 
        System.debug('query: ' + query);
        List<SObject> l = Database.query( query );
         
        return l;
    }
    
    
    
    public static List<SObject> getAllFieldsListResultById(String objectName, String key, String value){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }    
        
        String query = '';
        if(schemaMap.get(objectName).getDescribe().fields.getMap().get(key).getDescribe().getType() == Schema.DisplayType.Boolean){
            Boolean boolval;
            if(value == 'true'){
                boolval = true;
            } else {
                boolval = false; 
            }
            query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' = :boolval';
        } else {
            //MC- 2018.08.02
            if(objectName == 'Ordine_Sartoria_Solomeo__c'){
            	query = 'Select ' + commaSepratedFields + ',(SELECT Id,Name FROM Attachments)' + ' From ' + objectName + ' Where ' + key + ' = :value';
            }else{
                query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' = :value';
            }
        }
 
        System.debug('query: ' + query);
        List<SObject> l = Database.query( query );
         
        return l;
    }
    
    //MC- 2018.08.03 query with attachments
    public static List<SObject> getAllFieldsListWhereInConditionsWithAttachments(String objectName, String key, Set<ID> setValue){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
        
        String query = 'Select ' + commaSepratedFields + ',(SELECT Id,Name FROM Attachments ORDER BY LastModifiedDate DESC LIMIT 100)' + ' From ' + objectName + ' Where ' + key + ' IN : setValue ORDER BY createddate DESC LIMIT 400';
 
        System.debug('query: ' + query);
        List<SObject> l = Database.query( query );
         
        return l;
    }
    
    public static List<SObject> getAllFieldsListWhereInConditions(String objectName, String key, Set<ID> setValue){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
        
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' IN : setValue LIMIT 100';
 
        System.debug('query: ' + query);
        List<SObject> l = Database.query( query );
         
        return l;
    }
    
    public static List<SObject> getAllFieldsListWhereInConditionsWithNoLimits(String objectName, String key, Set<ID> setValue){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
        
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' IN : setValue ';
 
        System.debug('query: ' + query);
        List<SObject> l = Database.query( query );
         
        return l;
    }
    
    public static List<SObject> getAllFieldsListWhereInConditionsWithNoLimits(String objectName, String key, List<String> setValue){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
        
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' IN : setValue ';
 
        System.debug('query: ' + query);
        List<SObject> l = Database.query( query );
         
        return l;
    }
    
    public static List<SObject> getAllFieldsListWithoutConditions(String objectName){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName;
 
        List<SObject> l = Database.query( query );
         
        return l;
    }
	public static List<SObject> getAllFieldsListWithoutConditionsLimit(String objectName){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName;
 
        List<SObject> l = Database.query( query );
         
        return l;
    }
    public static List<List<SObject>> getAllFieldsListWithParam(String objectName, String param){
         Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
         System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());

        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
		//Querys on Account for records with LastName and first three letters of firstName

        String query = 'FIND {(*' + param + '*)} IN ALL FIELDS RETURNING Account (' + commaSepratedFields + ')';
 
        system.debug('QUERY: ' + query);
        List<List<SObject>> searchList = search.query( query );
         system.debug('searchList: ' + searchList);
        return searchList;
    }

    public static User getUserByCodiceBuotique(String codiceBoutique){
        if(String.isEmpty(codiceBoutique)){
            return null;
        }

        List<User> u = [Select Id from User where Codice_Boutique__c = :codiceBoutique];

        return u == null || u.isEmpty() ? null : u.get(0);
    }

    public static Account insertAccountForCaseTask(SObject c){
        try{
            Account a = new Account(
                Salutation = (String)c.get('Titolo_Cliente__c'),
                FirstName = (String)c.get('Nome_Cliente__c'),
                LastName = (String)c.get('Cognome_Cliente__c'),
                Sesso__c = (String)c.get('Sesso__c'),
                PersonEmail = (String)c.get('Email_Cliente__c'),
                Phone = (String)c.get('Telefono__c'),
                PersonMailingCountry = (String)c.get('Nazione__c'),
                PersonMailingCity = (String)c.get('Citta__c'),
                Lingua__c = (String)c.get('Lingua_di_Preferenza__c'),
                Customer_origin__c = 'Customer Care'
                );

            SYstem.debug('insertAccountForCaseTask:' + a);

            insert a;

            return a;

         }catch(Exception ex){
            System.debug('Eccezione ' + ex.getMessage());
            System.debug('StackString ' + ex.getStackTraceString());
         }

         return null;
    }
    
}