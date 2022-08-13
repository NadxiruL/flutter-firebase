// ignore_for_file: prefer_const_constructors

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  //untuk trigger semua form bila button ditekan.
  final _formkey = GlobalKey<FormState>();

//check kita login mode atau signup mode
  var isLogin = true;

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _Login() {
    //guna _formkey untuk validate form.
    //panggil function validate()
    //validate() akan trigger semua validators dalam form.
    final isValid = _formkey.currentState!.validate();

    //Untuk guna tutup keyboard lepas submit
    FocusScope.of(context).unfocus();

    //check jika form itu valid
    if (isValid) {
      //akan masuk kesemua textfield dan akan trigger function onsaved
      _formkey.currentState!.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
      //Selepas disave akan gunakan values untuk send auth request kpd firebase..
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Email
                  TextFormField(
                    //kegunaan bila kita type sesuatu pada form , dia akan elakkan value pada form lama dekat form lain bila kita switch kepada login / signup

                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value.toString();
                    },
                  ),
                  //Username

                  //Jika x betul , paparkan dua formfied di bawah
                  //Bila tekan already have account , form username tak appear.
                  if (!isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Please enter more than 4 characters ';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value.toString();
                      },
                    ),
                  //Password
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length <= 7) {
                        return 'Password must greater than 7';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (value) {
                      _userPassword = value.toString();
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: _Login,
                    child: Text(isLogin ? 'Login' : 'Signup'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //Guna setState sebab bila kita tukar login mode akan effect ui
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
