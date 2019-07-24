@RestResource(urlMapping='/Transaction_Detail_v1.0/*')
global without sharing class RestTransactionDetail {


	@HttpPost
	global static ResponseWrapper doPost(Transaction_Detail__c dettaglioTransazione) {
		return new RestTransactionDetailHandler().doPostHandler(dettaglioTransazione);
	}

	@HttpGet
	global static ResponseWrapper doGet() {
		return new RestTransactionDetailHandler().doGetHandler(RestContext.request, RestContext.response);
	}

	@HttpPut
	global static ResponseWrapper doPatch(Transaction_Detail__c dettaglioTransazione) {
		return new RestTransactionDetailHandler().doPatchHandler(dettaglioTransazione);
	}

	public static Transaction_Detail__c getTransactionDetailById(String id){
		return (Transaction_Detail__c)GenericDao.getAllFieldsResultById('Transaction_Detail__c', 'Key__c', id);
	}

	public class RestTransactionDetailHandler extends ProvaHandler {
		public Override Object get(RestRequest req,  RestResponse res){
			String reqUri = req.requestURI.substring(1);

			String[] arr = reqUri.split('\\/');
			Integer arrSize = arr.size();
			String service = arr[0];
			String id = arrSize > 1 ? arr[1] : null;
			String relatedResource = arrSize > 2 ? arr[2] : null;
			String idRelatedResource = arrSize > 3 ? arr[3] : null;

			Transaction_Detail__c a = RestTransactionDetail.getTransactionDetailById(id);
			Map<String, Object> m = a == null ? null : a.getPopulatedFieldsAsMap();

			return m;
		}

		public Override SObject beforeUpdate(RestRequest req,  RestResponse res, SObject obj){
			String reqUri = req.requestURI.substring(1);

			String[] arr = reqUri.split('\\/');
			Integer arrSize = arr.size();
			String service = arr[0];
			String id = arrSize > 1 ? arr[1] : null;
			String relatedResource = arrSize > 2 ? arr[2] : null;
			String idRelatedResource = arrSize > 3 ? arr[3] : null;

			List<Transaction_Detail__c> result = [
				Select m.Id
				From Transaction_Detail__c m
				WHERE Id = :id
			];

			if(result != null && !result.isEmpty()) {
				Transaction_Detail__c m = result.get(0);
				obj.id = m.id;

				// TEN@ 2017-10-11
				System.debug('TEN@obj.get(\'Stato_Reso_Cambio_Ecommerce__c\') : ' +
				             obj.get('Stato_Reso_Cambio_Ecommerce__c'));
				System.debug('TEN@obj.get(\'Status__c\') : ' + obj.get('Status__c'));
				if(obj.get('Stato_Reso_Cambio_Ecommerce__c')=='REFUSED' || obj.get('Status__c')=='CANCELLED') {
					System.debug('TEN@ : Ricalcolo currency');
					CurrencyUtils.convertCurrency((Transaction_Detail__c)obj);
				}
				// TEN@ 2017-10-11

				// TEN@ 2017-12-20 (SALESFORCE-81)
				GetDescrizioneFromCodice(obj);
				// TEN@ 2017-12-20 (SALESFORCE-81)



			} else {
				throw new ResourceException(Label.ERR_0002, Label.MSG_DATA_NOT_FOUND + ' - Id');
			}

			return obj;
		}

		public Override ResponseWrapper afterUpdateResponse(RestRequest req,  RestResponse res, SObject obj){
			return null;
		}

		public Override Boolean beforeInsert(SObject obj){
			CurrencyUtils.convertCurrency((Transaction_Detail__c)obj);

			// TEN@ 2017-12-20 (SALESFORCE-81)
			GetDescrizioneFromCodice(obj);
			// TEN@ 2017-12-20 (SALESFORCE-81)

			//PN20190121
			//fillAccount(obj);

			return true;
		}


		public Override SObject afterInsert(SObject obj){
			return obj;
		}

		public Override String getObjectName(){
			return 'dettaglioTransazione';
		}

		//fill account on detail
		//PN20190121
		/*public void fillAccount(SObject obj){
			String transactionId = (String)obj.get('Transaction__c');
			if(transactionId != null && transactionId != '') {
				Transaction__c transazione;
				Account account;
				List<Transaction__c> transactions = [SELECT Id,Account__c FROM Transaction__c WHERE Id = :transactionId];
				if(transactions != null && transactions.size() > 0) {
					transazione = transactions.get(0);
					String accountId = transazione.Account__c;
					if(accountId != null && accountId != '') {
						//obj.put('Account__c',accountId);
					}
				}
			}

		}*/

		// TEN@ 2017-12-20 (SALESFORCE-81)
		public void GetDescrizioneFromCodice(SObject obj){

			list<Tabelle_di_Sistema__c> ListTabella = new list<Tabelle_di_Sistema__c>();

			if( obj.get('Motivazione_Reso__c')!='' ||
			    obj.get('Motivazione_Reso__c')!=null) {

				ListTabella = [ Select Motivazioni_di_Reso__c
				                from Tabelle_di_Sistema__c
				                where Codice__c =:string.valueOf(obj.get('Motivazione_Reso__c'))];

				if(ListTabella.size()==1) {
					obj.put('Motivazione_Reso__c', ListTabella[0].Motivazioni_di_Reso__c);
				}

			}

		}
		// TEN@ 2017-12-20 (SALESFORCE-81)

	}



}