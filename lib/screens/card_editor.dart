import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;
DateTime date = DateTime.now();

class CardEditorScreen extends StatefulWidget {
  const CardEditorScreen({Key? key}) : super(key: key);

  @override
  State<CardEditorScreen> createState() => _CardEditorScreenState();
}

class _CardEditorScreenState extends State<CardEditorScreen> {
  String dateResult = DateFormat('yy/MM/dd - HH:mm:ss').format(date);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
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
        print(dateResult);
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF13B082),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('글쓰기')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Color(0xFFC4C4C4)),
                ),
                hintText: '제목',
              ),
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 28.0),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '내용을 입력해주세요',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width:70,
        height: 70,
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xFF13B082) ,
          onPressed: () async {
            FirebaseFirestore.instance.collection('posts').add({
              'post_title': _titleController.text,
              'creation_date': dateResult,
              'post_content': _mainController.text,
              'post_writer' : loggedInUser.email
            }).then((value) {
              print(value.id);
              Navigator.pop(context);
            }).catchError((error) => print('새로운 게시물 생성 실패 이유는 $error'));
          },
          label: Text('글쓰기', style: TextStyle(
            fontSize: 20.0
          ),),

        ),
      ),
    );
  }
}
