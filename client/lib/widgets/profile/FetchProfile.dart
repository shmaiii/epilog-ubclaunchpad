import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ProfileInfo> fetchProfile() async {
  final response = await http.get(Uri.parse(
      'http://localhost:8080/user/pw8swdwzWDz4HrsB1dWC/personal-information/read'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ProfileInfo.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class ProfileInfo {
  final String full_name;
  final String address;
  final int age;

  const ProfileInfo({
    required this.full_name,
    required this.address,
    required this.age,
  });

  factory ProfileInfo.fromJson(Map<String, dynamic> json) {
    return ProfileInfo(
      full_name: json['Full Name'],
      address: json['Address'],
      age: json['Age'],
    );
  }
}

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyAppState();
}

class _MyAppState extends State<MyProfile> {
  late Future<ProfileInfo> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<ProfileInfo>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.full_name.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
