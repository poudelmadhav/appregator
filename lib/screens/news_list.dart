import 'package:appregator/models/news_article.dart';
import 'package:appregator/screens/news_card.dart';
import 'package:appregator/screens/search_form.dart';
import 'package:appregator/services/web.dart';
import 'package:appregator/shared/box_decoration_with_shadow.dart';
import 'package:appregator/shared/loading.dart';
import 'package:flutter/material.dart';

class NewsList extends StatefulWidget {
  final String query;
  NewsList({this.query});
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  bool loading = true;
  List<NewsArticle> _newsArticles = List<NewsArticle>();
  NewsArticle _newsArticle = NewsArticle();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
  }

  void _populateNewsArticles() {
    Webservice()
        .load(_newsArticle.getNews(widget.query))
        .then((newsArticles) => {
              setState(() => {
                    _newsArticles = newsArticles,
                    loading = false,
                  })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appregator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return SearchForm();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                loading = true;
              });
              _populateNewsArticles();
            },
          )
        ],
      ),
      body: loading
          ? Loading()
          : Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: boxDecorationWithShadow,
                  child: ListTile(
                    title: Text('News related to \"${widget.query}\"'),
                  ),
                ),
                Expanded(
                  child: _newsArticles.isNotEmpty
                      ? ListView.builder(
                          itemCount: _newsArticles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NewsCard(_newsArticles[index]);
                          },
                        )
                      : Center(
                          child: Text(
                              'Sorry, we could\'t found News related to \"${widget.query}\"'),
                        ),
                ),
              ],
            ),
    );
  }
}
