import 'package:client/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreenDrawer extends StatefulWidget {
  const HomeScreenDrawer({super.key});

  @override
  State<HomeScreenDrawer> createState() => _HomeScreenDrawerState();
}

class _HomeScreenDrawerState extends State<HomeScreenDrawer> {
  @override
  Widget build(BuildContext context) {
//drawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 80.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Settings',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.library_books,
            ),
            title: const Text('Epilepsy resources',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text('Preferences',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
            ),
            title: const Text('Sign out',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            onTap: () async {
              try {
                await Auth().signOut();
              } on FirebaseAuthException catch (e) {
                setState(() {
                  print(e.message);
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
