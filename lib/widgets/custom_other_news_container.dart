import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sertinews/models/news_article_model.dart';

class CustomOtherNewsContainer extends StatelessWidget {
  final TheNewsArticle theNewsArticle;
  final int pageIndex;
  const CustomOtherNewsContainer({
    Key? key,
    required this.theNewsArticle,
    required this.pageIndex,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("Top News Article $pageIndex Tapped ");
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 2.8,
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          image: DecorationImage(
            image: NetworkImage(theNewsArticle.urlToImage),
            fit: BoxFit.fitHeight,
          ),
        ),
        //!INNER CONTAINER
        child: Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Container(
            alignment: AlignmentDirectional.bottomCenter,
            height: (MediaQuery.of(context).size.height / 3) / 2,
            decoration: BoxDecoration(
              color: Colors.black54.withOpacity(0.6),
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            ),
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //!ARTICLE TITLE
                Text(
                  theNewsArticle.title.length > 25
                      ? theNewsArticle.title
                          .replaceRange(26, theNewsArticle.title.length, " ...")
                      : theNewsArticle.title + " ...",
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 22.0,
                        color: Colors.grey.shade200,
                      ),
                ),

                const SizedBox(height: 8.0),
                //!ARTICLE AUTHOR  / DATE ROW
                Text(
                  theNewsArticle.author == "Unknown Author"
                      ? theNewsArticle.theSource.name
                      : theNewsArticle.author.length > 8
                          ? theNewsArticle.theSource.name
                          : theNewsArticle.author +
                              " for " +
                              theNewsArticle.theSource.name,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 14.0,
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}