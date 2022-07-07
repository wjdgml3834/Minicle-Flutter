import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hanyang_flutter_project/screens/chat_screen.dart';

class CardReaderScreen extends StatefulWidget {
  CardReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<CardReaderScreen> createState() => _CardReaderScreenState();
}

class _CardReaderScreenState extends State<CardReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF13B082),
        elevation: 0.0,
        title: Text(
          '게시물',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            ),
            onPressed: () {},
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
              child: Text(
                widget.doc['post_writer'],
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              widget.doc['post_title'],
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              widget.doc['creation_date'],
              style: TextStyle(
                fontSize: 10.0,
              ),
            ),
            SizedBox(height: 28.0),
            Text(widget.doc['post_content'],
                style: TextStyle(
                  fontSize: 16.0,
                ),
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
