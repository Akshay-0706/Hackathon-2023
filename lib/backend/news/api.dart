import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';

class NewsApi {
  static Future<NewsData?> getNews() async {
    try {
      final uri = Uri.parse(
          'https://newsapi.org/v2/everything?q=SDG&from=2023-01-04&language=en&sortBy=publishedAt&apiKey=c939257a6df04d6e8dbfb99ee1aa0842');

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return NewsData.fromJson(jsonDecode(response.body));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }
}
