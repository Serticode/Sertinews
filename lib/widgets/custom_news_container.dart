import 'package:flutter/material.dart';
import 'package:sertinews/models/news_article_model.dart';

class CustomNewsContainer extends StatelessWidget {
  final TheNewsArticle theNewsArticle;
  final Color thePageColour;
  const CustomNewsContainer({
    Key? key,
    required this.theNewsArticle,
    required this.thePageColour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 10.0,
      ),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              offset: Offset(
                1.0,
                1.0,
              ),
              blurRadius: 15.0,
              spreadRadius: 0.1,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //!ARTICLE IMAGE
          Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(theNewsArticle.urlToImage),
                ),
                borderRadius: BorderRadius.circular(15.0)),
          ),
          const SizedBox(height: 24.0),
          //!ARTICLE TITLE
          Text(
            theNewsArticle.title + " ...",
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22.0,
            ),
          ),

          const SizedBox(height: 12.0),
          //!ARTICLE DESCRIPTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                theNewsArticle.author == "Unknown Author"
                    ? theNewsArticle.theSource.name
                    : theNewsArticle.author.length > 12
                        ? theNewsArticle.theSource.name
                        : theNewsArticle.author +
                            " for " +
                            theNewsArticle.theSource.name,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                theNewsArticle.publishedAt
                    .replaceRange(10, theNewsArticle.publishedAt.length, ""),
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}