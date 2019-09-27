import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

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
  static final String HEADLINE_NEWS_URL = 'https://newsapi.org/v2/everything?q=migrant&sortBy=publishedAt&apiKey=85a958849ffc4bffa9150ac325fb48d8';
  static final String NEWS_PLACEHOLDER_IMAGE_ASSET_URL = 'assets/loading.gif';
  static final String NEWS_ALTERNATIVE_IMAGE_ASSET_URL = 'assets/icon.png';
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

  ListTile _buildItemsForListView(BuildContext context, int index) {
    return ListTile(
      title: _newsArticles[index].urlToImage == null 
          ? Image.asset(Constants.NEWS_ALTERNATIVE_IMAGE_ASSET_URL) 
          : FadeInImage.assetNetwork(
            placeholder: Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL, 
            image:_newsArticles[index].urlToImage
          ), 
      subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
      onTap: () {
        _launchURL(_newsArticles[index].url);
      },
      contentPadding: EdgeInsets.all(20.0),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, forceSafariVC: true);
    } else {
      throw 'Could not launch $url';
    }
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
        padding: EdgeInsets.all(20.0),
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

  NewsArticle({this.title, this.description, this.urlToImage, this.url});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
      title: json['title'], 
      description: json['description'], 
      urlToImage: json['urlToImage'],
      url: json['url']
    );
  }

  static Resource<List<NewsArticle>> get all {
    return Resource(
      url: Constants.HEADLINE_NEWS_URL,
      parse: (response) {
        final result = json.decode(response.body); 
        Iterable list = result['articles'];
        return list.map((model) => NewsArticle.fromJson(model)).toList();
      }
    );
  }
}

class NewsCard extends StatelessWidget {
  NewsArticle _news;
  
  NewsCard(this._news);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network('https://www.bbc.co.uk/news/special/2015/newsspec_10857/bbc_news_logo.png?cb=1'),
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: Text("2018/02/15", style: TextStyle(
              fontSize: 10.0,
              fontStyle: FontStyle.italic
            )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("${_news.title}", style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            )),
          ),
          Text(
            "${_news.description}",
            maxLines: 2,
            style: TextStyle(fontSize: 14.0),
            overflow: TextOverflow.fade
          ),
          Row(
            children: [
              FlatButton(child: Text("Share"), onPressed: () => {}),
              FlatButton(child: Text("Bookmark"), onPressed: () => {}),
              FlatButton(child: Text("Link"), onPressed: () => {}),
            ],
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
