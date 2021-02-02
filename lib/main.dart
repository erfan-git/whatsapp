import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  AnimationController controller;

  //Animation
  //AnimationController
  //Tween
  //AnimationBuilder

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'whatsApp',
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 300,
                width: 300,
                child: FlutterLogo(),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('run'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
