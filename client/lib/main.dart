//import 'dart:js';

import 'package:client/pages/entries.dart';
import 'package:client/pages/entryDetail.dart';
import 'package:client/pages/entryEdit.dart';
import 'package:client/pages/home.dart';
import 'package:client/pages/loading.dart';
import 'package:flutter/material.dart';
import 'NavBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';
import 'firebase/auth.dart';

// Global text style for demo the pages
const TextStyle demotextstyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
