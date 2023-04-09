import 'dart:convert';
import './auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'
    show TargetPlatform, debugPrint, defaultTargetPlatform;

// Wrapped http request functions that will automatically attach a JWT
// that holds the userID of the signed-in firebase user. These functions
// should ONLY BE CALLED IN SCREENS THAT APPEAR AFTER THE LOGIN/SIGNUP SCREENS.
class AuthenticatedRequest {
  static final Map<String, String> _defaultHeader = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // This function is used to set user location in AuthObject after the first initial signin/signup. Afterwards,
  // it just returns the non-empty user location in AuthObject. Is this an awful way to set
  // client's location after signin/signup? Yes. Is there any other way? ¯\_(ツ)_/¯
  static Future<String> _getUserLocation(
      String authorizationHeaderString) async {
    if (AuthObject.getUserLocation == '') {
      final response = await http.get(
          Uri.parse('$_host/noLocation/get-user-location'),
          headers: {'Authorization': authorizationHeaderString});
      final jsonResponse = jsonDecode(response.body);
      AuthObject.setLocation(jsonResponse['location'] ?? '');
    }

    return AuthObject.getUserLocation;
  }

  static final String _host = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:8080'
      : 'http://localhost:8080';

  static Future<http.Response> get(
      {required String path, Map<String, String>? headers}) async {
    String uid = await AuthObject.currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';
    headersWithAuth['user-location'] = await _getUserLocation('Bearer $uid');

    return http.get(Uri.parse(_host + path), headers: headersWithAuth);
  }

  static Future<http.Response> post(
      {required String path,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await AuthObject.currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';
    headersWithAuth['user-location'] = await _getUserLocation('Bearer $uid');

    debugPrint(_host + path);
    return http.post(Uri.parse(_host + path),
        headers: headersWithAuth, body: body, encoding: encoding);
  }

  static Future<http.Response> put(
      {required String path,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await AuthObject.currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';
    headersWithAuth['user-location'] = await _getUserLocation('Bearer $uid');

    return http.put(Uri.parse(_host + path),
        headers: headersWithAuth, body: body, encoding: encoding);
  }

  static Future<http.Response> patch(
      {required String path,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await AuthObject.currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';
    headersWithAuth['user-location'] = await _getUserLocation('Bearer $uid');

    return http.patch(Uri.parse(_host + path),
        headers: headersWithAuth, body: body, encoding: encoding);
  }

  static Future<http.Response> delete(
      {required String path,
      Map<String, String>? headers,
      Object? body,
      Encoding? encoding}) async {
    String uid = await AuthObject.currentUser?.getIdToken() ?? 'none';
    Map<String, String> headersWithAuth = headers ?? _defaultHeader;
    headersWithAuth['Authorization'] = 'Bearer $uid';
    headersWithAuth['user-location'] = await _getUserLocation('Bearer $uid');

    return http.delete(Uri.parse(_host + path),
        headers: headersWithAuth, body: body, encoding: encoding);
  }
}
