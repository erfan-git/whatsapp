import 'package:flutter/material.dart';
import 'package:whatsapp/pages/create_chat_screen.dart';
import 'package:whatsapp/pages/login_screen.dart';
import 'package:whatsapp/pages/setting_screen.dart';
import 'package:whatsapp/pages/splash_screen.dart';
import 'package:whatsapp/whatsapp_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      theme: ThemeData(
        fontFamily: 'Vazir',
        primaryColor: Color(0xff075e54),
        accentColor: Color(0xff25d366),
      ),

      //صفحه ای که در ابتدای برنامه باز میشود
      initialRoute: '/splash_screen',

      // این قسمت مربوط به navigation است در این جا صفحات ای که میریم رو تعریف میکنیم
      routes: {
        // به جای استفاده از home میتوانیم از این route استفاده کنیم
        '/': (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: WhatsAppHome(),
            ),
        '/login': (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: LoginScreen(),
            ),
        '/splash_screen': (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: SplashScreen(),
            ),
        '/setting': (context) => SettingScreen(),
        '/new_chat': (context) => CreateChatScreen(),
      },

      debugShowCheckedModeBanner: false,
      // home: Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: WhatsAppHome(),
      // ) ,
    );
  }
}
