import 'dart:async';
import 'dart:convert';
import 'package:client/firebase/authenticatedRequest.dart';

Future<List<Contact>> readContacts() async {
  final response = await AuthenticatedRequest.get(
      url: Uri.parse(
          'http://10.0.2.2:8080/contacts/user/pw8swdwzWDz4HrsB1dWC/contacts/read'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Contact> result = [];
    for (var m in jsonDecode(response.body)) {
      result.add(Contact.fromJson(m));
    }
    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load contacts');
  }
}

Future<String> addContact(String name, String phoneNumber, String type) async {
  final response = await AuthenticatedRequest.post(
      url: Uri.parse(
          'http://10.0.2.2:8080/contacts/user/pw8swdwzWDz4HrsB1dWC/contacts/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phoneNumber': phoneNumber,
        'type': type
      }));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to add contact');
  }
}

Future<String> editContact(
    String name, String phoneNumber, String type, String contactId) async {
  final response = await AuthenticatedRequest.post(
      url: Uri.parse(
          'http://10.0.2.2:8080/contacts/user/pw8swdwzWDz4HrsB1dWC/contacts/$contactId/edit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'phoneNumber': phoneNumber,
        'type': type
      }));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to edit contact');
  }
}

Future<String> deleteContact(String contactId) async {
  final response = await AuthenticatedRequest.post(
      url: Uri.parse(
          'http://10.0.2.2:8080/contacts/user/pw8swdwzWDz4HrsB1dWC/contacts/$contactId/delete'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to delete contact');
  }
}

class Contact {
  final String id;
  final String name;
  final String phoneNumber;
  final String type;

  const Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.type,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      type: json['type'],
    );
  }
}
