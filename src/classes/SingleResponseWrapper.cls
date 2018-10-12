global class SingleResponseWrapper extends ResponseWrapper {
    public Boolean success{get;set;}
    public String message{get;set;}
    public Map<String, SObject> data{get;set;}
    public List<ErrorWrapper> errors{get;set;}
}