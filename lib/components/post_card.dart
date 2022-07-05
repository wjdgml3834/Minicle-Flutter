import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget postCard(Function()? onTap, QueryDocumentSnapshot doc){
  return InkWell(
    onTap: onTap,
    child: Container(
    padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xFFC4C4C4)),
        ),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc['post_title'], style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),),
          SizedBox(height: 10.0),
          Text(doc['creation_date'], style: TextStyle(
            fontSize: 11.0,

          ),),
        ],
      ),
    ),
  );
}