import 'dart:convert';

import 'package:hackathon/frontend/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsApi {
  static Future<NewsData?> getNews() async {
    try {
      final uri = Uri.parse(
          'https://newsapi.org/v2/everything?q=eco-friendly&from=2023-01-04&language=en&sortBy=publishedAt&apiKey=c939257a6df04d6e8dbfb99ee1aa0842');

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
