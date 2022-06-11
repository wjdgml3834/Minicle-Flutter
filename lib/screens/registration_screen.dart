import 'package:flutter/material.dart';
import 'package:hanyang_flutter_project/components/rounded_button.dart';
import 'package:hanyang_flutter_project/constants.dart';

class RegistrationScreen extends StatefulWidget {

  RegistrationScreen({Key? key}) : super(key: key);

  static const String id = 'registration_screen';


  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200.0,
              child: Image.asset('assets/icons/bird-logo.png'),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration:  kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
           RoundedButton(title: '회원가입', colour: Color(0xFF8AA2A0), onPressed: (){})
          ],
        ),
      ),
    );
  }
}