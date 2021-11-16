import 'dart:convert';
import 'dart:core';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:sertinews/models/news_article_model.dart';

class TheApiService {
  final Uri topStoriesFromUK = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=gb&category=general&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");
  final topStoriesFromUS = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");
  final storiesFromIphoneHacks = Uri.parse(
      "http://newsapi.org/v2/everything?domains=iphonehacks.com&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");

  Future<List<TheNewsArticle>> fetchNewsArticles() async {
    Response theURIResponse = await get(storiesFromIphoneHacks);
    if (theURIResponse.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(theURIResponse.body);
      debugPrint("THE URI RESPONSE: $json");

      List<dynamic> theURIBody = json["articles"];

      List<TheNewsArticle> newsArticles = theURIBody
          .map((dynamic newsItem) => TheNewsArticle.fromJson(newsItem))
          .toList();

      return newsArticles;
    } else {
      throw ("Cannot fetch the articles");
    }
  }
}
