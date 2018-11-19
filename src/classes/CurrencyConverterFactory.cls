public with sharing class CurrencyConverterFactory {

	private static Map<String, CurrencyConverter> mapCurrencyConverter = new Map<String, CurrencyConverter>();
	static{
		mapCurrencyConverter.put('EUR', new ISOCode2EuroConverter());
		mapCurrencyConverter.put('BRL', new Euro2ISOCodeConverter());
		mapCurrencyConverter.put('CHF', new Euro2ISOCodeConverter());
		mapCurrencyConverter.put('CNY', new Euro2ISOCodeConverter());
		mapCurrencyConverter.put('CAD', new Euro2ISOCodeConverter());
		mapCurrencyConverter.put('GBP', new Euro2ISOCodeConverter());
		mapCurrencyConverter.put('HKD', new Euro2ISOCodeConverter());
		mapCurrencyConverter.put('USD', new Euro2ISOCodeConverter());
		mapCurrencyConverter.put('JPY', new Euro2ISOCodeConverter());
		mapCurrencyConverter.put('MOP', new Euro2ISOCodeConverter());
        mapCurrencyConverter.put('DKK', new Euro2ISOCodeConverter());
        mapCurrencyConverter.put('RUB', new Euro2ISOCodeConverter());
        mapCurrencyConverter.put('AUD', new Euro2ISOCodeConverter());
	}
	
	public static CurrencyConverter getCurrencyConverter(String currencyIsoCode){
		return mapCurrencyConverter.get(currencyIsoCode);
	}


}