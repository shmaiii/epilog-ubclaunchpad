import 'package:flutter/material.dart';
import 'package:client/list_alt_filled_icons.dart';
import 'screens/EntryScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/NotificationScreen.dart';
import 'screens/ProfileScreen.dart';
import 'screens/RecordScreen.dart';
import 'screens/LoginScreen.dart';
import 'firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seizure Tracker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: EntryController(),
    );
  }
}

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
          return signedIn ? const HomePage(title: 'Home Page') : LoginScreen();
        }
        return Container(
          color: Colors.black,
        );
      },
    );
  }
}

// Home Page widget, it is the center of controlling all pages, doesn't mean any actual "screen" here
// Stateful widget since the contents might change
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of our application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

// Home page state that actually do the state changes
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of screens for the naviagation bar to choose from, contents are in other files
  final _screens = [
    const HomeScreen(),
    const EntryScreen(),
    const RecordScreen(),
    const NotificationScreen(),
    ProfileScreen(),
    const LoginScreen(),
  ];

  // Helper function for change the states
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Widget for the global layouts, including appBar, demo title, and the navigation bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar at the top of the page
      appBar: AppBar(
          title: const Center(
        child: Text('Seizure Tracker'),
      )),

      // Body content at the middle of the page
      body: Center(
        child: _screens[_selectedIndex],
      ),

      // Navigation bar at the bottom of the page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            activeIcon: Icon(List_alt_filled.filled),
            label: 'Entries',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio_button_checked_rounded),
            activeIcon: Icon(Icons.radio_button_checked_rounded),
            label: 'Record',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications_sharp),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person_sharp),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle),
            activeIcon: Icon(Icons.circle),
            label: 'Login',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 233, 233, 233),
        selectedFontSize: 13.5,
        unselectedFontSize: 13.5,
      ),
    );
  }
}
