// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:client/utils.dart';

class TableBasicsExample extends StatefulWidget {
  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<Event>> allEvents;
  @override
  void initState() {
    super.initState();
    getEvents().then((value) {
      setState(() {
        allEvents = value;
      });
    });
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier([]);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose(); // Call super class to dispose of inherited resources.
  }

  Future<Map<DateTime, List<Event>>> getEvents() async {
    final events = await kEvents;
    return events;
  }

  // Future<List<Event>> getEventsForDay(DateTime day) async {
  //   final events = await getEvents();
  //   if (events.containsKey(day)) {
  //     return events[day]!;
  //   } else {
  //     return [];
  //   }
  // }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = allEvents[selectedDay]!;
    }
  }

  void _showEventDetails(Event event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(IconData(0xf06bb, fontFamily: 'MaterialIcons')),
              SizedBox(width: 10),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Text("Details for: ${event.title}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(IconData(0xe0c2, fontFamily: 'MaterialIcons')),
                    SizedBox(width: 10),
                    Text("Time: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 50),
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${event.date.toString().split(' ')[1].split(':')[0]}:${event.date.toString().split(' ')[1].split(':')[1]}',
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Icon(IconData(0xe148, fontFamily: 'MaterialIcons')),
                    SizedBox(width: 10),
                    Text("Type: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 50),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            event.type,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Icon(IconData(0xe44c, fontFamily: 'MaterialIcons')),
                    SizedBox(width: 10),
                    Text("Notes: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 50),
                    Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            event.notes,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Icon(IconData(0xf0555, fontFamily: 'MaterialIcons')),
                    SizedBox(width: 10),
                    Text("Status: ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 50),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                                event.type.toUpperCase() == 'MEDICATION'
                                    ? (event.take ? "Taken" : "Not Taken")
                                    : 'Not applicable',
                                softWrap: true,
                                overflow: TextOverflow.visible))),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Calendar',
            style: TextStyle(
              fontSize: 22,
            )),
      ),
      body: FutureBuilder<Map<DateTime, List<Event>>>(
        future: getEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            allEvents = snapshot.data!;
            return Column(
              children: [
                TableCalendar<Event>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  eventLoader: (day) => allEvents[day]!,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 32.0),
                Text("Today's events", style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 8.0),
                Expanded(
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                                onTap: () => _showEventDetails(value[index]),
                                title: Row(
                                  children: [
                                    Expanded(child: Text(value[index].title)),
                                    SizedBox(width: 50),
                                    Text(
                                        '${value[index].date.toString().split(' ')[1].split(':')[0]}:${value[index].date.toString().split(' ')[1].split(':')[1]}')
                                  ],
                                )),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
