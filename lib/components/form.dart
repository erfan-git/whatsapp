import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:whatsapp/components/inputFields.dart';

class FormContainer extends StatelessWidget {
  final formKey;
  final emailOnSaved;
  final passwordOnSaved;

  FormContainer({@required this.formKey, this.emailOnSaved , this.passwordOnSaved });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                InputFieldArea(
                  validator: (String value){
                    if(value.length < 4){
                      return'اعتبار لازم نیست';
                    }
                    if(!isEmail(value)){
                      return 'ایمیل وارد شده صحیح نیست';
                    }
                  },
                  onSaved : emailOnSaved,
                  hint: 'ایمیل کاربری',
                  obscure: false,
                  icon: Icons.person_outline,
                ),
                InputFieldArea(
                  validator: (String value){
                    if(value.length < 5){
                      return 'طول پسورد شما نمیتواند کمتر از 6 باشد';
                    }
                  },
                  onSaved : passwordOnSaved,
                  hint: 'رمز عبور',
                  obscure: true,
                  icon: Icons.lock_open,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
