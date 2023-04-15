import 'package:client/model/entries.dart';
import 'dart:convert';
import '../service/EntryManager.dart';

class UserEntryModel {
  String userId;
  EntriesModel entry;

  UserEntryModel({required this.userId, required this.entry});

  factory UserEntryModel.fromJson(userId, json) {
    EntriesModel model = EntriesModel(
      title: json['title'],
      dateTime: DateTime.parse(json['dateTime']),
      duration: json['duration'],
      activities: json['activities'],
      category: json['category'],
      type: json['type'],
      beforeEffects: json['beforeEffects'],
      afterEffects: json['afterEffects'],
      symptoms: json['symptoms'],
      checkUps: Map<String, bool>.from(json['checkUps']),
      additionalInfo: json['additionalInfo'],
      videoPath: json['videoPath'],
    );
    return UserEntryModel(userId: userId, entry: model);
  }

  //url: 'https://jsonplaceholder.typicode.com/todos',
  static List<UserEntryModel> getAll(response) {
    final result = json.decode(response.body);
    Iterable list = result['entry_list'];
    print(result);
    return list
        .map((model) => UserEntryModel.fromJson(model["id"], model["info"]))
        .toList();
  }

  Map toJson() {
    Map entry = this.entry.toJson();
    return {'userId': userId, 'entry': entry};
  }
}
