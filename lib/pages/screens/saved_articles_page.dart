import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sertinews/models/news_article_model.dart';
import 'package:sertinews/pages/screens/show_article_screen.dart';
import 'package:sertinews/services/settings_provider.dart';

class SavedArticles extends StatefulWidget {
  const SavedArticles({Key? key}) : super(key: key);

  @override
  _SavedArticlesState createState() => _SavedArticlesState();
}

class _SavedArticlesState extends State<SavedArticles> {
  String sampleText = "TEST EVERYTHING";
  double articleContainerMargin = 150.0;
  late List<TheNewsArticle> _theSavedArticles = [];

  //!ANIMATE CONTAINER
  animateArticleContainer() {
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      setState(() {
        articleContainerMargin = 20.0;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    animateArticleContainer();
  }

  @override
  void didChangeDependencies() {
    SettingsProvider _settingsProvider = Provider.of<SettingsProvider>(context);
    super.didChangeDependencies();

    setState(() {
      _theSavedArticles = _settingsProvider.fetchSavedArticlesList();
    });
  }

  @override
  Widget build(BuildContext context) {
    SettingsProvider _settingsProvider = Provider.of<SettingsProvider>(context);

    Size _screenSize = MediaQuery.of(context).size;
    final _textStyle = Theme.of(context).textTheme.bodyText2!.copyWith(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.black87.withOpacity(0.7)
              : Colors.grey.shade300,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        );

    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Articles",
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 28,
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFF4D194D)
                      : Colors.white,
                  fontWeight: FontWeight.w600,
                )),
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
      ),
      body: Stack(
        children: <Widget>[
          //!PAGE IMAGE.
          Container(
            padding: const EdgeInsets.all(12.0),
            height: _screenSize.height / 2.8,
            decoration: BoxDecoration(
                color: const Color(0xFF4D194D).withOpacity(0.9),
                image: const DecorationImage(
                  image: AssetImage("assets/saved_articles_image2.png"),
                  fit: BoxFit.contain,
                ),
                boxShadow: <BoxShadow>[
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

          //!LIST OF SAVED ARTICLES
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade200
                      : Colors.black,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  )),
              height: _screenSize.height / 1.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //!DIVIDER
                  const SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    indent: _screenSize.width / 2.4,
                    endIndent: _screenSize.width / 2.4,
                    thickness: 3,
                    color: const Color(0xFF4D194D).withOpacity(0.7),
                  ),

                  //!SECTION TITLE
                  Text(
                    "Articles",
                    style: _textStyle.copyWith(
                      fontSize: 20.0,
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFF4D194D)
                          : Colors.white,
                    ),
                  ),

                  //!SAVED ARTICLES.
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInOutBack,
                      margin: EdgeInsets.only(top: articleContainerMargin),
                      child: ListView.separated(
                          separatorBuilder: (_, int index) {
                            return Divider(
                              color: (Theme.of(context).brightness ==
                                      Brightness.light)
                                  ? const Color(0xFF4D194D).withOpacity(0.5)
                                  : Colors.white.withOpacity(0.5),
                              thickness: 1.8,
                              endIndent: _screenSize.width / 2,
                            );
                          },
                          itemCount: _theSavedArticles.length,
                          itemBuilder: (_, int index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (_, __, ___) => ShowArticle(
                                          theNewsArticle:
                                              _theSavedArticles[index], fromPageTitle: "Saved Articles",)),
                                );
                              },
                              child: Hero(
                                tag: _theSavedArticles[index].urlToImage == ""
                                    ? "newsImage_${_theSavedArticles[index].title}"
                                    : "newsImage_${_theSavedArticles[index].urlToImage}",
                                child: Card(
                                  elevation: 10.0,
                                  shadowColor: Colors.black38,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(40.0)),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(12.0),
                                    //!LEADING
                                    leading: CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor:
                                          (Theme.of(context).brightness ==
                                                  Brightness.light)
                                              ? const Color(0xFF4D194D)
                                              : Colors.white,
                                      child: CircleAvatar(
                                        radius: 25.0,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          _theSavedArticles[index].urlToImage,
                                        ),
                                      ),
                                    ),

                                    //!TITLE
                                    title: Text(
                                      _theSavedArticles[index].title,
                                      style: _textStyle,
                                    ),

                                    //!SUBTITLE
                                    subtitle: Text(
                                        _theSavedArticles[index].description),

                                    //!TRAILING
                                    trailing: IconButton(
                                        onPressed: () {
                                          _settingsProvider.removeSavedArticle(
                                              theArticleToBeRemoved:
                                                  _theSavedArticles[index]);
                                        },
                                        icon: Icon(
                                          Icons.delete_outlined,
                                          color:
                                              (Theme.of(context).brightness ==
                                                      Brightness.light)
                                                  ? const Color(0xFF4D194D)
                                                  : Colors.white,
                                          size: 30.0,
                                        )),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
