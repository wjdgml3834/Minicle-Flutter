import 'package:flutter/material.dart';
import 'package:hanyang_flutter_project/constants.dart';
import 'package:hanyang_flutter_project/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


//Firestore 관련 변수
final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //텍스트 에디팅과 관련. Text 필드에 쓸 수 있다.
  final messageTextController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  //유저가 보낸 메세지 텍스트를 저장해놓는 변수.
  late String messageText;

  //시작하자마자 불러올수있게
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

  //문서들 정보를 불러오는 코드
  // void getMessages () async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var message in messages.docs){
  //     print(message.data());
  //   }
  // }

  // 실시간으로 데이터들 불러오는 코드
  // void messageStream() async {
  //   await _firestore.collection('messages').snapshots().forEach((snapshot) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF13B082),
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.id);
              }),
        ],
        title: Text('️채팅'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      //텍스트 컨트롤러 등록
                      controller: messageTextController,
                      onChanged: (value) {
                        // 유저가 입력한 값 변수에 저장
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //send 버튼 누르면 필드값이 비어지게.
                      messageTextController.clear();
                      // 컬렉션과 필드값 작성.
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedInUser.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //StreamBuilder를 통해 stream을 UI로 표시해준다.
    return StreamBuilder<QuerySnapshot>(
      //set up the Stream, weher all the data are coming from
      stream: _firestore.collection('messages').snapshots(),
      //lets build this. 빌더가 어떤역할을 하는지 로직을 짜야한다.
      // 인자로 BuildContext랑 AsyncSnapshot를 받는다.
      //AsyncSnapshot은 stream이랑 상호작용을 한다.

      builder: (context, snapshot) {
        //create a list of widgets
        List<MessageBubble> messageBubbles = [];

        //check if we got data or not
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFF13B082),
            ),
          );
        }
        //load in our data list. snapshot 데이터에 접근. document 리스트를 줄것이다.
        final messages = snapshot.data!.docs.reversed;
        //loop all of data in our list
        for (var message in messages) {
          //get text. 필드 얻기. 이렇게 하면 value 값을 얻게된다.
          final messageText = message.get('text');
          //get sender. 필드얻기.
          final messageSender = message.get('sender');

          final currentUser = loggedInUser.email;

          //create a new Text Widget
          final messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: currentUser == messageSender);

          //add this Widget to our Widget list
          messageBubbles.add(messageBubble);
        }

        return Expanded(
          // Expanded와 ListView는 넘쳤을때 스크롤 제공하게 하기 위함. UI 안깨지게.
          child: ListView(
            //가장 최근 메세지 하단으로 가게.
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key? key, required this.sender, required this.text, required this.isMe})
      : super(key: key);

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            //채팅 네모 둥글게
            borderRadius: isMe ? BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ) : BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            //box shadow 주는것임.
            elevation: 5.0,
            color: isMe ? Color(0xFF13B082) : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
