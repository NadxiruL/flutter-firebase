import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          //susunan latest msj akan duduk paling bawah
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatdocs = snapshot.data!.docs;
        return ListView.builder(
          //akan turkar scroll dari bawah ke atas.
          reverse: true,
          itemCount: chatdocs.length,
          itemBuilder: (context, index) {
            return Text(chatdocs[index]['text']);
          },
        );
      },
    );
  }
}
