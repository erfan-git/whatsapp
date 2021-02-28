import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp/services/auth_services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  startTime() {
    var _duration = Duration(seconds: 5);
    //در ویجت تایمر دو ورودی میدهیم که اولی duration و دومی فانکشن کاری که قراره انجام بده است
    //از متد navigationPage بدون پرانتز استفاده کردیم تا در همان لحظه اجرا نشود و هر موقع تایمر تمام شد اجرا شود
    return Timer(_duration, navigationToLogin);
  }

  navigationToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  navigationToHome() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
    // startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiToken = prefs.getString('user.api_token');

    if (await checkConnectionInternet()) {
      if (apiToken == null) {
        navigationToLogin();
      } else {
        await AuthService.checkApiToken(apiToken)
            ? navigationToHome()
            : navigationToLogin();
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: GestureDetector(
            onTap: () {
              //برای محو کردن اسنکبار نمایش داده شده از کد زیر استفاده می کنیم
              _scaffoldKey.currentState.hideCurrentSnackBar();
              checkLogin();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'از اتصال دستگاه به اینترنت مطمپن شوید',
                  style: TextStyle(fontFamily: 'Vazir'),
                ),
                Icon(
                  Icons.wifi_lock,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  Future checkConnectionInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    print(connectivityResult);
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
