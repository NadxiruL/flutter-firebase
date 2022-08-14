// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  //loading progress
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String username,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    //gunakan firebase untuk login atau create user
    //

    //UserCredential is a type from signinwithemailandpassword
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
      //catch any errors if occurs
    } on PlatformException catch (error) {
      var message = "An error occured , please check your credentials";
      if (error.message != null) {
        message = error.message as String;
      }
      Scaffold.of(context).showBottomSheet((context) {
        return BottomSheet(
          builder: (context) => Text(message),
          onClosing: () {},
        );
      });
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        submitForm: _submitAuthForm,
        isLoading: _isLoading,
      ),
    );
  }
}
