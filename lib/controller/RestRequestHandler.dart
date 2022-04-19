


import '../model/rest_request.dart';

class RestRequestHandler{
  static final RestRequestHandler _restRequestHandler=RestRequestHandler._createRestRequestHandler();

   final RestRequest databaseRestrequest=RestRequest(baseUrl: 'a21iot13.studev.groept.be');

  RestRequestHandler._createRestRequestHandler();

  factory  RestRequestHandler()=>_restRequestHandler;

}