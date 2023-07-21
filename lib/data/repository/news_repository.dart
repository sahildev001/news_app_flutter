// lib/data/repositories/news_repository.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/news_model.dart';

class NewsRepository {

  NewsRepository();

  Future<List<NewsModel>> fetchLatestNews({int page = 1, int pageSize = 10,required String apiKey}) async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&pageSize=$pageSize&page=$page&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print("response :: ${jsonData}");
      final newsList = jsonData['articles'] as List<dynamic>;
      return newsList.map((newsJson) => NewsModel(
        title: newsJson['title']??'',
        description: newsJson['description']??'',
        imageUrl: newsJson['urlToImage']??'',
        publishedAt: DateTime.parse(newsJson['publishedAt']),
        content: newsJson['content'] ?? '',
        url: newsJson['url']
      )).toList();
    } else {
      final jsonData = json.decode(response.body);
      throw Exception('Failed to load news ${jsonData}');
    }
  }
}
