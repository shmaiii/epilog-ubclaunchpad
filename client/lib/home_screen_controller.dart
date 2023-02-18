import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:http/http.dart' as http;

Future<List<CalendarDocument>> readAllCalendarDocuments() async {
  final response = await http
      .get(Uri.parse('http://localhost:8080/calendar/home_page_calendar'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<CalendarDocument> result = [];
    var jsonResponse = jsonDecode(response.body);
    for (var c in jsonResponse['userCalendarDocuments']) {
      c["date"] =
          Timestamp(c["date"]["seconds"], c["date"]["nanoseconds"]).toDate();

      result.add(CalendarDocument.fromJson(c));
    }
    // sort entries based on date and time
    result.sort((a, b) => a.date.compareTo(b.date));

    // fliter out entries that are past current time
    result =
        result.where((entry) => (entry.date).isAfter(DateTime.now())).toList();

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load CalendarDocument');
  }
}

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

Future<String> addMedication(
    String name, String administrationMethod, String dosage) async {
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

Future<String> editMedication(String name, String administrationMethod,
    String dosage, String medicationId) async {
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
  final response = await http.post(Uri.parse(
      'http://localhost:8080/user/pw8swdwzWDz4HrsB1dWC/medications/$medicationId/delete'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to delete medication');
  }
}

class CalendarDocument {
  final String id;
  final String title;
  final String type;
  final String notes;
  final DateTime date;
  //final DateTime date;

  const CalendarDocument({
    required this.id,
    required this.title,
    required this.type,
    required this.notes,
    required this.date,
  });

  factory CalendarDocument.fromJson(Map<String, dynamic> json) {
    return CalendarDocument(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      notes: json['notes'],
      date: json['date'],
    );
  }
  // For testing purposes
  @override
  String toString() {
    return 'CalendarDocument(title: $title, date: $date)';
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
