import 'package:flutter/material.dart';
import 'package:sertinews/pages/screens/news_page.dart';
import 'package:sertinews/pages/screens/saved_articles_page.dart';
import 'package:sertinews/pages/screens/settings_page.dart';

class SelectView extends StatelessWidget {
  final int pageNumber;
  const SelectView({Key? key, required this.pageNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pageNumber == 0
        ? const NewsFeed()
        : pageNumber == 1
            ? const SavedArticles()
            : const AppSettings();
  }
}
