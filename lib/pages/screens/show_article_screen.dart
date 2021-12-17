import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:sertinews/services/settings_provider.dart';

class ShowArticle extends StatefulWidget {
  final TheNewsArticle theNewsArticle;
  final String fromPageTitle;
  const ShowArticle(
      {Key? key, required this.theNewsArticle, required this.fromPageTitle})
      : super(key: key);

  @override
  State<ShowArticle> createState() => _ShowArticleState();
}

class _ShowArticleState extends State<ShowArticle>
    with SingleTickerProviderStateMixin {
  late AnimationController _theAnimationController;
  late Animation _filterChipAnimationColour;
  bool _isBookmarked = false;

  // late List<String> _newsArticleUrls;

  @override
  void initState() {
    super.initState();

    _theAnimationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    _filterChipAnimationColour = ColorTween(
      begin: Colors.black54.withOpacity(0.5),
      end: const Color(0xFF006D77).withOpacity(0.5),
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
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _theAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    var _settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            //!FIRST CONTAINER
            Hero(
              tag: widget.theNewsArticle.urlToImage == ""
                  ? "newsImage_${widget.theNewsArticle.title}"
                  : "newsImage_${widget.theNewsArticle.urlToImage}",
              child: Container(
                height: _screenSize.height / 2.5,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: widget.theNewsArticle.urlToImage == ""
                            ? const AssetImage(
                                "assets/fallback_news_image_resized.png")
                            : CachedNetworkImageProvider(
                                    widget.theNewsArticle.urlToImage)
                                as ImageProvider, //NetworkImage(widget.theNewsArticle.urlToImage),
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
                child: Column(
                  children: <Widget>[
                    //!ACTIONS
                    Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                alignment: Alignment.centerLeft,
                                splashColor: Colors.black45,
                                onPressed: () {
                                  Navigator.of(context).pop();
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
                                  return FilterChip(
                                    padding: const EdgeInsets.all(12.0),
                                    label: Text("Save Article",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                          color: widget.fromPageTitle ==
                                                  "Saved Articles"
                                              ? Colors.white
                                              : Colors.black87
                                                    .withOpacity(0.7)
                                        )),
                                    selected:
                                        widget.fromPageTitle == "Saved Articles"
                                            ? true
                                            : _isBookmarked,
                                    selectedColor:
                                        widget.fromPageTitle == "Saved Articles"
                                            ? const Color(0xFF4D194D)
                                                .withOpacity(0.9)
                                            : _filterChipAnimationColour.value,
                                    checkmarkColor:
                                        widget.fromPageTitle == "Saved Articles"
                                            ? Colors.white
                                            : Colors.black87.withOpacity(0.7),
                                    onSelected: (value) {
                                      //!PERFORM ANIMATION.
                                      if (value == true) {
                                        _theAnimationController.forward();
                                        setState(() {
                                          _isBookmarked = value;
                                        });
                                      } else {
                                        _theAnimationController.reverse();
                                        setState(() {
                                          _isBookmarked = value;
                                        });
                                      }

                                      //!IF VALUE IS TRUE -- I.E SAVE THE ARTICLE;
                                      //!CHECK IF ARTICLE IS NOT IN THE ALREADY SAVED LIST.
                                      //!IF ABSENT; SAVE ARTICLE ... ELSE ... REMOVE ARTICLE.

                                      if (value == true) {
                                        if (_settingsProvider
                                                .fetchSavedArticlesList()
                                                .contains(
                                                    widget.theNewsArticle) !=
                                            true) {
                                          _settingsProvider.saveArticleByObject(
                                              theNewsArticleObject:
                                                  widget.theNewsArticle);
                                          _settingsProvider.setIsArticleSaved(
                                              areArticlesSaved: true);
                                        } else {
                                          _settingsProvider.removeSavedArticle(
                                              theArticleToBeRemoved:
                                                  widget.theNewsArticle);
                                          _settingsProvider.setIsArticleSaved(
                                              areArticlesSaved: false);
                                        }
                                      }
                                    },
                                  );
                                }),
                          ]),
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          //!ARTICLE TITLE SECTION

                          Text(
                            widget.theNewsArticle.title,
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
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
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Colors.black38.withOpacity(0.7)
                                    : Colors.grey.shade300,
                          ),

                          //!ARTICLE DESCRIPTION
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            widget.theNewsArticle.description,
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.black87.withOpacity(0.7)
                                          : Colors.grey.shade300,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
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
