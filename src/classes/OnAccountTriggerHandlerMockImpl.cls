@isTest
global class OnAccountTriggerHandlerMockImpl implements HttpCalloutMock {
    
    private Integer status_code;
    private String response;

    global OnAccountTriggerHandlerMockImpl(final String reponses, final Integer status_code){
        this.response = reponses;
        this.status_code = status_code;
    }

    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        
        // Return the next response in the list       
        res.setBody(response);
        res.setStatusCode(status_code);
        
        return res;
    }

}