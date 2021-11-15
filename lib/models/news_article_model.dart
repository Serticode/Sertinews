import 'package:sertinews/models/news_source_model.dart';

class TheNewsArticle {
  NewsSource theSource;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  TheNewsArticle(
      {required this.theSource,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  factory TheNewsArticle.fromJson(Map<String, dynamic> json) {
    return TheNewsArticle(
      theSource: NewsSource.fromJson(json["source"]),
      author: json["author"] as String,
      title: json["title"] as String,
      description: json["description"] as String,
      url: json["url"] as String,
      urlToImage: json["urlToImage"] as String,
      publishedAt: json["publishedAt"] as String,
      content: json["content"] as String,
    );
  }
}
