import 'package:appregator/models/resource.dart';
import 'dart:convert';

class NewsArticle {
  final String title;
  final String description;
  final String urlToImage;
  final String url;
  final String publishedAt;
  final String source;

  NewsArticle(
      {this.title,
      this.description,
      this.urlToImage,
      this.url,
      this.publishedAt,
      this.source});

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
        title: json['title'],
        description: json['description'],
        urlToImage: json['urlToImage'],
        url: json['url'],
        publishedAt: json['publishedAt'],
        source: json['source']['name']);
  }

  Resource<List<NewsArticle>> getNews(String query) {
    return Resource(
        url:
            "https://newsapi.org/v2/everything?q=$query&sortBy=publishedAt&apiKey=85a958849ffc4bffa9150ac325fb48d8",
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['articles'];
          return list.map((model) => NewsArticle.fromJson(model)).toList();
        });
  }
}
