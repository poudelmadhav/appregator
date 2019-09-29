import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:share/share.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:url_launcher/url_launcher.dart' as urlLaunch;

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Appregator",
      debugShowCheckedModeBanner: false,
      home: NewsList(),
    );
  }
}

class Constants {
  static final String headlineNewsUrl = 'https://newsapi.org/v2/everything?q=migrant&sortBy=publishedAt&apiKey=85a958849ffc4bffa9150ac325fb48d8';
  static final String newsPlaceholderImageAssetUrl = 'assets/loading.gif';
  static final String newsAlternativeImageAssetUrl = 'assets/icon.png';
}

class NewsListState extends State<NewsList> {

  List<NewsArticle> _newsArticles = List<NewsArticle>(); 

  @override
  void initState() {
    super.initState();
    _populateNewsArticles(); 
  }

  void _populateNewsArticles() {
    Webservice().load(NewsArticle.all).then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> newsCards = _newsArticles.map((news) => 
    NewsCard(news)).toList();
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
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: newsCards
      ),
    );
  }
}


class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState(); 
}

class NewsArticle {
  final String title; 
  final String description; 
  final String urlToImage; 
  final String url;
  final String publishedAt;
  final String source;

  NewsArticle({this.title, this.description, this.urlToImage, this.url, this.publishedAt, this.source});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
      title: json['title'], 
      description: json['description'], 
      urlToImage: json['urlToImage'],
      url: json['url'],
      publishedAt: json['publishedAt'],
      source: json['source']['name']
    );
  }

  static Resource<List<NewsArticle>> get all {
    return Resource(
      url: Constants.headlineNewsUrl,
      parse: (response) {
        final result = json.decode(response.body); 
        Iterable list = result['articles'];
        return list.map((model) => NewsArticle.fromJson(model)).toList();
      }
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsArticle _news;
  
  NewsCard(this._news);

  void _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: new CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn()
        ),
      );
    } catch (e) {
      if (await urlLaunch.canLaunch(url)) {
        await urlLaunch.launch(url, forceWebView: true, forceSafariVC: true, enableJavaScript: true);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  _publishedAt(String publishedDate) {
    DateTime _parsedDate = DateTime.parse(publishedDate);
    return Text(
      "${_parsedDate.year}/${_parsedDate.month}/${_parsedDate.day}",
      style: TextStyle(
        fontSize: 10.0,
        fontStyle: FontStyle.italic
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => _launchURL(context, _news.url),
            child: Column(
              children: <Widget>[
                new Container(
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 0.75)
                        )
                      ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _news.urlToImage == null 
                          ? Image.asset(
                              Constants.newsAlternativeImageAssetUrl,
                              fit: BoxFit.fitHeight,
                              width: 2000,
                            ) 
                          : FadeInImage.assetNetwork(
                              placeholder: Constants.newsPlaceholderImageAssetUrl, 
                              image:_news.urlToImage,
                              fit: BoxFit.fitHeight,
                              width: 2000,
                            ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 20, 8.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _publishedAt(_news.publishedAt),
                            Text(
                              "Source: ${_news.source}",
                              style: TextStyle(
                                fontSize: 10.0,
                                fontStyle: FontStyle.italic
                              ),
                            ),
                          ]
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 10.0),
                        child: Text(
                          "${_news.title}",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 10.0),
                        child: Text(
                          "${_news.description}",
                          maxLines: 2,
                          style: TextStyle(fontSize: 14.0),
                          overflow: TextOverflow.fade
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(endIndent: 8, indent: 8)
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(child: Text("Share"), onPressed: () => { Share.share(_news.url) }),
                          FlatButton(child: Text("Bookmark"), onPressed: () => {}),
                          FlatButton(child: Text("Open"), onPressed: () => { _launchURL(context, _news.url) }),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}

class Resource<T> {
  final String url; 
  T Function(Response response) parse;

  Resource({this.url,this.parse});
}

class Webservice {
  Future<T> load<T>(Resource<T> resource) async {
    final response = await http.get(resource.url);
    if(response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
