import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:sertinews/services/news_api_service.dart';
import 'package:sertinews/widgets/custom_other_news_container.dart';
import 'package:sertinews/widgets/custom_top_news_container.dart';
import 'package:sertinews/widgets/page_title.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  final TheApiService _fetchNewsAPI = TheApiService();
  final int breakNewsCount = 5;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchNewsAPI.fetchNewsArticles(),
        builder: (BuildContext context,
            AsyncSnapshot<List<TheNewsArticle>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<TheNewsArticle>? newsArticles = snapshot.data;
            List<TheNewsArticle>? extractedNewsArticles = [];
            extractedNewsArticles
                .addAll(newsArticles!.getRange(6, newsArticles.length));

            //!GET THE REST NUMBER OF ARTICLES
            //!FROM POSITION 5 TILL END, AS THE FIRST 5
            //!IS SHOWN IN CUSTOM TOP NEWS CONTAINER

            return CustomScrollView(
              slivers: <Widget>[
                PageTitle(
                  pageTitle: "SertiNews",
                  titleColour: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFF006D77)
                      : Colors.white,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    //!TOP FIVE NEWS ARTICLES
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38.withOpacity(0.2),
                            offset: const Offset(
                              0.0,
                              15.0,
                            ),
                            blurRadius: 70.0,
                            spreadRadius: 0.1,
                          ), //BoxShadow
                        ],
                      ),
                      height: MediaQuery.of(context).size.height / 1.8,
                      child: PageView.builder(
                          itemCount: breakNewsCount,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomTopNewsContainer(
                              theNewsArticle: newsArticles[index],
                              thePageColour: const Color(0xFF006D77),
                              pageIndex: index,
                              numberOfPages: breakNewsCount,
                            );
                          }),
                    ),

                    //!OTHER NEWS ARTICLES
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 30.0,
                        horizontal: 10.0,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      height: MediaQuery.of(context).size.height / 14,
                      child: Text("Other News",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black87.withOpacity(0.7)
                                    : Colors.grey.shade300,
                              )),
                    ),
                  ]),
                ),
                SliverStaggeredGrid.countBuilder(
                  itemCount: extractedNewsArticles.length,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 0.0,
                  staggeredTileBuilder: (index) => StaggeredTile.count(
                      (index % 5 == 0) ? 2 : 1, (index % 5 == 0) ? 2 : 1),
                  itemBuilder: (BuildContext context, otherNewsIndex) {
                    return CustomOtherNewsContainer(
                      theNewsArticle: extractedNewsArticles[otherNewsIndex],
                      pageIndex: otherNewsIndex,
                      imageUrl:
                          extractedNewsArticles[otherNewsIndex].urlToImage,
                    );
                  },
                ),
              ],
            );
          } else {
            //!SPIN KIT FOR WHEN DATA HAS NOT BEEN FETCHED.
            return NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  PageTitle(
                    pageTitle: "SertiNews",
                    titleColour:
                        Theme.of(context).brightness == Brightness.light
                            ? const Color(0xFF006D77)
                            : Colors.white,
                  ),
                ];
              },
              body: const SpinKitDoubleBounce(
                color: Color(0xFF006D77),
                size: 100.0,
              ),
            );
          }
        });
  }
}
