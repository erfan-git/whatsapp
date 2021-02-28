import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final validator;
  final onSaved;

  InputFieldArea({this.hint , this.obscure , this.icon , this.validator , this.onSaved});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),

      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
        obscureText: obscure,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
            enabledBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                    color: Colors.white30
                )
            ),
            focusedBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                    color: Colors.white
                )
            ),
            errorStyle: new TextStyle(color : Colors.amber),
            errorBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                    color: Colors.amber
                )
            ),
            focusedErrorBorder: new UnderlineInputBorder(
                borderSide: new BorderSide(
                    color: Colors.amber
                )
            ),
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
          ),
          contentPadding: EdgeInsets.only(
            top: 15, right: 0, bottom: 20, left: 5
          )
        ),
      ),
    );
  }
}
