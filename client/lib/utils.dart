// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
import 'package:client/firebase/authenticatedRequest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  const Event({
    required this.id,
    required this.take,
    required this.title,
    required this.type,
    required this.notes,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      take: json['take'],
      title: json['title'],
      type: json['type'],
      notes: json['notes'],
      date: json['date'],
    );
  }

  final String id;
  final bool take;
  final String notes;
  final String title;
  final String type;
  final DateTime date;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 12, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 12, kToday.day);
final difference = kLastDay.difference(kFirstDay).inDays;

//gets the list of calendar events from the database
Future<List<Event>> GetEvents() async {
  final response = await AuthenticatedRequest.get(
      url: Uri.parse('http://localhost:8080/calendar/'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Event> result = [];
    var jsonResponse = jsonDecode(response.body);
    for (var c in jsonResponse['userCalendarDocuments']) {
      c["date"] =
          Timestamp(c["date"]["seconds"], c["date"]["nanoseconds"]).toDate();

      result.add(Event.fromJson(c));
    }
    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load CalendarDocument');
  }
}

// var _kEventSource = null;
// var _kEvents = null;
/// Write code to grab the events from the database here
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.

Future<LinkedHashMap<DateTime, List<Event>>> getEventList() async {
  final listEvents = await GetEvents();
  //generates a map of all possible dates within range of the calendar. For each date we list the events that occur on that date
  final _kEventSource = Map<DateTime, List<Event>>.fromIterable(
      List.generate(
        difference,
        (index) => DateTime.utc(
            kFirstDay.year, kFirstDay.month, kFirstDay.day + index),
      ),
      key: (item) => item,
      value: (item) =>
          listEvents.where((event) => isSameDay(event.date, item)).toList());
  final events = LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  //every day of the calendar is a key in the map, and the value is a list of events that occur on that day
  _kEventSource.forEach((key, value) {
    events[key] = value;
  });
  return events;
}

final kEvents = getEventList();

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}
