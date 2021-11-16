import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:sertinews/services/news_api_service.dart';
import 'package:sertinews/widgets/custom_news_container.dart';
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
            List<TheNewsArticle>? newsArticles = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const PageTitle(
                  pageIcon: Icons.home_outlined,
                  pageTitle: "News Feed",
                  titleColour: Color(0xFF006D77),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: newsArticles!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomNewsContainer(
                            theNewsArticle: newsArticles[index],
                            thePageColour: const Color(0xFF006D77),
                          );
                        })),
              ],
            );
          }
          //!SPIN KIT FOR WHEN DATA HAS NOT BEEN FETCHED.
          else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                PageTitle(
                  pageIcon: Icons.home_outlined,
                  pageTitle: "News Feed",
                  titleColour: Color(0xFF006D77),
                ),
                Expanded(
                  child: SpinKitDoubleBounce(
                    color: Color(0xFF006D77),
                    size: 100.0,
                  ),
                ),
              ],
            );
          }
        });
  }
}
