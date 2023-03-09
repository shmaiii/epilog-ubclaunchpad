import './auth.dart';
import 'package:http/http.dart' as http;

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
}
