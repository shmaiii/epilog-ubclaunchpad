import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<Medication>> readMedications() async {
  final response = await http.get(Uri.parse(
      'http://localhost:8080/user/pw8swdwzWDz4HrsB1dWC/medications/read'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Medication> result = [];
    for (var m in jsonDecode(response.body)) {
      result.add(Medication.fromJson(m));
    }
    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load medications');
  }
}

Future<String> addMedication(String name, String administrationMethod, String dosage) async {
  final response = await http.post(
      Uri.parse(
          'http://localhost:8080/user/pw8swdwzWDz4HrsB1dWC/medications/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'administration_method': administrationMethod,
        'dosage': dosage
      }));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to add medication');
  }
}

Future<String> editMedication(String name, String administrationMethod, String dosage, String medicationId) async {
  final response = await http.post(
      Uri.parse(
          'http://localhost:8080/user/pw8swdwzWDz4HrsB1dWC/medications/$medicationId/edit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'administration_method': administrationMethod,
        'dosage': dosage
      }));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to edit medication');
  }
}

Future<String> deleteMedication(String medicationId) async {
  final response = await http.post(
      Uri.parse(
          'http://localhost:8080/user/pw8swdwzWDz4HrsB1dWC/medications/$medicationId/delete'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to delete medication');
  }
}

class Medication {
  final String id;
  final String name;
  final String administrationMethod;
  final String dosage;

  const Medication({
    required this.id,
    required this.name,
    required this.administrationMethod,
    required this.dosage,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      administrationMethod: json['administration_method'],
      dosage: json['dosage'],
    );
  }
}
