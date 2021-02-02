import 'package:flutter/material.dart';
import 'package:whatsapp/pages/call_screen.dart';
import 'package:whatsapp/pages/camera_screen.dart';
import 'package:whatsapp/pages/chat_screen.dart';
import 'package:whatsapp/pages/create_chat_screen.dart';
import 'package:whatsapp/pages/new_group_screen.dart';
import 'package:whatsapp/pages/setting_screen.dart';
import 'package:whatsapp/pages/status_screen.dart';

class WhatsAppHome extends StatefulWidget {
  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  Map<String, SliverAppBar> appBarList;
  String _currentAppBar = 'mainAppBar';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(initialIndex: 1, length: 4, vsync: this);

    SliverAppBar mainAppBar = SliverAppBar(
      elevation: 5,
      title: Text('واتساپ'),
      pinned: true,
      floating: true,
      actions: [
        GestureDetector(
          child: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onTap: () {
            setState(() {
              _currentAppBar = 'searchAppBar';
            });
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        //جنریک <تایپ> مقابل PopupMenuButton در متد onSelected مربوط به چک کردن value هر itemBuilder است
        PopupMenuButton<String>(
          onSelected: (String choice) {
            if (choice == 'settings') {
              Navigator.pushNamed(context,"/setting");
            } else if (choice == 'new_group') {
              Navigator.pushNamed(context,"/new_chat");
            }
          },
          itemBuilder: (BuildContext contex) {
            return [
              PopupMenuItem(
                value: 'new_group',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('گروه جدید'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Center(child: Text('تنظیمات')),
              ),
            ];
          },
        )
      ],
      bottom: TabBar(
        controller: tabController,
        indicatorColor: Colors.white,
        tabs: <Widget>[
          Tab(
            icon: Icon(Icons.camera_alt),
          ),
          Tab(
            text: "چت ها",
          ),
          Tab(
            text: "وضعیت",
          ),
          Tab(
            text: "تماس ها",
          ),
        ],
      ),
    );
    SliverAppBar searchAppBar = SliverAppBar(
      elevation: 5,
      title: TextField(
        decoration:
            InputDecoration(border: InputBorder.none, hintText: 'جستجو ...'),
      ),
      pinned: true,
      floating: true,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(
            Icons.arrow_back,
            color: Color(0xff075e54),
          ),
        ),
        onTap: () {
          setState(() {
            _currentAppBar = 'mainAppBar';
          });
        },
      ),
    );

    appBarList = <String, SliverAppBar>{
      'mainAppBar': mainAppBar,
      'searchAppBar': searchAppBar,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: _currentAppBar == 'mainAppBar'
            ? TabBarView(
                controller: tabController,
                children: [
                  CameraScreen(),
                  ChatScreen(),
                  StatusScreen(),
                  CallScreen(),
                ],
              )
            : Center(
                child: Text('search'),
              ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScorolled) {
          return <Widget>[
            // در این ویجت به جای AppBar باید از SliverAppBar استفاده کنیم
            appBarList[_currentAppBar]
          ];
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateChatScreen(),
            ),
          );
        },
      ),
    );
  }
}
