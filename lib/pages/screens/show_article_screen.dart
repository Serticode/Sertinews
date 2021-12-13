import 'package:flutter/material.dart';
import 'package:sertinews/models/news_article_model.dart';

class ShowArticle extends StatefulWidget {
  final TheNewsArticle theNewsArticle;
  const ShowArticle({Key? key, required this.theNewsArticle}) : super(key: key);

  @override
  State<ShowArticle> createState() => _ShowArticleState();
}

class _ShowArticleState extends State<ShowArticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _theAnimationController;
  late Animation _iconColourAnimation;
  late Animation _iconContainerColourAnimation;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();

    _theAnimationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);

    _iconColourAnimation = ColorTween(
      begin: Colors.black87.withOpacity(0.7),
      end: const Color(0xFF006D77),
    ).animate(_theAnimationController);

    _iconContainerColourAnimation = ColorTween(
      begin: Colors.transparent,
      end: const Color(0xFF006D77).withOpacity(0.2),
    ).animate(_theAnimationController);

    _theAnimationController.addListener(() {});

    _theAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isBookmarked = true;
        });
      }

      if (status == AnimationStatus.dismissed) {
        setState(() {
          _isBookmarked = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _theAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            //!FIRST CONTAINER
            Hero(
              tag: "newsImage_${widget.theNewsArticle.urlToImage}",
              child: Container(
                height: _screenSize.height / 2.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.theNewsArticle.urlToImage),
                        fit: BoxFit.fitHeight)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    height: _screenSize.height / 12,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(
                          1.0,
                          1.0,
                        ),
                        blurRadius: 50.0,
                        spreadRadius: 15.0,
                      ), //BoxShadow
                    ]),
                    child: Text("SertiNews",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              color: Colors.white,
                            )),
                  ),
                ),
              ),
            ),

            //!CONTAINER SHOWING NEWS ARTICLE.
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _screenSize.height / 1.42,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Colors.black54,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)),
                ),
                child: ListView(
                  children: <Widget>[
                    //!ARTICLE TITLE
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                              alignment: Alignment.centerLeft,
                              splashColor: Colors.black45,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_outlined,
                                size: 28.0,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black87.withOpacity(0.7)
                                    : Colors.grey.shade300,
                              )),
                          AnimatedBuilder(
                              animation: _theAnimationController,
                              builder: (BuildContext context, _) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: _iconContainerColourAnimation.value,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: IconButton(
                                      alignment: Alignment.center,
                                      splashColor: Colors.black45,
                                      onPressed: () {
                                        //!TODO: SAVE ARTICLE.
                                        debugPrint(
                                            "SAVE ARTICLE BUTTON PRESSED");
                                        _isBookmarked
                                            ? _theAnimationController.reverse()
                                            : _theAnimationController.forward();
                                      },
                                      icon: Icon(
                                        Icons.bookmark_add_outlined,
                                        size: 28.0,
                                        color: _iconColourAnimation.value,
                                      )),
                                );
                              }),
                        ]),

                    Text(
                      widget.theNewsArticle.title,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black87.withOpacity(0.7)
                                    : Colors.grey.shade300,
                            fontSize: 36.0,
                            fontWeight: FontWeight.w700,
                          ),
                    ),

                    const SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      thickness: 3.0,
                      endIndent: _screenSize.width / 2,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black38.withOpacity(0.7)
                          : Colors.grey.shade300,
                    ),

                    //!ARTICLE DESCRIPTION
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      widget.theNewsArticle.description,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black87.withOpacity(0.7)
                                    : Colors.grey.shade300,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),

                    //!ARTICLE CONTENT
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      widget.theNewsArticle.content,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black87.withOpacity(0.7)
                                    : Colors.grey.shade300,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
