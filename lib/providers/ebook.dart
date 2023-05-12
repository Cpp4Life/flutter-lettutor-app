import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/index.dart';
import '../models/index.dart';
import '../services/index.dart';

class EbookProvider with ChangeNotifier {
  final String _baseURL = dotenv.env['BASE_URL'] as String;
  final String? _authToken;

  List<Ebook> _ebooks = [];

  List<Ebook> get ebooks {
    return [..._ebooks];
  }

  EbookProvider(this._authToken, this._ebooks);

  Future fetchAndSetEbooksWithPagination({
    required int page,
    required int size,
    String q = '',
    String categoryId = '',
  }) async {
    try {
      // * e.g: GET https://domain.com/e-book?page=#&size=#
      // * e.g: GET https://domain.com/e-book?page=#&size=#&q=""
      // * e.g: GET https://domain.com/e-book?page=#&size=#&categoryId[]=""
      // * e.g: GET https://domain.com/e-book?page=#&size=#&q=""&categoryId[]=""
      String urlBuilder = '$_baseURL/e-book?page=$page&size=$size';
      if (q.isNotEmpty) {
        urlBuilder += '&q=$q';
      }
      if (categoryId.isNotEmpty) {
        urlBuilder += '&categoryId[]=$categoryId';
      }

      final url = Uri.parse(urlBuilder);
      final headers = Http.getHeaders(token: _authToken as String);
      final response = await http.get(url, headers: headers);
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 400) {
        throw HttpException(decodedResponse['message']);
      }
      final jsonList = decodedResponse['data']['rows'] as List<dynamic>;
      _ebooks = Generic.fromJSON<List<Ebook>, Ebook>(jsonList);
      notifyListeners();
    } catch (e) {
      await Analytics.crashEvent(
        'fetchAndSetEbooks',
        exception: e.toString(),
        fatal: true,
      );
      rethrow;
    }
  }
}
