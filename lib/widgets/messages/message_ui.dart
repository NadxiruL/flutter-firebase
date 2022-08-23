import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageUi extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;
  final Key keyz;

  const MessageUi(
      {super.key,
      required this.message,
      required this.isMe,
      required this.keyz,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      //cek jika dari kita position belan kiri. kalo orang lain belah kanan.
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              //check jika isMe is true kluar kaler grey kalo tak kaler lain
              color: isMe ? Colors.grey[300] : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                //cek jika masih dari kita position macam mana.
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              )),
          width: 140,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // FutureBuilder(
              //     //nak dapatkan username
              //     future: FirebaseFirestore.instance
              //         .collection('users')
              //         .doc(username)
              //         .get(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Text('loading....');
              //       }
              //       return

              Text(
                username,
                // snapshot.data!['username'],
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isMe ? Colors.blue : Colors.amber),
              ),

              Text(
                message,
                //jika isMe betul text kaler biru , kalo bukan user jadi warna lain
                style: TextStyle(color: isMe ? Colors.blue : Colors.amber),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
