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
      title: "Networking",
      home: NewsList()
    );
  }
}

class Constants {
  static final String HEADLINE_NEWS_URL = 'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=85a958849ffc4bffa9150ac325fb48d8';
  static final String NEWS_PLACEHOLDER_IMAGE_ASSET_URL = 'assets/placeholder.png';
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
          ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) 
          : FadeInImage.assetNetwork(
            placeholder: Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL, 
            image:_newsArticles[index].urlToImage
          ), 
      subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
      onTap: () {
        launch(_newsArticles[index].url, forceWebView: true, forceSafariVC: true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: ListView.builder(
        itemCount: _newsArticles.length,
        itemBuilder: _buildItemsForListView,
      )
    );
  }
}

class NewsList extends StatefulWidget {
  @override
  createState() => NewsListState(); 
}

class NewsArticle {
  final String title; 
  final String descrption; 
  final String urlToImage; 
  final String url;

  NewsArticle({this.title, this.descrption, this.urlToImage, this.url});

  factory NewsArticle.fromJson(Map<String,dynamic> json) {
    return NewsArticle(
      title: json['title'], 
      descrption: json['description'], 
      urlToImage: json['urlToImage'] ?? Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL,
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
