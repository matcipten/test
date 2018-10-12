public class Performant_GenericDAO {
    
    public static SObject getAllFieldsResultById(Map<String, Schema.SObjectType> schemaMap, String objectName, String key, String value){
         /*System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());
*/
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' = :value LIMIT 1';
 
        List<SObject> l = Database.query( query );
                 
        return l == null || l.isEmpty() ? null : l.get(0);
    }
    
    public static Map<Id,SObject> getAllFieldsResultByConditionStatus(Map<String, Schema.SObjectType> schemaMap, String objectName, String key, String value1 ,String value2){
         /*System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());
*/
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' != :value1 AND ' + key + ' != :value2 LIMIT 49999' ;
         
        Map<Id,SObject> m = new Map<Id,SObject>((List<SObject>)Database.query( query ));
         
        return m == null || m.isEmpty() ? null : m;
    }
    
     public static SObject getFieldsResultById(String objectName, String key, String value){
       
        String query = 'Select ' + key + ' From ' + objectName + ' Where ' + value +' LIMIT 1';
        system.debug('query : ' +query);
        
         List<SObject> l = Database.query( query );
         
         
        return l == null || l.isEmpty() ? null : l.get(0);
    }
    
    public static Map<Id,SObject> getAllFieldsListResultById(Map<String, Schema.SObjectType> schemaMap, String objectName, String key, String value){
         /*System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());
*/
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
            query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' = :boolval LIMIT 49999';
        } else {
            query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' = :value LIMIT 49999';
        }
 
        System.debug('query: ' + query);
        //List<SObject> l = Database.query( query );
        
        Map<Id,SObject> m = new Map<Id,SObject>((List<SObject>)Database.query( query ));
         
        return m;
    }
    
    public static Map<Id,SObject> getAllFieldsListWhereInConditions(Map<String, Schema.SObjectType> schemaMap, String objectName, String key, Set<ID> setValue){
         /*System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());
*/
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
        //List<SObject> l = Database.query( query );
        
        Map<Id,SObject> m = new Map<Id,SObject>((List<SObject>)Database.query( query ));
         
        return m;
    }
    
    public static Map<Id,SObject> getAllFieldsListWhereInConditionsWithNoLimits(Map<String, Schema.SObjectType> schemaMap, String objectName, String key, Set<ID> setValue){
         /*System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());
*/
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
        
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' Where ' + key + ' IN : setValue LIMIT 49999';
 
        System.debug('query: ' + query);
        //List<SObject> l = Database.query( query );
        
        Map<Id,SObject> m = new Map<Id,SObject>((List<SObject>)Database.query( query ));
        System.debug('size: ' + m.size());
         
        return m;
    }
    
    public static Map<Id,SObject> getAllFieldsListWithoutConditions(Map<String, Schema.SObjectType> schemaMap, String objectName){
        /* System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());
*/
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' LIMIT 49999';
 
        //List<SObject> l = Database.query( query );
        
        Map<Id,SObject> m = new Map<Id,SObject>((List<SObject>)Database.query( query ));
         
        return m;
    }
    
    public static Map<Id,SObject> getAllFieldsListWithoutConditionsLimit(Map<String, Schema.SObjectType> schemaMap, String objectName){
         /*System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());
*/
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(objectName).getDescribe().fields.getMap();
 
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
 
        String query = 'Select ' + commaSepratedFields + ' From ' + objectName + ' LIMIT 49999';
 
        //List<SObject> l = Database.query( query );
        
        Map<Id,SObject> m = new Map<Id,SObject>((List<SObject>)Database.query( query ));
         
        return m;
    }
    
    public static List<List<SObject>> getAllFieldsListWithParam(Map<String, Schema.SObjectType> schemaMap, String objectName, String param){
         /*System.debug('schemaMap:' + schemaMap);
         System.debug('schemaMap.get(objectName).getDescribe():' + schemaMap.get(objectName).getDescribe());
         System.debug('schemaMap.get(objectName).getDescribe().fields:' + schemaMap.get(objectName).getDescribe().fields);
         System.debug('schemaMap.get(objectName).getDescribe().fields.getMap():' + schemaMap.get(objectName).getDescribe().fields.getMap());
*/
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

        List<User> u = [Select Id from User where Codice_Boutique__c = :codiceBoutique LIMIT 49999];

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
                Lingua__c = (String)c.get('Lingua_di_Preferenza__c')
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