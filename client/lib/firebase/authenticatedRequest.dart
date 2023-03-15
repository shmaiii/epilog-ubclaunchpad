import 'dart:convert';
import './auth.dart';
import 'package:http/http.dart' as http;

// Wrapped http request functions that will automatically attach a JWT
// that holds the userID of the signed-in firebase user. These functions
// should ONLY BE CALLED IN SCREENS THAT APPEAR AFTER THE LOGIN/SIGNUP SCREENS.
class AuthenticatedRequest {
  static final Map<String, String> _defaultHeader = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static Future<http.Response> get(
      {required Uri url, Map<String, String>? headers}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.get(url, headers: headersWithAuth);
  }

  static Future<http.Response> post(
      {required Uri url,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.post(url,
        headers: headersWithAuth, body: body, encoding: encoding);
  }

  static Future<http.Response> put(
      {required Uri url,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.put(url,
        headers: headersWithAuth, body: body, encoding: encoding);
  }

  static Future<http.Response> delete(
      {required Uri url,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.delete(url,
        headers: headersWithAuth, body: body, encoding: encoding);
  }
}
