import 'package:flutter/material.dart';
import 'package:sertinews/widgets/page_title.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        PageTitle(
          pageIcon: Icons.home_outlined ,
          pageTitle: "News Feed",
          titleColour: Color(0xFF006D77),
        )
      ],
    );
  }
}
