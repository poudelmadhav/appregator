import 'package:appregator/models/news_article.dart';
import 'package:appregator/screens/news_card.dart';
import 'package:appregator/services/web.dart';
import 'package:flutter/material.dart';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<NewsArticle> _newsArticles = List<NewsArticle>();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {
    Webservice().load(NewsArticle.all).then((newsArticles) => {
          setState(() => {_newsArticles = newsArticles})
        });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> newsCards =
        _newsArticles.map((news) => NewsCard(news)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Appregator'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _populateNewsArticles();
            },
          )
        ],
      ),
      body: ListView(padding: EdgeInsets.all(10.0), children: newsCards),
    );
  }
}
