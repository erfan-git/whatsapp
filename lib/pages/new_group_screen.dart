import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/camera_screen.dart';

class NewGroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('تنظیمات'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'گروه جدید',
                style: TextStyle(fontSize: 20),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'برگشت',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}