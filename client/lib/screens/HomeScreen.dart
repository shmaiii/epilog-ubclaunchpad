import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase/auth.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  Future<void> signoutTest() async {
    try {
      await Auth().signOut();
    } on FirebaseAuthException catch (e) {
      setState(() {
        print(e.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 5.0,
        leading: const Icon(
          Icons.bar_chart_rounded,
          size: 35.0,
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.search,
              size: 35.0,
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Hi Julia",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: signoutTest, child: Text("Signout Test")),
              ),
              InkWell(
                onTap: () {
                  print("testing");
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0XFFEDF3FF),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.calendar_today,
                        color: Color(0XFF0342E9),
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
