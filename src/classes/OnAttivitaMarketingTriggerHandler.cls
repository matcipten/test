public class OnAttivitaMarketingTriggerHandler {

	public static Boolean isMassiveUpdate = false;
	// public static void updateGiftImage(Map<String,String> relatedProductsMapWithNull,Map<String,Product__c> productsMap,Map<Id,Attivita_Marketing__c> giftsMap){
	// }

	public static void updateGiftImage(Map<String,Product__c> productsMap,List<Attivita_Marketing__c> gifts){
		system.debug('start handler');
		Map<String,String> relatedProductsMap = new Map<String,String>();
		Map<String,List<String> > relatedProductGiftsMap = new Map<String,List<String> >();

		productsMap = new Map<String,Product__c>([SELECT Id, (SELECT Id,LinkedEntityId,ContentDocument.CreatedDate FROM ContentDocumentLinks WHERE LinkedEntity.Type = 'Product__c' ORDER BY ContentDocument.CreatedDate DESC LIMIT 1) FROM Product__c WHERE Id IN: productsMap.keySet()]);

		Map<String,String> contentDocumentsandCDL = new Map<String,String> ();
		for(Product__c p : productsMap.values()) {
			if(p.ContentDocumentLinks != null && p.ContentDocumentLinks.size() >0) {
				for(ContentDocumentLink cdl : p.ContentDocumentLinks) {
					contentDocumentsandCDL.put(cdl.Id,cdl.ContentDocumentId);
				}
			}
		}

		Map<String,ContentDocument> contentDocumentsMap = new Map<String,ContentDocument>([SELECT Id, (SELECT Id FROM ContentVersions WHERE IsLatest = true) FROM ContentDocument WHERE Id IN: contentDocumentsandCDL.values()]);

		// for(String giftId : relatedProductsMapWithNull.keySet()) {
		for(Attivita_Marketing__c gift : gifts) {

			////////////////////////


			//Attivita_Marketing__c gift = giftsMap.get(giftId);
			// if(relatedProductsMapWithNull.get(giftId) == null) {
			if(gift.Product__c == null) {
				// system.debug('relatedProductsMapWithNull.get(giftId) == null');
				// system.debug(giftId);
				gift.Product_Image_Reference__c = null;
			}
			else{
				// String prodId =  relatedProductsMapWithNull.get(giftId);
				String prodId =  gift.Product__c;
				Product__c prod = productsMap.get(prodId);
				System.debug('product');
				System.debug(JSON.serializePretty(prod));
				if(prod.ContentDocumentLinks != null && prod.ContentDocumentLinks.size() >0)
				{
					String contentDocumentId = prod.ContentDocumentLinks.get(0).ContentDocumentId;
					ContentDocument cd = contentDocumentsMap.get(contentDocumentId);
					if(cd != null && cd.ContentVersions != null && cd.ContentVersions.size() >0) {
						ContentVersion cv = cd.ContentVersions.get(0);
						gift.Product_Image_Reference__c = cv.Id;
					}
					else
						gift.Product_Image_Reference__c = null;
				}
				else
					gift.Product_Image_Reference__c = null;
			}
		}



		// system.debug(JSON.serializePretty(giftsMap));

	}

}