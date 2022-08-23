import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  //message apa yang dimasukkan.
  var _enteredMessage = '';

  final _controller = new TextEditingController();

  //fungsi untuk send mesej.

  void _sendMessage() async {
    //get current user.
    final user = await FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    //close keyboard..
    FocusScope.of(context).unfocus();
    //to create new mesej
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,

      //timestamp datang dari firebase
      'createdAt': Timestamp.now(),

      //add user id to outgoing chat messages.
      'userId': user.uid,
      'username': userData['username'],
    });

//clear text lepas send.
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'send a message'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            //potong unnecessary space dan disable button kalo textfield tu kosong
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
