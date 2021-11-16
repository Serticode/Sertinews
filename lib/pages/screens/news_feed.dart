import 'package:flutter/material.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:sertinews/services/news_api_service.dart';
import 'package:sertinews/widgets/page_title.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final TheApiService _fetchNewsAPI = TheApiService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchNewsAPI.fetchNewsArticles(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TheNewsArticle>> snapshot) {
          if (snapshot.hasData) {
            debugPrint("The Received data is: ${snapshot.data} ");
            return Column(
              children: const <Widget>[
                PageTitle(
                  pageIcon: Icons.home_outlined,
                  pageTitle: "News Feed",
                  titleColour: Color(0xFF006D77),
                ),
                Text("DATA RECEIVED")
              ],
            );
          } else {
            return Column(
              children: const <Widget>[
                PageTitle(
                  pageIcon: Icons.home_outlined,
                  pageTitle: "News Feed",
                  titleColour: Color(0xFF006D77),
                ),
                CircularProgressIndicator(),
              ],
            );
          }
        });
  }
}
