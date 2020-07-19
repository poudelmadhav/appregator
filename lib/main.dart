import 'package:appregator/screens/news_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Appregator",
      debugShowCheckedModeBanner: false,
      home: NewsList(query: 'migrant'),
    );
  }
}
