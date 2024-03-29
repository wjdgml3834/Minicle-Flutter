import 'package:flutter/material.dart';
import 'package:hanyang_flutter_project/screens/chat_screen.dart';
import 'package:hanyang_flutter_project/screens/login_screen.dart';
import 'package:hanyang_flutter_project/screens/registration_screen.dart';
import 'package:hanyang_flutter_project/screens/welcome_screen.dart';
import 'package:hanyang_flutter_project/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  //파이어 베이스 initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //route를 위한 코드들. 문자로만 하면 오타시 앱이 충돌나기에 변수로 route 불러와줌.
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          HomeScreen.id: (context) => HomeScreen(),
        });
  }
}
