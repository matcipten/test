@isTest
global class WebServiceCloseCaseMockImpl implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {

      System.debug('stub:' + stub);
      System.debug('request:' + request);
      System.debug('request body:' + ((HttpRequest)request).getBody());

       response.put('response_x', 'response_x');
   }
}