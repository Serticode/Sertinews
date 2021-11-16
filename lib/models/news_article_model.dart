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

//! CONSTRUCTOR TO INITIALIZE CLASS MEMBERS.
  TheNewsArticle(
      {required this.theSource,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

//! CREATE / MAP - INTERFACE / ARTICLE PATTERN FROM JSON.
  factory TheNewsArticle.fromJson(Map<String, dynamic> json) {
    return TheNewsArticle(
      theSource: NewsSource.fromJson(json["source"]),
      author: json["author"] ?? "Unknown Author",
      title: json["title"] ?? "My News",
      description: json["description"] ?? "",
      url: json["url"] ?? "",
      urlToImage: json["urlToImage"] ?? "",
      publishedAt: json["publishedAt"] ?? "",
      content: json["content"] ?? "",
    );
  }
}
