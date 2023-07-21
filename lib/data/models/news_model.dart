// lib/data/models/news_model.dart

class NewsModel {
  final String title;
  final String description;
  final String imageUrl;
  final String url;
  final String content;
  final DateTime publishedAt;

  NewsModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.content,
    required this.publishedAt,
    required this.url
  });
}
