import 'package:client/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'NavBar.dart';

class EntryController extends StatelessWidget {
  const EntryController({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<User?> authStateChangesStream = Auth().authStateChanges;

    return StreamBuilder(
      stream: authStateChangesStream,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? const MyApp() : LoginScreen();
        }
        return Container(
          color: Colors.black,
        );
      },
    );
  }
}
