public class ProdottiImagesPreviewController {
    @AuraEnabled
    public static List<productContainer> getAttachments(String parentId, String type) {

        List<productContainer> result = new List<productContainer>();
        try{
        Map<id,Transaction_Detail__c> TransactionDetailMap = new  Map<id,Transaction_Detail__c>();
        Map<id, ContentDocumentLink> cdlMap = new Map<id, ContentDocumentLink>();
        Map<id, ContentDocumentLink> cdlMapLinkedEntityId = new Map<id, ContentDocumentLink>();
        Map<id, ContentVersion> cvMap = new Map<id, ContentVersion>();
        set<Id> setId = new set<Id>();
        List<Transaction_Detail__c> td = new List<Transaction_Detail__c>();

        if(type == 'purchase'){
            td = [ SELECT Id, Name, Product__c, Gift__c, Tipo_Vendita__c, Data_Scontrino__c 
                    FROM Transaction_Detail__c  
                    WHERE AccountId__c = :parentId AND Gift__c = false
                    ORDER BY Data_Scontrino__c DESC ];   
        } else {
            td = [ SELECT Id, Name, Product__c, Gift__c, Tipo_Vendita__c, Data_Scontrino__c 
                    FROM Transaction_Detail__c  
                    WHERE AccountId__c = :parentId AND Gift__c = true
                    ORDER BY Data_Scontrino__c DESC ];   
        }
        
        
        system.debug('td :' + td);
        for(Transaction_Detail__c singol_trns :  td ){
            TransactionDetailMap.put(singol_trns.Product__c, singol_trns );
        }
        
        setId = TransactionDetailMap.keySet();
        system.debug('setId : ' + setId);
        List<ContentDocumentLink> listAttach =  [ SELECT Id, ContentDocumentID,LinkedEntityId  
                                                  FROM ContentDocumentLink 
                                                  WHERE LinkedEntityId IN :setId ]; 
        system.debug('Attach : ' +listAttach);
        for(ContentDocumentLink cdl : listAttach){
            cdlMap.put(cdl.ContentDocumentID ,  cdl);
            cdlMapLinkedEntityId.put(cdl.LinkedEntityId, cdl);
        }
        
        List<ContentVersion> listImage = [ SELECT Id,ContentDocumentId
                                           FROM ContentVersion 
                                           WHERE ContentDocumentId IN :cdlMap.keySet() ];
        for(ContentVersion cvSingolo : listImage){
            cvMap.put(cvSingolo.ContentDocumentId ,  cvSingolo);
        }
        system.debug('listImage : ' +listImage);
        
        List<Product__c> listProd =  [ SELECT Id, Name, Stagione__c, Modello__c, Colore__c, Taglia_DW__c 
                                       FROM Product__c 
                                       WHERE Id IN :setId ];
        system.debug('listProd : ' +listProd);
		Map<string, Product__c> productMap = new Map<string, Product__c>();
            for(Product__c prodValue: listProd){
                productMap.put(prodValue.Name, prodValue);
            }
        for(Product__c prod : productMap.values()){
            productContainer res = new productContainer();
            if(cdlMapLinkedEntityId.get(prod.Id) !=  null){
                String contentId = cdlMapLinkedEntityId.get(prod.Id).ContentDocumentID;
         
                res.imageId = cvMap.get(contentId).Id;
                res.productId = TransactionDetailMap.get(prod.Id).Product__c;
                res.productSeason = prod.Stagione__c;
                res.productModel = prod.Modello__c;
                res.productSize = prod.Taglia_DW__c;
                res.productColor = prod.Colore__c;
                res.productReso = (TransactionDetailMap.get(prod.Id).Tipo_Vendita__c == 'R') ? true : false;
                res.productGift = TransactionDetailMap.get(prod.Id).Gift__c;
            }
            
            if(res.imageId != null)
            result.add(res);
        }
        }Catch(Exception ex){
            System.debug('ex getMessage: ' + ex.getMessage()  + '  '+ 'ex.getCause : ' + ex.getCause()  + '  '+ 'ex.getLineNumber :' + ex.getLineNumber());
            
        }
        System.debug('result : '+ result);
        return result;
       
    }
    
    public class productContainer {
        @AuraEnabled
        public String imageId {get; set;}
        @AuraEnabled
        public String productId {get; set;}
        @AuraEnabled
        public String productSeason {get; set;}
        @AuraEnabled
        public String productModel {get; set;}
        @AuraEnabled
        public String productSize {get; set;}
        @AuraEnabled
        public String productColor {get; set;}
        @AuraEnabled
        public Boolean productReso {get; set;}
        @AuraEnabled
        public Boolean productGift {get; set;}
    }
}