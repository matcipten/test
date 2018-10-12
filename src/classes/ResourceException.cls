public class ResourceException extends Exception {
    
    public String code{get;set;}
    
    public ResourceException(String codice, String msg){
        this.setMessage(msg);
        code = codice;
    }

}