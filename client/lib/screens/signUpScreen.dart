import 'dart:convert';

import 'package:client/firebase/auth.dart';
import 'package:client/firebase/authenticatedRequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _errorMsg = '';
  String selectedLocation = "Canada";
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    confirmPasswordController.dispose();
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  Widget buildLocationDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Location:",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DropdownButton2(
                underline: Container(
                  height: 2,
                  color: Color(0xff6247AA),
                ),
                iconStyleData:
                    IconStyleData(iconEnabledColor: Color(0xff6247AA)),
                isExpanded: true,
                value: selectedLocation,
                items: [
                  DropdownMenuItem(child: Text("Canada"), value: "Canada"),
                  DropdownMenuItem(child: Text("USA"), value: "USA"),
                ],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLocation = newValue!;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCreateAccount() {
    return Column(children: <Widget>[
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Create',
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          )),
      Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Account',
            style: TextStyle(
                color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
          ))
    ]);
  }

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Enter Full Name:',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
        TextField(
          textAlign: TextAlign.start,
          controller: nameController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.person,
              size: 30,
              color: Color(0xff6247AA),
            ),
          ),
        ),
        Divider(
          height: 0,
          color: Colors.black,
          thickness: 5,
        ),
      ],
    );
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Enter Email:',
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
          ),
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
          'Enter Password:',
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
          ),
        ),
        Divider(
          height: 0,
          color: Colors.black,
          thickness: 5,
        ),
      ],
    );
  }

  Widget buildConfirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirm Password:',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.normal),
        ),
        SizedBox(height: 10),
        TextField(
          textAlign: TextAlign.start,
          controller: confirmPasswordController,
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
          ),
        ),
        Divider(
          height: 0,
          color: Colors.black,
          thickness: 5,
        ),
      ],
    );
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      if (nameController.text.isEmpty) {
        setState(() {
          _errorMsg = 'Full Name is empty ';
        });
      } else if (passwordController.text != confirmPasswordController.text) {
        setState(() {
          _errorMsg = 'Passwords do not match';
        });
      } else {
        await Auth().createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await AuthenticatedRequest.post(
            path: '/user/personal-information/store',
            body: jsonEncode(<String, String>{
              'name': nameController.text,
              'location': selectedLocation
            }));
        setState(() {
          _errorMsg = '';
        });
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMsg = e.code == 'unknown'
            ? 'Email and/or password is empty'
            : e.message ?? 'Invalid email and/or password';
      });
    }
  }

  Widget buildSignUpBtn() {
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
                '   SIGN UP   ',
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
            ),
          ],
        ),
        onPressed: createUserWithEmailAndPassword,
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

  Widget buildSignInBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Already have an account?',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.normal)),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Sign In',
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
      padding: const EdgeInsets.only(top: 20.0, bottom: 0),
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
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30),
                      buildCreateAccount(),
                      SizedBox(height: 50),
                      buildName(),
                      SizedBox(height: 30),
                      buildLocationDropdown(),
                      SizedBox(height: 30),
                      buildEmail(),
                      SizedBox(height: 30),
                      buildPassword(),
                      SizedBox(height: 30),
                      buildConfirmPassword(),
                      buildErrorMessageText(),
                      buildSignUpBtn(),
                      buildSignInBtn(),
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
