import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './firebase/auth.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _errorMsg = '';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);

      var uid = await Auth().currentUser?.getIdToken() ?? 'none';
      if (uid != 'none') {
        var response = await http.get(
          Uri.parse('http://10.0.2.2:8080/calendar/Reminder_Test_User'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + uid,
          },
        );
        print(response.body);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMsg = e.message ?? '';
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMsg = e.message ?? '';
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _signInButton() {
    return ElevatedButton(
        onPressed: signInWithEmailAndPassword, child: const Text('Login'));
  }

  Widget _registerButton() {
    return ElevatedButton(
        onPressed: createUserWithEmailAndPassword,
        child: const Text('Register'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _entryField('email', _controllerEmail),
              _entryField('password', _controllerPassword),
              _signInButton(),
              _registerButton(),
              Text(_errorMsg)
            ],
          ))),
    );
  }
}
