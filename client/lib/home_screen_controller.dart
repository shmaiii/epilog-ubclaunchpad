import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

Future<List<HomepageReminderDocument>>
    readAllHomepageReminderDocuments() async {
  final response = await http.get(
      Uri.parse('http://localhost:8080/homepageReminder/home_page_calendar'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<HomepageReminderDocument> result = [];
    var jsonResponse = jsonDecode(response.body);

    for (var c in jsonResponse['userReminderDocuments']) {
      c["date"] =
          Timestamp(c["date"]["seconds"], c["date"]["nanoseconds"]).toDate();

      result.add(HomepageReminderDocument.fromJson(c));
    }
    // sort entries based on date and time
    result.sort((a, b) => a.date.compareTo(b.date));

    // fliter out entries that are past current time
    DateTime now = DateTime.now();
    // Calculate the time 8 hours from now
    DateTime eightHoursLater = now.add(const Duration(hours: 8));
    DateTime midnight = DateTime(now.year, now.month, now.day, 23, 59, 59);
    result = result
        .where((entry) =>
            (entry.date).isAfter(now) &&
            (entry.date).isBefore(eightHoursLater) &&
            (entry.date).isBefore(midnight))
        .toList();

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load CalendarDocument');
  }
}

Future<String> editHomepageReminderDateTime(
    String reminderId, String dateTime) async {
  final response = await http.patch(
      Uri.parse(
          'http://localhost:8080/homepageReminder/home_page_calendar/update/$reminderId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'date': dateTime}));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to reschedule homepage reminder');
  }
}

Future<String> deleteHomepageReminder(String reminderId) async {
  print('anything here?????');
  final response = await http.delete(Uri.parse(
      'http://localhost:8080/homepageReminder/home_page_calendar/delete/$reminderId'));

  if (response.statusCode == 200) {
    return response.body;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to delete homepage reminder');
  }
}

class HomepageReminderDocument {
  final String id;
  final String title;
  final String type;
  final String notes;
  final DateTime date;
  //final DateTime date;

  const HomepageReminderDocument({
    required this.id,
    required this.title,
    required this.type,
    required this.notes,
    required this.date,
  });

  factory HomepageReminderDocument.fromJson(Map<String, dynamic> json) {
    return HomepageReminderDocument(
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
    return 'HomepageReminderDocument(title: $title, date: $date)';
  }
}
