import 'package:flutter/material.dart';
import 'package:whatsapp/models/chat_model.dart';
import 'package:whatsapp/pages/single_chat_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Divider(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  navigateAndDisplaySomeMessage(context, index);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(dummyData[index].avatarUrl),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dummyData[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dummyData[index].time,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      )
                    ],
                  ),
                  subtitle: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      dummyData[index].message,
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  // متد مربوط به رفتن به صفحه دوم با ارسال پارامتر و همچنین دریافت پارامتر باتوجه به آسینک بودن متد و استفاده از await برای منتظر بودن ببرای گرفتن جواب
  void navigateAndDisplaySomeMessage(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleChatScreen(data: dummyData[index]),
      ),
    );
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result,
          style: TextStyle(fontFamily: 'Vazir'),
        ),
      ),
    );
  }
}
