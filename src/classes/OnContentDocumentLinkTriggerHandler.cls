public class OnContentDocumentLinkTriggerHandler {

	public static void updateImagesOnGiftsAndTransactionDetails(Map<Id,ContentDocumentLink> cdlsMap,Map<String,String> cdlLinkedToProductMap, String action){
		system.debug('start handler');
		Map<String,String> contentDocumentsandCDL = new Map<String,String> ();
		Map<String,ContentDocument> contentDocumentsMap = new Map<String,ContentDocument>();
		if(action == 'Delete') {
			Set<String> productsId = (Set<String>)cdlLinkedToProductMap.keySet();
			cdlsMap = new Map<Id,ContentDocumentLink>([SELECT Id,LinkedEntityId,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN: productsId ]);
		}

		if(cdlsMap != null && cdlsMap.size() > 0) {

			for(ContentDocumentLink cdl : cdlsMap.values()) {
				contentDocumentsandCDL.put(cdl.LinkedEntityId,cdl.ContentDocumentId);
			}

			if(contentDocumentsandCDL != null && contentDocumentsandCDL.size() >0) {
				contentDocumentsMap =
					new Map<String,ContentDocument>
					(
						[SELECT Id,
						 (SELECT Id
						  FROM ContentVersions
						  WHERE IsLatest = true)
						 FROM ContentDocument
						 WHERE Id IN: contentDocumentsandCDL.values()]
					);
			}
		}
		OnContentDocumentLinkTriggerHandler.updateGiftImage(cdlsMap,cdlLinkedToProductMap,action,contentDocumentsandCDL,contentDocumentsMap);
		OnContentDocumentLinkTriggerHandler.updateDetailsImage(cdlsMap,cdlLinkedToProductMap,action,contentDocumentsandCDL,contentDocumentsMap);
	}

	public static void updateGiftImage(Map<Id,ContentDocumentLink> cdlsMap,
	                                   Map<String,String> cdlLinkedToProductMap,
	                                   String action,
	                                   Map<String,String> contentDocumentsandCDL,
	                                   Map<String,ContentDocument> contentDocumentsMap)
	{
		system.debug('start handler');
		// Map<String,String> contentDocumentsandCDL = new Map<String,String> ();

		Map<String,Attivita_Marketing__c> gifts =
			new Map<String,Attivita_Marketing__c>
			(
				[SELECT Id,Product_Image_Reference__c,Product__c
				 FROM Attivita_Marketing__c
				 WHERE Product__c IN
				 (
					 SELECT Id
					 FROM Product__c
					 WHERE Id IN: cdlLinkedToProductMap.keySet()
				 )
				]
			);

		// if(action == 'Delete') {
		//  Set<String> productsId = (Set<String>)cdlLinkedToProductMap.keySet();
		//  cdlsMap = new Map<Id,ContentDocumentLink>([SELECT Id,LinkedEntityId,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN: productsId ]);
		// }

		if(gifts != null && gifts.size() > 0) {
			system.debug('gifts');
			system.debug(JSON.serializePretty(gifts));


			// for(ContentDocumentLink cdl : cdlsMap.values()) {
			//  contentDocumentsandCDL.put(cdl.LinkedEntityId,cdl.ContentDocumentId);
			// }

			// Map<String,ContentDocument> contentDocumentsMap = new Map<String,ContentDocument>();

			// if(contentDocumentsandCDL != null && contentDocumentsandCDL.size() >0) {
			//  contentDocumentsMap =
			//      new Map<String,ContentDocument>
			//      (
			//          [SELECT Id,
			//           (SELECT Id
			//            FROM ContentVersions
			//            WHERE IsLatest = true)
			//           FROM ContentDocument
			//           WHERE Id IN: contentDocumentsandCDL.values()]
			//      );
			// }

			// if(gifts != null && gifts.size() > 0) {
			for(Attivita_Marketing__c gift : gifts.values()) {
				String cdId = contentDocumentsandCDL.get(gift.Product__c);
				if(cdId != null) {
					ContentDocument cd = contentDocumentsMap.get(cdId);
					if(cd != null && cd.ContentVersions != null && cd.ContentVersions.size()>0) {
						String cvId = cd.ContentVersions.get(0).Id;
						gift.Product_Image_Reference__c = cvId;
					}
					else
						gift.Product_Image_Reference__c = null;
				}
				else
					gift.Product_Image_Reference__c = null;
			}
			// }
			update gifts.values();
		}

	}

	public static void updateDetailsImage(Map<Id,ContentDocumentLink> cdlsMap,
	                                      Map<String,String> cdlLinkedToProductMap,
	                                      String action,
	                                      Map<String,String> contentDocumentsandCDL,
	                                      Map<String,ContentDocument> contentDocumentsMap)
	{
		system.debug('start handler');

		Map<String,Transaction_Detail__c> details =
			new Map<String,Transaction_Detail__c>
			(
				[SELECT Id,Product_Image_Reference__c,Product__c
				 FROM Transaction_Detail__c
				 WHERE Product__c IN
				 (
					 SELECT Id
					 FROM Product__c
					 WHERE Id IN: cdlLinkedToProductMap.keySet()
				 )
				]
			);


		if(details != null && details.size() > 0) {
			system.debug('details');
			system.debug(JSON.serializePretty(details));


			for(Transaction_Detail__c detail : details.values()) {
				String cdId = contentDocumentsandCDL.get(detail.Product__c);
				if(cdId != null) {
					ContentDocument cd = contentDocumentsMap.get(cdId);
					if(cd != null && cd.ContentVersions != null && cd.ContentVersions.size()>0) {
						String cvId = cd.ContentVersions.get(0).Id;
						detail.Product_Image_Reference__c = cvId;
					}
					else
						detail.Product_Image_Reference__c = null;
				}
				else
					detail.Product_Image_Reference__c = null;
			}
			// }
			update details.values();
		}

	}
}