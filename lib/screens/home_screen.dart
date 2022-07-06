import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hanyang_flutter_project/components/post_card.dart';
import 'package:hanyang_flutter_project/screens/card_reader.dart';
import 'package:hanyang_flutter_project/screens/login_screen.dart';

import 'card_editor.dart';

//Firestore 관련 변수
final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //로그인한 최근 유저가 있는지 체크하는 함수
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    // final double itemHeight = (size.height - kToolbarHeight - 24) / 6 ;
    // final double itemWidth = size.width ;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          TextButton(
              child: Text('로그아웃', style: TextStyle(color: Color(0xFF13B082)),),
              onPressed: () {
                //버튼 누르면 로그아웃 되게.
                _auth.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        shape: Border(
            bottom: BorderSide(
          color: Color(0xFFC4C4C4),
          width: 1,
        )),
        title: Text(
          'MINICLE',
          style: TextStyle(
            color: Color(0xFF13B082),
            fontSize: 25.0,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "실시간 인기 글",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('posts').orderBy('creation_date').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                return Expanded(
                  child: SizedBox(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1.0, color: Color(0xFFC4C4C4)),
                        ),
                      ),
                      child: ListView(
                        children: snapshot.data!.docs.reversed
                            .map((card) => postCard(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CardReaderScreen(card),
                                      ));
                                }, card))
                            .toList(),
                      ),
                    ),
                  ),
                );
              }
              return Text('생성된 게시물이 없습니다.');
            },
          )
        ],
      ),
      floatingActionButton: Container(
        width: 70.0,
        height: 70.0,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CardEditorScreen()));
          },
          label: Icon(Icons.create, size: 35.0),
          backgroundColor: Color(0xFF13B082),
        ),
      ),
    );
  }
}
