import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              color: Color.fromARGB(146, 123, 7, 191),
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
              color: Color.fromARGB(146, 123, 7, 191),
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
              color: Color.fromARGB(146, 123, 7, 191),
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
              color: Color.fromARGB(146, 123, 7, 191),
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

  Widget buildSignUpBtn() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('   SIGN UP   '),
            Icon(
              Icons.arrow_forward,
              size: 50,
              color: Color.fromARGB(146, 123, 7, 191),
            )
          ],
        ),
        onPressed: () => print("name: " +
            nameController.text +
            "; email: " +
            emailController.text +
            "; password: " +
            passwordController.text +
            "; confirm password: " +
            confirmPasswordController.text),
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 238, 238, 232),
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
                  color: Color.fromARGB(146, 123, 7, 191),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        )
      ],
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
                      buildEmail(),
                      SizedBox(height: 30),
                      buildPassword(),
                      SizedBox(height: 30),
                      buildConfirmPassword(),
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
