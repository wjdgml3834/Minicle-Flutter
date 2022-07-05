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
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background_image_green.png'))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'MINICLE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '내손안에 작은 클래스',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 356.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(0),
                backgroundColor: Colors.white,
              ),
              child: Text(
                '로그인',
                style: TextStyle(
                  color: Color(0xFF13B082),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 38.0)
          ],
        ),
      ),
    );
  }
}
