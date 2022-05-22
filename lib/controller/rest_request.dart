import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Used for easier REST requests
///
/// [baseUrl] has only to be specified once which reduces the amount of clutter in the code.
/// Url is automatically formatted
class RestRequest {
  String baseUrl;
  RestRequest({required this.baseUrl});

  Future<http.Response> httpGet( {required String path,
  Map<String, dynamic>? queryParameters,
  Map<String, String>? headers}) async {
    var client=http.Client();
    return client
        .get(
          _getUri(path,queryParameters),
          headers: headers,
        ).then((response){
          print(response.body);
          client.close();
          return response;
    })
        .timeout(const Duration(seconds: 5));
  }

  Future<http.Response> httpDelete({required String path,
  Map<String,dynamic>?queryParameters,
    Map<String, String>? headers})async {
    return http.delete(
      _getUri(path,queryParameters),
      headers: headers,
    ).
    timeout(const Duration(seconds: 5));
  }


  Future<dynamic> httpPost({required String path,
  Map<String, dynamic>? queryParameters,
  Map<String, String>? headers}) async
  {
    var client=http.Client();
    return client
        .post(
        _getUri(path),
      headers: headers,
      body: jsonEncode(queryParameters),
    ).then((response){
      client.close();
      return response;
    })
        .timeout(const Duration(seconds: 5));
  }


  Future<http.Response> httpPut({required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  required Map<String,dynamic> data})async
  {
    return http.put(_getUri(path,queryParameters),
    headers: headers,
      body: jsonEncode(data)
    )
        .timeout(const Duration(seconds: 5));

  }






  Uri _getUri(String path, [Map<String, dynamic>? queryParameters]) =>
      Uri.https(baseUrl, path, queryParameters);

}
