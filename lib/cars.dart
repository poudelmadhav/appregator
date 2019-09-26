import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: HamroApp(),));

class HamroApp extends StatefulWidget {
  @override
  _HamroAppState createState() => _HamroAppState();
}

class _HamroAppState extends State<HamroApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Appregator"),
        backgroundColor: Color.fromRGBO(52, 156, 62, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            CarWidget("BMW", "M3", "https://media.ed.edmunds-media.com/bmw/m3/2018/oem/2018_bmw_m3_sedan_base_fq_oem_4_150.jpg"),
            CarWidget("BMW", "M3", "https://media.ed.edmunds-media.com/bmw/m3/2018/oem/2018_bmw_m3_sedan_base_fq_oem_4_150.jpg"),
            CarWidget("BMW", "M3", "https://media.ed.edmunds-media.com/bmw/m3/2018/oem/2018_bmw_m3_sedan_base_fq_oem_4_150.jpg"),        
          ],
        ),
      ),
    );
  }
}

class CarWidget extends StatelessWidget {
  CarWidget(this.make, this.model, this.imageSrc) : super();
  final String make;
  final String model;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0), child: Container(
        decoration: BoxDecoration(border: Border.all()),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text("$make $model", style: TextStyle(fontSize: 24.0)),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/loading.gif',
                  image: imageSrc
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}