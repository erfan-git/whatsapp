import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:whatsapp/animations/signin_animation.dart';
import 'package:whatsapp/components/form.dart';
import 'package:whatsapp/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController _loginButtonController;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _emailValue;
  String _passwordValue;

  emailOnSaved(String value) {
    _emailValue = value;
  }

  passwordOnSaved(String value) {
    _passwordValue = value;
  }

  @override
  void initState() {
    super.initState();
    _loginButtonController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // برای سرعت بخشیدن به اجرای انیمیشن از پکیج scheduler استفاده میکنیم سپس با مقدار دهی عبارت زیر سرعت را زیاد میکنیم
    timeDilation = .4;
    var page = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2c5364),
              Color(0xff0f2027),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Opacity(
              opacity: .1,
              child: Container(
                width: page.width,
                height: page.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/icon-background.png'),
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormContainer(
                    formKey: _formKey,
                    emailOnSaved: emailOnSaved,
                    passwordOnSaved: passwordOnSaved),
                FlatButton(
                  onPressed: null,
                  child: Text(
                    'آیا هیچ اکانتی ندارید؟ عضویت',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  sendDataForLogin();
                }
              },
              child: SignInAnimation(
                controller: _loginButtonController.view,
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendDataForLogin() async {
    // print(_emailValue+'****'+_passwordValue);
    await _loginButtonController.animateTo(0.150);
    Map response = await AuthService()
        .sendDataToServer({'email': _emailValue, 'password': _passwordValue});
    print(response);

    if (response['status'] == 'success') {
      await storeUserData(response);
      await _loginButtonController.forward();
      Navigator.pushReplacementNamed(context, '/');
    } else {
      await _loginButtonController.reverse();
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            response['data'],
            style: TextStyle(
              fontFamily: 'Vazir',
            ),
          ),
        ),
      );
    }
  }

  storeUserData(Map userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user.api_token', userData['user_token']);
    await prefs.setInt('user.user_id', userData['user_id']);
  }
}
