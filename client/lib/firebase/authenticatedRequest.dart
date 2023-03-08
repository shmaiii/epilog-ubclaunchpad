import './auth.dart';
import 'package:http/http.dart' as http;

class AuthenticatedRequest {
  static Future<http.Response> get({required String url}) async {
    String uid = await Auth().currentUser?.getIdToken() ?? 'none';
    return http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + uid,
    });
  }
}
