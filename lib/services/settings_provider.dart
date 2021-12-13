import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  late String _themeBrightness;
  late List<String> _newsSource;
  late bool _isArticleSaved;

  SettingsProvider() {
    _themeBrightness = "Light Mode";
    _newsSource = ["usa"];
    _isArticleSaved = false;

    loadPreferences();
  }

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

  void _setIsArticleSaved({required bool areArticlesSaved}) {
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

  //!SHARED PREFERENCES
  savePreferences() async {
    SharedPreferences _userPreference = await SharedPreferences.getInstance();
    _userPreference.setString("themeBrightness", _themeBrightness);
    _userPreference.setStringList("newsSource", _newsSource);
    _userPreference.setBool("savedArticles", _isArticleSaved);
  }

  loadPreferences() async {
    SharedPreferences _userPreference = await SharedPreferences.getInstance();
    String? _themeBrightness = _userPreference.getString("themeBrightness");
    List<String>? _newsSource = _userPreference.getStringList("newsSource");
    bool? _areArticlesSaved = _userPreference.getBool("savedArticles");

    if (_themeBrightness != null) {
      setThemeBrightness(themeBrightness: _themeBrightness);
    }

    if (_newsSource != null) _setNewsSource(newsSource: _newsSource);
    if (_areArticlesSaved != null) {
      _setIsArticleSaved(areArticlesSaved: _areArticlesSaved);
    }
  }
}
