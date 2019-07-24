public class OnContentDocumentTriggerHandler {

	public static Map<String,Product__c> productsMap;

	public static void SetAllegatiInAccount(list<ContentDocument> listContentDocument){
		System.debug('listContentDocument: ' + listContentDocument);

		set<Id> cDocListId = new set<Id>();
		for(ContentDocument cDoc : listContentDocument) {
			cDocListId.add(cDoc.Id);
		}
		system.debug('cDocListId: ' + cDocListId);

		List<ContentDocumentLink> listAttach =  [ SELECT Id, ContentDocumentID,LinkedEntityId
		                                          FROM ContentDocumentLink
		                                          WHERE ContentDocumentID IN : cDocListId ];
		system.debug('listAttach: ' + listAttach);
		set<Id> accountId = new set<Id>();
		for(ContentDocumentLink cnl : listAttach) {
			if(string.valueOf(cnl.LinkedEntityId).startsWith('001')) {
				accountId.add(cnl.LinkedEntityId);
			}
		}
		system.debug('accountId: ' + accountId);
		//PN20190108 check accountId is not empty
		if(accountId != null && accountId.size() > 0) {
			List<Account> accountList = new List<Account>([SELECT Id, Allegati__c FROM Account WHERE Id IN: accountId]);
			List<Attachment> attList = new List<Attachment>([SELECT Id, ParentId FROM Attachment WHERE ParentId IN: accountId]);
			List<ContentDocumentLink> conList = new List<ContentDocumentLink>([SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink where LinkedEntityId IN: accountId]);

			for(Account a : accountList) {
				Integer count = 0;
				for(Attachment attach : attList) {
					if(attach.ParentId == a.Id) {
						count++;
					}
				}

				for(ContentDocumentLink contDoc : conList) {
					if(contDoc.LinkedEntityId == a.Id) {
						count++;
					}
				}

				if(count - 1 == 0) {
					a.Allegati__c = false;
					update a;
				}
			}
		}
	}

	public static void fireUpdateGiftImage(){
		system.debug(JSON.serializePretty(productsMap));
		Map<Id,ContentDocumentLink> linksMap = new Map<Id,ContentDocumentLink> ();
		Map<String,ContentDocument> documentsMap = new Map<String,ContentDocument> ();
		Map<String,String> cdlLinkedToProductMap = new Map<String,String>();
		if(productsMap != null && productsMap.size() > 0) {

			for(String key : productsMap.keySet()) {
				cdlLinkedToProductMap.put(key,null);
			}

			Set<String> productsId = productsMap.keySet();
			if(productsId != null && productsId.size() > 0) {
				linksMap = new Map<Id,ContentDocumentLink>(
					[
						SELECT Id, ContentDocumentId,LinkedEntityId
						FROM ContentDocumentLink
						WHERE LinkedEntityId IN: productsId
					]
					);
			}

			// Set<String> documentsId = new Set<String>();
			if(linksMap != null && linksMap.size() > 0) {
				for(ContentDocumentLink cdl : linksMap.values()) {
					// documentsId.add(cdl.ContentDocumentId);
					cdlLinkedToProductMap.put(cdl.LinkedEntityId,cdl.Id);
				}
			}
			OnContentDocumentLinkTriggerHandler.updateImagesOnGiftsAndTransactionDetails(linksMap,cdlLinkedToProductMap,'');
			// OnContentDocumentLinkTriggerHandler.updateGiftImage(linksMap,cdlLinkedToProductMap,'');


		}
	}

	public static void getLinkForUpdateGiftImage(Map<Id,ContentDocument> documentsMap){
		system.debug('fire trigger');
		// Map<String,Product__c> productsMapInsert = new Map<String,Product__c>();
		Map<String,String> cdlLinkedToProductMap = new Map<String,String>();
		Set<Id> documentsId = documentsMap.keySet();
		Map<Id,ContentDocumentLink> linksMap = new Map<Id,ContentDocumentLink>(
			[
				SELECT Id,LinkedEntity.Type,ContentDocumentId
				FROM ContentDocumentLink
				WHERE ContentDocumentId IN: documentsId
			]
			);

		for(ContentDocumentLink link : linksMap.values()) {
			if(link.LinkedEntity.Type == 'Product__c') {
				system.debug(link.LinkedEntityId);
				system.debug(link.Id);
				// productsMapInsert.put(link.LinkedEntityId,null);
				cdlLinkedToProductMap.put(link.LinkedEntityId,link.Id);

			}
		}

		OnContentDocumentLinkTriggerHandler.updateImagesOnGiftsAndTransactionDetails(linksMap,cdlLinkedToProductMap,'');
		// OnContentDocumentLinkTriggerHandler.updateGiftImage(linksMap,cdlLinkedToProductMap,'');
	}



	public static void getLinkForUpdateGiftImageDelete(Map<Id,ContentDocument> documentsMap){
		system.debug('fire trigger');
		productsMap = new Map<String,Product__c>();
		Map<String,String> cdlLinkedToProductMap = new Map<String,String>();
		Set<Id> documentsId = documentsMap.keySet();
		Map<Id,ContentDocumentLink> linksMap = new Map<Id,ContentDocumentLink>(
			[
				SELECT Id,LinkedEntity.Type,ContentDocumentId
				FROM ContentDocumentLink
				WHERE ContentDocumentId IN: documentsId
			]
			);

		for(ContentDocumentLink link : linksMap.values()) {
			if(link.LinkedEntity.Type == 'Product__c') {
				system.debug(link.LinkedEntityId);
				system.debug(link.Id);
				productsMap.put(link.LinkedEntityId,null);
				cdlLinkedToProductMap.put(link.LinkedEntityId,link.Id);

			}
		}

		productsMap = new Map<String,Product__c>(
			[
				SELECT Id
				FROM Product__c
				WHERE Id IN: productsMap.keySet()
			]
			);

	}
}