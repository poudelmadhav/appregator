import 'package:flutter/material.dart';

void main() => runApp(LoadingImageApp());

class LoadingImageApp extends StatelessWidget {
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Row row1 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        OutlineButton(
          onPressed: () => debugPrint('Outline button pressed'),
          child: Text('Outline Button'),
        ),
      ],
    );

    Row row2 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        FlatButton(
          onPressed: () => debugPrint('FlatButton pressed'),
          child: Text('Flat Button'),
        ),
      ],
    );

    Row row3 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RaisedButton(
          onPressed: () => debugPrint('RaisedButton pressed'),
          child: Text('Raised Button'),
        ),
      ],
    );

    Row row4 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => debugPrint('Icon Button Pressed'),
        ),
      ],
    );

    Row row5 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        DropdownButton<String>(
          items: <String>['Men', 'Women'].map((String value) {
            return new DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) => debugPrint('Changed: $value'),
        ),
        const Text('DropdownButton')
      ],
    );

    Row row6 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        BackButton(),
        const Text("Back Button")
      ],
    );

    Row row7 = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CloseButton(),
        Text('Close Button')
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Icons"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(50.0),
        children: <Widget>[
          row1,
          Padding(padding: EdgeInsets.all(20.0)),
          row2,
          Padding(padding: EdgeInsets.all(20.0)),
          row3, 
          Padding(padding: EdgeInsets.all(20.0)),
          row4, 
          Padding(padding: EdgeInsets.all(20.0)),
          row5, 
          Padding(padding: EdgeInsets.all(20.0)),
          row6, 
          Padding(padding: EdgeInsets.all(20.0)),
          row7
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint('Floating action BUtton pressed'),
        child: Text("FAB"),
      ),
    );
  }
}
