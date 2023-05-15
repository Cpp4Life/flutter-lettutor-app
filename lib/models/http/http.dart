import '../../config/index.dart';

class Http {
  static Map<String, String> getHeaders({required String token}) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Origin': Config.origin,
    };
  }
}
