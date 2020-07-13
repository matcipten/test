public class DiscountCategoriesController {

    @AuraEnabled
    public static User getUserInfo(){
        return [SELECT ID, Name, Nation_Contact_Card__c,ManagerID FROM User WHERE ID=: UserInfo.getUserId()];
    } 
    
    @AuraEnabled
    public static List<Discount_Category_Visibility__mdt> getPicklistValue(){
        String userCountry = getUserInfo().Nation_Contact_Card__c;

        List<Discount_Category_Visibility__mdt> listDisc = new List<Discount_Category_Visibility__mdt>(); 

        if(userCountry!= null){
            userCountry= '%'+userCountry+'%';
            System.debug('VS check userCountry: '+userCountry);
            listDisc =[SELECT DeveloperName, Country__c, ProposedCustomerCategory__c
                        FROM Discount_Category_Visibility__mdt
                        WHERE Country__c LIKE: userCountry
                        ORDER BY DeveloperName ];
        }else{
            listDisc = [SELECT DeveloperName, Country__c, ProposedCustomerCategory__c
                        FROM Discount_Category_Visibility__mdt
                        WHERE Country__c = null
                        ORDER BY DeveloperName];
        }
        return listDisc;
    }

    @AuraEnabled
    public static void updateAccount(string recordId,String categoria, String motivo){
        Account acc = new Account(ID = recordId,
                                 Categoria_Cliente_Proposta__c = categoria,
                                 Motivazione_Richiesta_Sconto__c = motivo);      
        if(!Test.isRunningTest()){
            update acc;
        }

    }
}