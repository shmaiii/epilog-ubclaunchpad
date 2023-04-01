import 'dart:convert';
import './auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

// Wrapped http request functions that will automatically attach a JWT
// that holds the userID of the signed-in firebase user. These functions
// should ONLY BE CALLED IN SCREENS THAT APPEAR AFTER THE LOGIN/SIGNUP SCREENS.
class AuthenticatedRequest {
  static final Map<String, String> _defaultHeader = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  static final String _host = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:8080'
      : 'http://localhost:8080';

  static Future<http.Response> get(
      {required String path, Map<String, String>? headers}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.get(Uri.parse(_host + path), headers: headersWithAuth);
  }

  static Future<http.Response> post(
      {required String path,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.post(Uri.parse(_host + path),
        headers: headersWithAuth, body: body, encoding: encoding);
  }

  static Future<http.Response> put(
      {required String path,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.put(Uri.parse(_host + path),
        headers: headersWithAuth, body: body, encoding: encoding);
  }

  static Future<http.Response> patch(
      {required String path,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.patch(Uri.parse(_host + path),
        headers: headersWithAuth, body: body, encoding: encoding);
  }

  static Future<http.Response> delete(
      {required String path,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';

    return http.delete(Uri.parse(_host + path),
        headers: headersWithAuth, body: body, encoding: encoding);
  }
}
