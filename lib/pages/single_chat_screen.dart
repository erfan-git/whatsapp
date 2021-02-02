import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_model.dart';

class SingleChatScreen extends StatelessWidget {
  final ChatModel data;

  SingleChatScreen({@required this.data});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(data.avatarUrl),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  data.name,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ' صفحه چت '+ data.name,
                style: TextStyle(fontSize: 20),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context,"سلام ${this.data.name}");
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
