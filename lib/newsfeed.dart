import 'package:flutter/material.dart';

void main() => runApp(Appregator());

class Appregator extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: AppregatorWidget(title: "News Feed"),
    );
  }
}

class News {
  DateTime _dt;
  String _title;
  String _text;
  
  News(this._dt, this._title, this._text);
}

class NewsCard extends StatelessWidget {
  News _news;
  
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
            child: Text("${_news._dt.month}/${_news._dt.day}/${_news._dt.year}", style: TextStyle(
              fontSize: 10.0,
              fontStyle: FontStyle.italic
            )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text("${_news._title}", style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            )),
          ),
          Text(
            "${_news._text}",
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

class AppregatorWidget extends StatelessWidget {
  AppregatorWidget({Key key, this.title}) : super(key: key);
  final String title;

  List<News>_newsList = [
    News(
      DateTime(2018, 12, 1),
      "Mass shooting in Atlanta",
      "Lorem ipsum this is just a fun text to enjoy tortor pretium , interdum magna sed, pulvinar ligula"
    ),
    News(
      DateTime(2019, 2, 12),
      "carnival clown found drunk in Missipi",
      "Lorem ipsum test and fun fot the app development Just enjoying flutter"
    ),
    News(
      DateTime(2019, 05, 31),
      "Messi scores 10 goals",
      "Messi is one of my favorite player. I got him scoring 10 goals infront of in worldcup withing 10 minutes. So amazing and lovely and astonishing game."
    )
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> newsCards = _newsList.map((news) => 
    NewsCard(news)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("News Feed"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: newsCards
      ),
    );
  }
}
