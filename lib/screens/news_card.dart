import 'package:appregator/shared/box_decoration_with_shadow.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:appregator/shared/constants.dart';
import 'package:appregator/models/news_article.dart';
import 'package:appregator/shared/launch_url.dart';

class NewsCard extends StatelessWidget {
  final NewsArticle _news;

  NewsCard(this._news);

  _publishedAt(String publishedDate) {
    DateTime _parsedDate = DateTime.parse(publishedDate);
    return Text("${_parsedDate.year}/${_parsedDate.month}/${_parsedDate.day}",
        style: TextStyle(fontSize: 10.0, fontStyle: FontStyle.italic));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
              onTap: () => launchURL(context, _news.url),
              child: Column(
                children: <Widget>[
                  new Container(
                    decoration: boxDecorationWithShadow,
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
                                placeholder:
                                    Constants.newsPlaceholderImageAssetUrl,
                                image: _news.urlToImage,
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
                                      fontStyle: FontStyle.italic),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 10.0),
                          child: Text(
                            "${_news.title}",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 10.0),
                          child: Text("${_news.description}",
                              maxLines: 2,
                              style: TextStyle(fontSize: 14.0),
                              overflow: TextOverflow.fade),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(child: Divider(endIndent: 8, indent: 8))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                                child: Text("Share"),
                                onPressed: () => {Share.share(_news.url)}),
                            FlatButton(
                                child: Text("Bookmark"), onPressed: () => {}),
                            FlatButton(
                                child: Text("Open"),
                                onPressed: () =>
                                    {launchURL(context, _news.url)}),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
