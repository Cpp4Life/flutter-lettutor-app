import 'package:flutter_dotenv/flutter_dotenv.dart';

class Http {
  static Map<String, String> getHeaders({required String token}) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'Origin': dotenv.env['ORIGIN'] as String,
    };
  }
}
