public without sharing class CurrencyUtils {

	 public static void convertCurrency(Transaction_Detail__c obj){
            String currencyIsoCode =  (String)obj.get('CurrencyIsoCode');

            System.debug('currencyIsoCode: ' + currencyIsoCode);

            if(!CurrencyUtils.isValidCurrency(currencyIsoCode)){
                throw new GenericException(Label.ERR_0002, Label.MSG_DATA_NOT_VALID + ' - CurrencyIsoCode');
            }   

            List<CurrencyType> cts = [Select c.IsoCode, c.IsActive, c.Id, c.DecimalPlaces, c.ConversionRate From CurrencyType c
			];

			Map<String, CurrencyType> ctMap = new Map<String, CurrencyType>();

			for(CurrencyType ct: cts){
				ctMap.put(ct.isoCode, ct);
			}

            System.debug('ctMap:' + ctMap);

            CurrencyConverter converter = CurrencyConverterFactory.getCurrencyConverter(currencyIsoCode);
            CurrencyConverter euroConverter = CurrencyConverterFactory.getCurrencyConverter('EUR');

            System.debug('converter:' + converter);
            System.debug('obj:' + obj);
            System.debug('obj.get(Prezzo_di_Listino__c):' + obj.get('Prezzo_di_Listino__c'));
            System.debug('obj.get(Prezzo_di_Vendita__c):' + obj.get('Prezzo_di_Vendita__c'));

            Decimal prezzoListinoEuroValue = converter.convert((Decimal)obj.get('Prezzo_di_Listino__c'), ctMap.get(currencyIsoCode));
            Decimal prezzoVenditaEuroValue = converter.convert((Decimal)obj.get('Prezzo_di_Vendita__c'), ctMap.get(currencyIsoCode));


            for(String isoCode : new List<String>{'BRL', 'CHF', 'CNY', 'CAD', 'EUR', 'GBP', 'HKD', 'USD', 'JPY', 'MOP', 'AUD', 'DKK', 'RUB','AED','QAR','SAR'}){

                if(prezzoListinoEuroValue != null){
                    Decimal prezzoListinoConverted = euroConverter.convert(prezzoListinoEuroValue, ctMap.get(isoCode));
                    Decimal value = currencyIsoCode.equals(isoCode) ? (Decimal)obj.get('Prezzo_di_Listino__c') :  prezzoListinoConverted;
                    obj.put('Prezzo_di_listino_' + isoCode + '__c', value);
                }

                if(prezzoVenditaEuroValue != null){
                    Decimal prezzoVenditaConverted = euroConverter.convert(prezzoVenditaEuroValue, ctMap.get(isoCode));
                    Decimal value = currencyIsoCode.equals(isoCode) ? (Decimal)obj.get('Prezzo_di_Vendita__c') :  prezzoVenditaConverted;
                    obj.put('Prezzo_di_vendita_' + isoCode + '__c', value);
                }
            }

        }

    public static Boolean isValidCurrency(String curr){
            Schema.DescribeFieldResult fieldResult = CurrencyType.IsoCode.getDescribe();
            List<Schema.PicklistEntry> lple = fieldResult.getPicklistValues();

            if(String.isBlank(curr)){
                return false;
            }

            for(Schema.PicklistEntry ple : lple){
                if(!ple.isActive()){
                    continue;
                }

                if(ple.getValue().trim() == curr){
                    return true;
                }
            }

            return false;
        }

}