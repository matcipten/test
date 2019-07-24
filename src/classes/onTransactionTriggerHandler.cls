public class onTransactionTriggerHandler {

	//PN20193001
	public static Boolean isMassiveUpdate = false;
	// public static Map<String,String> blockTriggerMap = new Map<String,String>();

	public static void setScontoInTransactionInsert(List<Transaction__c> TransactionNew){
		System.debug('SET SCONTO IN TRANSACTION ');
		for(Transaction__c trans : TransactionNew) {

			trans.Sconto_AUD__c  = (trans.Prezzo_di_listino_AUD__c != 0 && trans.Prezzo_di_vendita_AUD__c <= trans.Prezzo_di_listino_AUD__c) ? (trans.Prezzo_di_listino_AUD__c - trans.Prezzo_di_vendita_AUD__c) : 0;
			trans.PSconto_AUD__c = (trans.Prezzo_di_listino_AUD__c > 0 && trans.Sconto_AUD__c > 0) ? (trans.Sconto_AUD__c / trans.Prezzo_di_listino_AUD__c)*100 : 0;


			trans.Sconto_DKK__c  = (trans.Prezzo_di_Vendita_DKK__c != 0 && trans.Prezzo_di_Vendita_DKK__c <= trans.Prezzo_di_listino_DKK__c) ? (trans.Prezzo_di_listino_DKK__c - trans.Prezzo_di_Vendita_DKK__c) : 0;
			trans.PSconto_DKK__c = (trans.Prezzo_di_listino_DKK__c > 0 && trans.Sconto_DKK__c > 0) ? (trans.Sconto_DKK__c / trans.Prezzo_di_listino_DKK__c)*100 : 0;

			trans.Sconto_RUB__c  = (trans.Prezzo_di_vendita_RUB__c != 0 && trans.Prezzo_di_vendita_RUB__c <= trans.Prezzo_di_listino_RUB__c) ? (trans.Prezzo_di_listino_RUB__c - trans.Prezzo_di_vendita_RUB__c) : 0;
			trans.PSconto_RUB__c = (trans.Prezzo_di_listino_RUB__c > 0 && trans.Sconto_RUB__c > 0) ? (trans.Sconto_RUB__c / trans.Prezzo_di_listino_RUB__c)*100 : 0;

			trans.Sconto_MOP__c  = (trans.Prezzo_di_vendita_MOP__c != 0 && trans.Prezzo_di_vendita_MOP__c <= trans.Prezzo_di_listino_MOP__c) ? (trans.Prezzo_di_listino_MOP__c - trans.Prezzo_di_vendita_MOP__c) : 0;
			trans.PSconto_MOP__c = (trans.Prezzo_di_listino_MOP__c > 0 && trans.Sconto_MOP__c > 0) ? (trans.Sconto_MOP__c / trans.Prezzo_di_listino_MOP__c)*100 : 0;
			
			trans.Sconto_KRW__c  = (trans.Prezzo_di_Vendita_KRW__c != 0 && trans.Prezzo_di_Vendita_KRW__c <= trans.Prezzo_di_listino_KRW__c) ? (trans.Prezzo_di_listino_KRW__c - trans.Prezzo_di_Vendita_KRW__c) : 0;
			trans.PSconto_KRW__c = (trans.Prezzo_di_listino_KRW__c > 0 && trans.Sconto_KRW__c > 0) ? (trans.Sconto_KRW__c / trans.Prezzo_di_listino_KRW__c)*100 : 0;
			
			trans.Sconto_AED__c  = (trans.Prezzo_di_Vendita_AED__c != 0 && trans.Prezzo_di_Vendita_AED__c <= trans.Prezzo_di_listino_AED__c) ? (trans.Prezzo_di_listino_AED__c - trans.Prezzo_di_Vendita_AED__c) : 0;
			trans.PSconto_AED__c = (trans.Prezzo_di_listino_AED__c > 0 && trans.Sconto_AED__c > 0) ? (trans.Sconto_AED__c / trans.Prezzo_di_listino_AED__c)*100 : 0;
			
			trans.Sconto_PLN__c  = (trans.Prezzo_di_Vendita_PLN__c != 0 && trans.Prezzo_di_Vendita_PLN__c <= trans.Prezzo_di_listino_PLN__c) ? (trans.Prezzo_di_listino_PLN__c - trans.Prezzo_di_Vendita_PLN__c) : 0;
			trans.PSconto_PLN__c = (trans.Prezzo_di_listino_PLN__c > 0 && trans.Sconto_PLN__c > 0) ? (trans.Sconto_PLN__c / trans.Prezzo_di_listino_PLN__c)*100 : 0;
			
			trans.Sconto_QAR__c  = (trans.Prezzo_di_Vendita_QAR__c != 0 && trans.Prezzo_di_Vendita_QAR__c <= trans.Prezzo_di_listino_QAR__c) ? (trans.Prezzo_di_listino_QAR__c - trans.Prezzo_di_Vendita_QAR__c) : 0;
			trans.PSconto_QAR__c = (trans.Prezzo_di_listino_QAR__c > 0 && trans.Sconto_QAR__c > 0) ? (trans.Sconto_QAR__c / trans.Prezzo_di_listino_QAR__c)*100 : 0;
			
			trans.Sconto_SGD__c  = (trans.Prezzo_di_Vendita_SGD__c != 0 && trans.Prezzo_di_Vendita_SGD__c <= trans.Prezzo_di_listino_SGD__c) ? (trans.Prezzo_di_listino_SGD__c - trans.Prezzo_di_Vendita_SGD__c) : 0;
			trans.PSconto_SGD__c = (trans.Prezzo_di_listino_SGD__c > 0 && trans.Sconto_SGD__c > 0) ? (trans.Sconto_SGD__c / trans.Prezzo_di_listino_SGD__c)*100 : 0;
			
			trans.Sconto_SAR__c  = (trans.Prezzo_di_Vendita_SAR__c != 0 && trans.Prezzo_di_Vendita_SAR__c <= trans.Prezzo_di_listino_SAR__c) ? (trans.Prezzo_di_listino_SAR__c - trans.Prezzo_di_Vendita_SAR__c) : 0;
			trans.PSconto_SAR__c = (trans.Prezzo_di_listino_SAR__c > 0 && trans.Sconto_SAR__c > 0) ? (trans.Sconto_SAR__c / trans.Prezzo_di_listino_SAR__c)*100 : 0;
			
			System.debug('SET SCONTO INside TRANSACTION ' + trans.Sconto_MOP__c + ' -Sconto_MOP__c- ');
		}
	}

	public static void setScontoInTransactionUpdate(Map<Id,Transaction__c> TransactionNew, Map<Id,Transaction__c> TransactionOld){
		System.debug('SET SCONTO IN TRANSACTION ');

		for(Transaction__c trans : TransactionNew.values()) {
			if((TransactionNew.get(trans.Id).Prezzo_di_Listino_AUD__c != TransactionOld.get(trans.Id).Prezzo_di_Listino_AUD__c) || (TransactionNew.get(trans.Id).Prezzo_di_vendita_AUD__c != TransactionOld.get(trans.Id).Prezzo_di_vendita_AUD__c)) {
				trans.Sconto_AUD__c  = (trans.Prezzo_di_listino_AUD__c != 0 && trans.Prezzo_di_vendita_AUD__c <= trans.Prezzo_di_listino_AUD__c) ? (trans.Prezzo_di_listino_AUD__c - trans.Prezzo_di_vendita_AUD__c) : 0;
				trans.PSconto_AUD__c = (trans.Prezzo_di_listino_AUD__c > 0 && trans.Sconto_AUD__c > 0) ? (trans.Sconto_AUD__c / trans.Prezzo_di_listino_AUD__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_DKK__c != TransactionOld.get(trans.Id).Prezzo_di_listino_DKK__c) || (TransactionNew.get(trans.Id).Prezzo_di_Vendita_DKK__c != TransactionOld.get(trans.Id).Prezzo_di_Vendita_DKK__c)) {
				trans.Sconto_DKK__c  = (trans.Prezzo_di_listino_DKK__c != 0 && trans.Prezzo_di_Vendita_DKK__c <= trans.Prezzo_di_listino_DKK__c) ? (trans.Prezzo_di_listino_DKK__c - trans.Prezzo_di_Vendita_DKK__c) : 0;
				trans.PSconto_DKK__c = (trans.Prezzo_di_listino_DKK__c > 0 && trans.Sconto_DKK__c > 0) ? (trans.Sconto_DKK__c / trans.Prezzo_di_listino_DKK__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_RUB__c != TransactionOld.get(trans.Id).Prezzo_di_listino_RUB__c) || (TransactionNew.get(trans.Id).Prezzo_di_vendita_RUB__c != TransactionOld.get(trans.Id).Prezzo_di_vendita_RUB__c)) {
				trans.Sconto_RUB__c  = (trans.Prezzo_di_listino_RUB__c != 0 && trans.Prezzo_di_vendita_RUB__c <= trans.Prezzo_di_listino_RUB__c) ? (trans.Prezzo_di_listino_RUB__c - trans.Prezzo_di_vendita_RUB__c) : 0;
				trans.PSconto_RUB__c = (trans.Prezzo_di_listino_RUB__c > 0 && trans.Sconto_RUB__c > 0) ? (trans.Sconto_RUB__c / trans.Prezzo_di_listino_RUB__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_MOP__c != TransactionOld.get(trans.Id).Prezzo_di_listino_MOP__c) || (TransactionNew.get(trans.Id).Prezzo_di_vendita_MOP__c != TransactionOld.get(trans.Id).Prezzo_di_vendita_MOP__c)) {
				trans.Sconto_MOP__c  = (trans.Prezzo_di_listino_MOP__c != 0 && trans.Prezzo_di_vendita_MOP__c <= trans.Prezzo_di_listino_MOP__c) ? (trans.Prezzo_di_listino_MOP__c - trans.Prezzo_di_vendita_MOP__c) : 0;
				trans.PSconto_MOP__c = (trans.Prezzo_di_listino_MOP__c > 0 && trans.Sconto_MOP__c > 0) ? (trans.Sconto_MOP__c / trans.Prezzo_di_listino_MOP__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_KRW__c != TransactionOld.get(trans.Id).Prezzo_di_listino_KRW__c) || (TransactionNew.get(trans.Id).Prezzo_di_Vendita_KRW__c != TransactionOld.get(trans.Id).Prezzo_di_Vendita_KRW__c)) {
				trans.Sconto_KRW__c  = (trans.Prezzo_di_listino_KRW__c != 0 && trans.Prezzo_di_Vendita_KRW__c <= trans.Prezzo_di_listino_KRW__c) ? (trans.Prezzo_di_listino_KRW__c - trans.Prezzo_di_Vendita_KRW__c) : 0;
				trans.PSconto_KRW__c = (trans.Prezzo_di_listino_KRW__c > 0 && trans.Sconto_KRW__c > 0) ? (trans.Sconto_KRW__c / trans.Prezzo_di_listino_KRW__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_AED__c != TransactionOld.get(trans.Id).Prezzo_di_listino_AED__c) || (TransactionNew.get(trans.Id).Prezzo_di_Vendita_AED__c != TransactionOld.get(trans.Id).Prezzo_di_Vendita_AED__c)) {
				trans.Sconto_AED__c  = (trans.Prezzo_di_listino_AED__c != 0 && trans.Prezzo_di_Vendita_AED__c <= trans.Prezzo_di_listino_AED__c) ? (trans.Prezzo_di_listino_AED__c - trans.Prezzo_di_Vendita_AED__c) : 0;
				trans.PSconto_AED__c = (trans.Prezzo_di_listino_AED__c > 0 && trans.Sconto_AED__c > 0) ? (trans.Sconto_AED__c / trans.Prezzo_di_listino_AED__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_PLN__c != TransactionOld.get(trans.Id).Prezzo_di_listino_PLN__c) || (TransactionNew.get(trans.Id).Prezzo_di_Vendita_PLN__c != TransactionOld.get(trans.Id).Prezzo_di_Vendita_PLN__c)) {
				trans.Sconto_PLN__c  = (trans.Prezzo_di_listino_PLN__c != 0 && trans.Prezzo_di_Vendita_PLN__c <= trans.Prezzo_di_listino_PLN__c) ? (trans.Prezzo_di_listino_PLN__c - trans.Prezzo_di_Vendita_PLN__c) : 0;
				trans.PSconto_PLN__c = (trans.Prezzo_di_listino_PLN__c > 0 && trans.Sconto_PLN__c > 0) ? (trans.Sconto_PLN__c / trans.Prezzo_di_listino_PLN__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_QAR__c != TransactionOld.get(trans.Id).Prezzo_di_listino_QAR__c) || (TransactionNew.get(trans.Id).Prezzo_di_Vendita_QAR__c != TransactionOld.get(trans.Id).Prezzo_di_Vendita_QAR__c)) {
				trans.Sconto_QAR__c  = (trans.Prezzo_di_listino_QAR__c != 0 && trans.Prezzo_di_Vendita_QAR__c <= trans.Prezzo_di_listino_QAR__c) ? (trans.Prezzo_di_listino_QAR__c - trans.Prezzo_di_Vendita_QAR__c) : 0;
				trans.PSconto_QAR__c = (trans.Prezzo_di_listino_QAR__c > 0 && trans.Sconto_QAR__c > 0) ? (trans.Sconto_QAR__c / trans.Prezzo_di_listino_QAR__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_SGD__c != TransactionOld.get(trans.Id).Prezzo_di_listino_SGD__c) || (TransactionNew.get(trans.Id).Prezzo_di_Vendita_SGD__c != TransactionOld.get(trans.Id).Prezzo_di_Vendita_SGD__c)) {
				trans.Sconto_SGD__c  = (trans.Prezzo_di_listino_SGD__c != 0 && trans.Prezzo_di_Vendita_SGD__c <= trans.Prezzo_di_listino_SGD__c) ? (trans.Prezzo_di_listino_SGD__c - trans.Prezzo_di_Vendita_SGD__c) : 0;
				trans.PSconto_SGD__c = (trans.Prezzo_di_listino_SGD__c > 0 && trans.Sconto_SGD__c > 0) ? (trans.Sconto_SGD__c / trans.Prezzo_di_listino_SGD__c)*100 : 0;
			}
			if((TransactionNew.get(trans.Id).Prezzo_di_listino_SAR__c != TransactionOld.get(trans.Id).Prezzo_di_listino_SAR__c) || (TransactionNew.get(trans.Id).Prezzo_di_Vendita_SAR__c != TransactionOld.get(trans.Id).Prezzo_di_Vendita_SAR__c)) {
				trans.Sconto_SAR__c  = (trans.Prezzo_di_listino_SAR__c != 0 && trans.Prezzo_di_Vendita_SAR__c <= trans.Prezzo_di_listino_SAR__c) ? (trans.Prezzo_di_listino_SAR__c - trans.Prezzo_di_Vendita_SAR__c) : 0;
				trans.PSconto_SAR__c = (trans.Prezzo_di_listino_SAR__c > 0 && trans.Sconto_SAR__c > 0) ? (trans.Sconto_SAR__c / trans.Prezzo_di_listino_SAR__c)*100 : 0;
			}
		}
	}

	// public static void updateDetailsAccount(Map<String,Transaction__c> transactionsMap){


	// 	// if(onTransactionTriggerHandler.blockTriggerMap.get('updateDetailsAccount') != null)
	// 	// 	return;

	// 	List<Transaction_Detail__c> tds = [SELECT Id,Transaction__c, Account__c FROM Transaction_Detail__c WHERE Transaction__c IN: transactionsMap.keySet()];

	// 	try{
	// 		for(Transaction_Detail__c td : tds) {

    //             String transactionId = td.Transaction__c;
    //             String accountId = transactionsMap.get(transactionId).Account__c;
    //             td.Account__c = accountId;

	// 		}

    //         update tds;


	// 	}
	// 	catch(Exception e) {
	// 		system.debug(e.getMessage());
	// 	}


	// 	// onTransactionTriggerHandler.blockTriggerMap.put('updateDetailsAccount','updateDetailsAccount');

	// }

}