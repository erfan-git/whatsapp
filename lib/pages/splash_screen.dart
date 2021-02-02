import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() {
    var _duration = Duration(seconds: 5);
    //در ویجت تایمر دو ورودی میدهیم که اولی duration و دومی فانکشن کاری که قراره انجام بده است
    //از متد navigationPage بدون پرانتز استفاده کردیم تا در همان لحظه اجرا نشود و هر موقع تایمر تمام شد اجرا شود
    return Timer(_duration, navigationPage);
  }

  navigationPage(){
    Navigator.of(context).pushNamed('/');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff075E54),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/whatsapp_logo.png"),
                  ),
                ),
              ),
              Text(
                'واتساپ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
