import 'package:client/widgets/profile/MultipleButton.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MultipleButton(),
      ),
    );
  }
}