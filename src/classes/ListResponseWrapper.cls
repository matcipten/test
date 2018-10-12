global class ListResponseWrapper extends ResponseWrapper{
    
    public List<sObject> data{get;set;} 
    public Integer totalSize{get;set;}
    public Integer page{get;set;}
    public Integer pageSize{get;set;}
    public Boolean success{get;set;}
    public String message{get;set;}
    public List<ErrorWrapper> errors{get;set;}
}