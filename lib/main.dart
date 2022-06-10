import 'package:flutter/material.dart';
import 'package:hanyang_flutter_project/screens/chat_screen.dart';
import 'package:hanyang_flutter_project/screens/login_screen.dart';
import 'package:hanyang_flutter_project/screens/registration_screen.dart';
import 'package:hanyang_flutter_project/screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}


