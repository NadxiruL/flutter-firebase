import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../messages/message_ui.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //dapatkan samada message ini dari current user id atau tidak. dari user atau orang lain .
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          //check , kita tak ada information about user.
          return Center(
            child: CircularProgressIndicator(),
          );
        }

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
                  return MessageUi(
                    username: chatdocs[index]['username'],
                    message: chatdocs[index]['text'],

                    //compare if user id sama dengan data
                    isMe: chatdocs[index]['userId'] == futureSnapshot.data!.uid,
                    keyz: ValueKey(chatdocs[index].id),
                  );
                },
              );
            });
      },
    );
  }
}
