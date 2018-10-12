public interface CurrencyConverter{
	
	Decimal convert(Decimal valueToConvert, CurrencyType ct);

}