import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:sertinews/services/settings_provider.dart';

class TheApiService extends SettingsProvider {
//!USED URI'S
  final Uri topStoriesFromUK = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=gb&category=general&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");
  final topStoriesFromUS = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");
  final topStoriesFromNG = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=ng&category=general&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");
  final storiesFromIphoneHacks = Uri.parse(
      "http://newsapi.org/v2/everything?domains=iphonehacks.com&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");
  final topStoriesFromWallStreetJournal = Uri.parse(
      "http://newsapi.org/v2/everything?domains=wsj.com&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");
  final topStoriesFromForbes = Uri.parse(
      "http://newsapi.org/v2/everything?domains=forbes.com&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");
  final topStoriesFromTechCrunch = Uri.parse(
      "http://newsapi.org/v2/everything?domains=techcrunch.com&apiKey=5a5b6a8c28fe47eeb02a821489e29aa2");

//! FETCH ARTICLES
  Future<List<TheNewsArticle>> fetchNewsArticles(
      {required String userSelectedSource}) async {
    Response theURIResponse = await get(
      (userSelectedSource == "usa")
          ? topStoriesFromUS
          : (userSelectedSource == "uk")
              ? topStoriesFromUK
              : (userSelectedSource == "nigeria")
                  ? topStoriesFromNG
                  : (userSelectedSource == "wsj")
                      ? topStoriesFromWallStreetJournal
                      : (userSelectedSource == "forbes")
                          ? topStoriesFromForbes
                          : (userSelectedSource == "techCrunch")
                              ? topStoriesFromTechCrunch
                              : (userSelectedSource == "iphoneHacks")
                                  ? storiesFromIphoneHacks
                                  : topStoriesFromUS,
    )
        .onError((error, stackTrace) =>
            throw ("RECEIVED ERROR: $error \n\nTRACE: $stackTrace"))
        .catchError((e) {
      debugPrint("API FETCH ERROR: $e");
    });

    if (theURIResponse.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(theURIResponse.body);

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
