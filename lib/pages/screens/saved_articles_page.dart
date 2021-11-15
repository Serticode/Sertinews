import 'package:flutter/material.dart';
import 'package:sertinews/widgets/page_title.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({Key? key}) : super(key: key);

  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        PageTitle(
          pageIcon: Icons.bookmark_add_outlined,
          pageTitle: "Saved Articles",
          titleColour: Color(0xFF4D194D),
        )
      ],
    );
  }
}
