import 'dart:convert';

import 'package:client/firebase/auth.dart';
import 'package:client/firebase/authenticatedRequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signUpScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errorMsg = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Widget buildSignIn() {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sign In',
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          )),
      SizedBox(height: 30),
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Please sign in to continue.',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ))
    ]);
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email:',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
        TextField(
          textAlign: TextAlign.start,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email_outlined,
                size: 30,
                color: Color(0xff6247AA),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.black38)),
        ),
        Divider(
          height: 0,
          color: Colors.black,
          thickness: 5,
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password:',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
        TextField(
          textAlign: TextAlign.start,
          controller: passwordController,
          obscureText: true,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                size: 30,
                color: Color(0xff6247AA),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.black38)),
        ),
        Divider(
          height: 0,
          color: Colors.black,
          thickness: 5,
        ),
      ],
    );
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print("Forgot Password pressed"),
        child: Text('Forgot Password?',
            style: TextStyle(
                color: Color(0xff6247AA), fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthObject.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMsg = e.code == 'unknown'
            ? 'Email and/or password is empty'
            : e.message ?? 'Invalid email and/or password';
      });
    }
  }

  Widget buildLoginBtn() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '    LOGIN    ',
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
            ),
          ],
        ),
        onPressed: () async {
          await signInWithEmailAndPassword();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff6247AA),
            foregroundColor: Colors.black87,
            elevation: 5,
            padding: EdgeInsets.all(5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
      ),
    );
  }

  Widget buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.normal)),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: Text('Sign Up',
              style: TextStyle(
                  color: Color(0xff6247AA),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        )
      ],
    );
  }

  Widget buildErrorMessageText() {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 0),
      child: Text(
        _errorMsg,
        style: TextStyle(
            color: Colors.red.withOpacity(1.0),
            fontSize: 16,
            fontWeight: FontWeight.normal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 80),
                      buildSignIn(),
                      SizedBox(height: 70),
                      buildEmail(),
                      SizedBox(height: 50),
                      buildPassword(),
                      buildForgotPassBtn(),
                      buildErrorMessageText(),
                      buildLoginBtn(),
                      SizedBox(height: 70),
                      buildSignUpBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
