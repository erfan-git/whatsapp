import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/pages/camera_screen.dart';

class CreateChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ایجاد چت'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ایجاد چت',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CameraScreen()),
                      );
                    },
                    child: Text(
                      'صفحه دوم',
                    ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
