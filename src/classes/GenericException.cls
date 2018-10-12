public class GenericException extends Exception{
    
    public String code{get;set;}
    
    public GenericException(String codice, String msg){
        this.setMessage(msg);
        code = codice;
    }
    
}