import 'dart:async';
import 'package:http/http.dart' as http;

/// Used for easier REST requests
///
/// [baseUrl] has only to be specified once which reduces the amount of clutter in the code.
/// Url is automatically formatted
class RestRequest {
  String baseUrl;

  RestRequest({required this.baseUrl});

  Future<http.Response> httpGet(String path,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers}) async {
    return http
        .get(
          _getUri(path, queryParameters),
          headers: headers,
        )
        .timeout(const Duration(seconds: 5));
  }

  Uri _getUri(String path, Map<String, dynamic>? queryParameters) =>
      Uri.https(baseUrl, path, queryParameters);
}
