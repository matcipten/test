public with sharing class TransactionDetialListViewController {
	@AuraEnabled
	public static List<Transaction_Detail__c> getTransactionDetailsLimit5(String accId){


		List<Transaction_Detail__c> tDetails =  [SELECT Id,
		                                         Name,
		                                         Importo_sconto_formula__c,
		                                         Sconto_formula__c,
		                                         Data_Scontrino_KPI__c,
		                                         Numero_Scontrino__c,
		                                         SKU__c,
		                                         Nome_Location__c,
		                                         Prezzo_di_listino_formula__c,
		                                         Prezzo_di_vendita_formula__c,
		                                         Product_Image_Reference__c,
		                                         Seller__r.Name,
		                                         Tipo_Vendita__c,
		                                         Transaction__c
		                                         FROM Transaction_Detail__c
		                                         WHERE Gift__c = false
		                                                         AND AccountId__c  =:accId
		                                                                             //AND Product_Image_Reference__c != null
		                                                                             Order By Data_Scontrino__c Desc
		                                                                             LIMIT 5];

		system.System.debug(tDetails);

		return (tDetails.size() > 0) ? tDetails : null;


	}
	@AuraEnabled
	public static List<Transaction_Detail__c> getTransactionDetailsQueryAll(String accId){


		List<Transaction_Detail__c> tDetails =  [SELECT Id,
		                                         Name,
		                                         Importo_sconto_formula__c,
		                                         Sconto_formula__c,
		                                         Data_Scontrino_KPI__c,
		                                         Numero_Scontrino__c,
		                                         SKU__c,
		                                         Nome_Location__c,
		                                         Prezzo_di_listino_formula__c,
		                                         Prezzo_di_vendita_formula__c,
		                                         Product_Image_Reference__c,
		                                         Seller__r.Name,
		                                         Tipo_Vendita__c,
		                                         Transaction__c
		                                         FROM Transaction_Detail__c
		                                         WHERE Gift__c = false
		                                                         AND AccountId__c =:accId
		                                                                            //AND Product_Image_Reference__c != null
		                                                                            Order By Data_Scontrino__c Desc
		];

		system.System.debug(tDetails);

		return (tDetails.size() > 0) ? tDetails : null;


	}
	@AuraEnabled
	public static Integer getTransactionDetailsSize(String accId){


		Integer tDetails =  [SELECT count()
		                     FROM Transaction_Detail__c
		                     WHERE Gift__c = false
		                                     AND AccountId__c =:accId
		];



		return (tDetails != 0) ? tDetails : 0;


	}

}