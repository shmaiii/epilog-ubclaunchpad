import 'dart:convert';

import 'package:client/service/entryManager.dart';

class EntriesModel {
  final String title;
  final DateTime dateTime;
  final String duration;
  final String activities;
  final String category;
  final String type;
  final String beforeEffects;
  final String afterEffects;
  final String symptoms;
  final Map<String, bool> checkUps;

  EntriesModel({
    required this.title,
    required this.dateTime,
    required this.duration,
    required this.activities,
    required this.category,
    required this.type,
    required this.beforeEffects,
    required this.afterEffects,
    required this.symptoms,
    required this.checkUps,
  });

  factory EntriesModel.fromJson(Map<String, dynamic> json) {
    return EntriesModel(
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      duration: json['duration'],
      activities: json['activities'],
      category: json['category'],
      type: json['type'],
      beforeEffects: json['beforeEffects'],
      afterEffects: json['afterEffects'],
      symptoms: json['symptoms'],
      // checkUps: Map<String, bool>.from(json['checkUps']),
      checkUps: (json['checkUps'] is Map<String, dynamic>)
        ? Map<String, bool>.from(json['checkUps'])
        : {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'dateTime': dateTime.toIso8601String(),
      'duration': duration,
      'activities': activities,
      'category': category,
      'type': type,
      'beforeEffects': beforeEffects,
      'afterEffects': afterEffects,
      'symptoms': symptoms,
      'checkUps': checkUps,
    };
  }

  static Resource<List<EntriesModel>> get all {
    return Resource(
        url: 'http://localhost:8080/entries/all',
        parse: (response) {
          final result = json.decode(response.body);
          print(result);
          Iterable list = result['entry_list'];
          print(list);
          return list.map((model) => EntriesModel.fromJson(model['info'])).toList();
        }
      );
  }
}