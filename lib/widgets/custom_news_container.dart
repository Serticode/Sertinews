import 'package:flutter/material.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:sertinews/models/news_source_model.dart';

class CustomNewsContainer extends StatefulWidget {
  final TheNewsArticle theNewsArticle;
  final Color thePageColour;
  const CustomNewsContainer({
    Key? key,
    required this.theNewsArticle,
    required this.thePageColour,
  }) : super(key: key);

  @override
  _CustomNewsContainerState createState() => _CustomNewsContainerState();
}

class _CustomNewsContainerState extends State<CustomNewsContainer> {
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
                  image: NetworkImage(widget.theNewsArticle.urlToImage),
                ),
                borderRadius: BorderRadius.circular(15.0)),
          ),
          const SizedBox(height: 24.0),
          //!ARTICLE TITLE
          Text(
            widget.theNewsArticle.title + " ...",
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
                widget.theNewsArticle.author == "Unknown Author"
                    ? widget.theNewsArticle.theSource.name
                    : widget.theNewsArticle.author.length > 12
                        ? widget.theNewsArticle.theSource.name
                        : widget.theNewsArticle.author +
                            " for " +
                            widget.theNewsArticle.theSource.name,
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                widget.theNewsArticle.publishedAt.replaceRange(
                    10, widget.theNewsArticle.publishedAt.length, ""),
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
