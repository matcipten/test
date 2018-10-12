public class ISOCode2EuroConverter implements CurrencyConverter {

	public Decimal convert(Decimal valueToConvert, CurrencyType ct){
		System.debug('CurrencyType ' + ct);

		Decimal result = valueToConvert * ct.ConversionRate;

		System.debug('CurrencyType result: ' + result);

		result = result.setScale(ct.DecimalPlaces);

	 	return result;
	}
	
}