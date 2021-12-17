import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:sertinews/pages/screens/show_article_screen.dart';

class CustomTopNewsContainer extends StatelessWidget {
  final TheNewsArticle theNewsArticle;
  final Color thePageColour;
  final int pageIndex;
  final int numberOfPages;
  const CustomTopNewsContainer({
    Key? key,
    required this.theNewsArticle,
    required this.thePageColour,
    required this.pageIndex,
    required this.numberOfPages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //!MAIN CONTAINER.
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) =>
                  ShowArticle(theNewsArticle: theNewsArticle , fromPageTitle: 'News Feed')),
        );
      },
      child: Hero(
        tag: theNewsArticle.urlToImage == ""
            ? "newsImage_${theNewsArticle.title}"
            : "newsImage_${theNewsArticle.urlToImage}",
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 15.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: Colors.white,
            image: DecorationImage(
              image: theNewsArticle.urlToImage == ""
                  ? const AssetImage("assets/fallback_news_image_resized.png")
                  : CachedNetworkImageProvider(theNewsArticle.urlToImage)
                      as ImageProvider, //NetworkImage(theNewsArticle.urlToImage),
              fit: BoxFit.fitHeight,
            ),
          ),
          //!INNER CONTAINER
          child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Container(
              alignment: AlignmentDirectional.bottomCenter,
              height: (MediaQuery.of(context).size.height / 1.8) / 2,
              decoration: BoxDecoration(
                color: Colors.black54.withOpacity(0.4),
                borderRadius: const BorderRadius.all(Radius.circular(40.0)),
              ),
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //!ARTICLE TITLE
                  Text(
                    theNewsArticle.title.length > 85
                        ? theNewsArticle.title.replaceRange(
                            86, theNewsArticle.title.length, " ...")
                        : theNewsArticle.title + " ...",
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 28.0,
                          color: Colors.grey.shade200,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),

                  const SizedBox(height: 8.0),
                  //!ARTICLE AUTHOR  / DATE ROW
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      //!ARTICLE AUTHOR
                      Text(
                        theNewsArticle.author == "Unknown Author"
                            ? theNewsArticle.theSource.name
                            : theNewsArticle.author,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 18.0,
                              color: Colors.grey.shade300,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        "|",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 22.0,
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        theNewsArticle.publishedAt.replaceRange(
                            10, theNewsArticle.publishedAt.length, ""),
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 18.0,
                              color: Colors.grey.shade300,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                    ],
                  ),

                  //!PAGE DOTS
                  PageViewDotIndicator(
                    currentItem: pageIndex,
                    count: numberOfPages,
                    unselectedColor: Colors.grey.shade400,
                    selectedColor: thePageColour,
                    size: const Size(15, 15),
                    unselectedSize: const Size(10, 10),
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.bottomCenter,
                    fadeEdges: false,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
