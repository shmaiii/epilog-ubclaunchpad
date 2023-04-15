import 'dart:convert';

import 'package:client/firebase/authenticatedRequest.dart';
import 'package:firebase_auth/firebase_auth.dart';

class _auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _locationOfUser = '';

  void setLocation(String location) => _locationOfUser = location;
  String get getUserLocation => _locationOfUser;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    AuthObject.setLocation('');
  }
}

final AuthObject = _auth();
