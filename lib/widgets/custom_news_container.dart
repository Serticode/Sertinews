import 'package:flutter/material.dart';
import 'package:sertinews/models/news_article_model.dart';

class CustomNewsContainer extends StatelessWidget {
  final TheNewsArticle theNewsArticle;
  final Color thePageColour;
  final int pageIndex;
  const CustomNewsContainer({
    Key? key,
    required this.theNewsArticle,
    required this.thePageColour,
    required this.pageIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //!MAIN CONTAINER.
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),

      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(theNewsArticle.urlToImage),
            fit: BoxFit.fitHeight,
          ),
          borderRadius: BorderRadius.circular(40.0)),
      //!INNER CONTAINER
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height / 1.8) / 2,
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(40.0)),
            ),
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //!ARTICLE TITLE
                Text(
                  theNewsArticle.title.length > 85
                      ? theNewsArticle.title
                          .replaceRange(86, theNewsArticle.title.length, " ...")
                      : theNewsArticle.title + " ...",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 28.0,
                        color: Colors.grey.shade200,
                      ),
                ),

                const SizedBox(height: 8.0),
                //!ARTICLE AUTHOR  / DATE ROW
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //!ARTICLE AUTHOR
                    Text(
                      theNewsArticle.author == "Unknown Author"
                          ? theNewsArticle.theSource.name
                          : theNewsArticle.author.length > 12
                              ? theNewsArticle.theSource.name
                              : theNewsArticle.author +
                                  " for " +
                                  theNewsArticle.theSource.name,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 18.0,
                            color: Colors.grey.shade400,
                          ),
                    ),
                    Text(
                      theNewsArticle.publishedAt.replaceRange(
                          10, theNewsArticle.publishedAt.length, ""),
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 18.0,
                            color: Colors.grey.shade400,
                          ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
