import 'package:flutter/material.dart';
import 'package:hanyang_flutter_project/components/rounded_button.dart';
import 'package:hanyang_flutter_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanyang_flutter_project/screens/chat_screen.dart';
import 'package:hanyang_flutter_project/screens/home_screen.dart';
import 'package:hanyang_flutter_project/screens/registration_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'MINICLE',
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '내손안에 작은 클래스',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                onChanged: (value) {
                 email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: '이메일'),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.start,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: '비밀번호'),
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                  title: '로그인',
                  colour: Color(0xFF13B082),
                  mainBtnColor: true,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(user != null){
                        Navigator.pushNamed(context, HomeScreen.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  }),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    color: Color(0xFF13B082),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
