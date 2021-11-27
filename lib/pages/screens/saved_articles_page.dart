import 'package:flutter/material.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({Key? key}) : super(key: key);

  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //!PAGE TITLE.
          /* OtherPagesTitle(
            pageTitle: "Saved Articles",
            titleColour: Theme.of(context).brightness == Brightness.light
                ? const Color(0xFF4D194D)
                : Colors.white,
          ), */

          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              //!PAGE IMAGE.
              Container(
                padding: const EdgeInsets.all(12.0),
                height: 250,
                decoration: BoxDecoration(
                    color: const Color(0xFF4D194D).withOpacity(0.95),
                    image: const DecorationImage(
                      image: AssetImage("assets/saved_articles_image2.png"),
                      fit: BoxFit.contain,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38.withOpacity(0.2),
                        offset: const Offset(
                          0.0,
                          15.0,
                        ),
                        blurRadius: 70.0,
                        spreadRadius: 0.1,
                      ),
                    ]),
              ),

              //!PAGE BODY
            ]),
          ),
        ],
      ),
    );
  }
}
