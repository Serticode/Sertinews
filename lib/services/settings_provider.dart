import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  late String _themeBrightness;
  late List<String> _newsSource;
  late bool _isArticleSaved;
  late List<String> _theSavedArticles;

  SettingsProvider() {
    _themeBrightness = "Light Mode";
    _newsSource = ["usa"];
    _isArticleSaved = false;
    _theSavedArticles = [];

    loadPreferences();
  }

  //!EXPERIMENT STARTS
  void saveArticleByObject({required TheNewsArticle theNewsArticleObject}) {
    //!CONVERT OBJECT TO MAP AND MAP TO A USABLE STRING. SAVE CONVERTED STRING INTO A LIST.
    //!SAVE ARTICLE LIST INTO SHARED PREFERENCES AFTER NOTIFYING LISTENERS.

    _theSavedArticles.add(
      jsonEncode(
        _convertTheArticleData(theNewsArticleObject: theNewsArticleObject),
      ),
    );
    notifyListeners();
    savePreferences();
  }

  //!OBJECT CONVERTER.
  Map<String, dynamic> _convertTheArticleData(
      {required TheNewsArticle theNewsArticleObject}) {
    //!DEFINE DATA HOLDER AND RETURN GOTTEN DATA AS STRING.

    Map<String, dynamic> newsArticleData = {
      "theSource": {
        "id": theNewsArticleObject.theSource.id,
        "name": theNewsArticleObject.theSource.name,
      },
      "author": theNewsArticleObject.author,
      "title": theNewsArticleObject.title,
      "description": theNewsArticleObject.description,
      "url": theNewsArticleObject.url,
      "urlToImage": theNewsArticleObject.urlToImage,
      "publishedAt": theNewsArticleObject.publishedAt,
      "content": theNewsArticleObject.content,
    };

    return newsArticleData;
  }

  //!CONVERT SAVED ARTICLES INTO THE NEWS ARTICLE FORMAT.
  List<TheNewsArticle> fetchSavedArticlesList() {
    List<TheNewsArticle> newsArticleData = [];
    for (String element in _theSavedArticles) {
      Map<String, dynamic> theJSON = jsonDecode(element);
      newsArticleData.add(TheNewsArticle.fromJson(theJSON));
    }
    return newsArticleData;
  }

  removeSavedArticle({required TheNewsArticle theArticleToBeRemoved}) {
    List<String> toBeRemoved = [];
    for (String element in _theSavedArticles) {
      if (element.contains(theArticleToBeRemoved.url) &&
          element.contains(theArticleToBeRemoved.title) &&
          element.contains(theArticleToBeRemoved.description)) {
        toBeRemoved.add(element);
      }
    }
    _theSavedArticles.removeWhere((item) => toBeRemoved.contains(item));
    notifyListeners();
    savePreferences();
  }

  //! EXPERIMENT ENDS

  //!GETTERS
  String get theThemeBrightness => _themeBrightness;
  List<String> get theNewsSource => _newsSource;
  bool get isTheArticleSaved => _isArticleSaved;

  //!SETTERS
  void setThemeBrightness({required String themeBrightness}) {
    _themeBrightness = themeBrightness;
    notifyListeners();
    savePreferences();
  }

  void _setNewsSource({required List<String> newsSource}) {
    _newsSource = newsSource;
    notifyListeners();
  }

  void setIsArticleSaved({required bool areArticlesSaved}) {
    _isArticleSaved = areArticlesSaved;
    notifyListeners();
    savePreferences();
  }

  void addNewsSource({required String chosenNewsSource}) {
    if (_newsSource.contains(chosenNewsSource) == false) {
      _newsSource.add(chosenNewsSource);
      notifyListeners();
      savePreferences();
    }
  }

  void removeNewsSource({required String theNewsSource}) {
    if (_newsSource.contains(theNewsSource) == true) {
      _newsSource.remove(theNewsSource);
      notifyListeners();
      savePreferences();
    }
  }

  void _setTheSavedArticlesList(
      {required List<String> theListOfSavedArticles}) {
    _theSavedArticles = theListOfSavedArticles;
    notifyListeners();
  }

  //!SHARED PREFERENCES
  savePreferences() async {
    SharedPreferences _userPreference = await SharedPreferences.getInstance();
    _userPreference.setString("themeBrightness", _themeBrightness);
    _userPreference.setStringList("newsSource", _newsSource);
    _userPreference.setBool("areArticlesSaved", _isArticleSaved);
    _userPreference.setStringList("theSavedArticles", _theSavedArticles);
  }

  loadPreferences() async {
    SharedPreferences _userPreference = await SharedPreferences.getInstance();
    String? _themeBrightness = _userPreference.getString("themeBrightness");
    List<String>? _newsSource = _userPreference.getStringList("newsSource");
    bool? _areArticlesSaved = _userPreference.getBool("savedArticles");
    List<String>? _theSavedArticles =
        _userPreference.getStringList("theSavedArticles");

    if (_themeBrightness != null) {
      setThemeBrightness(themeBrightness: _themeBrightness);
    }

    if (_newsSource != null) _setNewsSource(newsSource: _newsSource);
    if (_areArticlesSaved != null) {
      setIsArticleSaved(areArticlesSaved: _areArticlesSaved);
    }
    if (_theSavedArticles != null) {
      _setTheSavedArticlesList(theListOfSavedArticles: _theSavedArticles);
    }
  }
}
