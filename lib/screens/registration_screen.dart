import 'package:flutter/material.dart';
import 'package:hanyang_flutter_project/components/rounded_button.dart';
import 'package:hanyang_flutter_project/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hanyang_flutter_project/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hanyang_flutter_project/screens/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  //스피너 관련 변수.
  bool showSpinner = false;
  //유저가 입력해놓은 것을 저장하기 위한 변수.
  // late은 선언이 먼저되고, 나중에 할당한다.
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        //스피너 관련 코드. 쓸대 body쪽에 ModalProgressHUD로 감싸주고 inAsyncCall로 스피너 돌지 말지 결정.
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
                  //유저가 타이핑한것을 save하기 위함임.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: '이메일을 입력해주세요'),
              ),
              SizedBox(
                height: 16.0,
              ),
              TextField(
                //password가 보이지 않도록 처리.
                obscureText: true,
                //유저가 입력한 텍스트가 가운데로 올 수 있도록.
                textAlign: TextAlign.start,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: '비밀번호를 입력해주세요'),
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                title: '가입하기',
                colour: Color(0xFF13B082),
                mainBtnColor : true,
                onPressed: () async {
                  setState(() {
                    showSpinner =true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if(newUser != null){
                      Navigator.pushNamed(context, HomeScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
