import 'package:appregator/models/resource.dart';
import 'package:appregator/shared/constants.dart';
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

  static Resource<List<NewsArticle>> get all {
    return Resource(
        url: Constants.headlineNewsUrl,
        parse: (response) {
          final result = json.decode(response.body);
          Iterable list = result['articles'];
          return list.map((model) => NewsArticle.fromJson(model)).toList();
        });
  }
}
