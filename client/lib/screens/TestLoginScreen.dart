import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase/auth.dart';

class TestLoginScreen extends StatefulWidget {
  const TestLoginScreen({super.key});

  @override
  State<TestLoginScreen> createState() => _TestLoginScreenState();
}

class _TestLoginScreenState extends State<TestLoginScreen> {
  String _errorMsg = '';
  bool _isRegister = false;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await AuthObject.signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMsg = e.message ?? '';
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await AuthObject.createUserWithEmailAndPassword(
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
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: title),
      ),
    );
  }

  Widget _submitButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 100,
        child: ElevatedButton(
            onPressed: _isRegister
                ? createUserWithEmailAndPassword
                : signInWithEmailAndPassword,
            child: Text(_isRegister ? 'Register' : 'Login')),
      ),
    );
  }

  Widget _signinOrRegisterButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 150,
        child: ElevatedButton(
            onPressed: () => {
                  setState(() {
                    _isRegister = !_isRegister;
                    _errorMsg = '';
                    _controllerEmail.clear();
                    _controllerPassword.clear();
                  })
                },
            child: Text(_isRegister ? 'Login instead' : 'Register instead')),
      ),
    );
  }

  Widget _pageTitle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        _isRegister ? 'Sign Up' : 'Sign In',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(55),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _pageTitle(),
              _entryField('email', _controllerEmail),
              _entryField('password', _controllerPassword),
              Row(
                children: [
                  _submitButton(),
                  _signinOrRegisterButton(),
                ],
              ),
              Text(
                _errorMsg,
                textAlign: TextAlign.center,
              )
            ],
          ))),
    );
  }
}
