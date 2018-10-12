global class SingleObjectResponseWrapper extends ResponseWrapper {
    public Boolean success{get;set;}
    public String message{get;set;}
    public Map<String, Object> data{get;set;}
    public List<ErrorWrapper> errors{get;set;}
}