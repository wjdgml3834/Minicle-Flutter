import 'package:flutter/material.dart';
import 'package:hanyang_flutter_project/screens/registration_screen.dart';
import 'package:hanyang_flutter_project/screens/login_screen.dart';
import 'package:hanyang_flutter_project/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  //main에서 welcome_screen route를 불러오기 위한 변수 선언
  //static 키워드를 쓴 이유는 메모리 효율을 위함임.
  static const String id = 'welcome_screen';



  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            Row(
              children: <Widget>[
                Container(
                  child: Image.asset('assets/icons/bird-logo.png'),
                  height: 60.0,
                ),
                Text(
                  '교양과목',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: '로그인',
              colour:Color(0xFF8AA2A0),
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              } ,
            ),
            RoundedButton(
              title: '회원가입',
              colour:Color(0xFF8AA2A0),
              onPressed: (){
                Navigator.pushNamed(context, RegistrationScreen.id);
              } ,
            ),
          ],
        ),
      ),
    );
  }
}

