import 'package:client/model/entries.dart';
import 'package:client/model/userEntryModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({required this.url, required this.parse});
}

// constant field values for FlutterSecureStorage objects
class EntryFields {
  static const String name = "entry_name";
  static const String datetime = "entry_datetime";
  static const String duration = "entry_duration";
  static const String activity = "entry_activity";
  static const String entryName = "entry_name";
  static const String category = "entry_category";
  static const String type = "entry_type";
  static const String beforeEffects = "entry_before_effects";
  static const String afterEffects = "entry_after_effects";
  static const String symptoms = "entry_symptoms";
  static const String checkUps = "check_ups";
  static const String additionalInfo = "additional_info";
}

class EntryManager {
  // create EntryModel object from secure storage object
  static buildModel(FlutterSecureStorage storage) async {
    final checkUpsString = await storage.read(key: EntryFields.checkUps);
    final checkUpsMap;
    Map<String, bool> checkUps;
    try {
      final checkUpsMap = jsonDecode(checkUpsString!) as Map<String, dynamic>;
      checkUps = Map<String, bool>.fromEntries(checkUpsMap.entries.map((entry) => MapEntry(entry.key, entry.value as bool)));
    } catch (e) {
      // Handle the error here, e.g. print an error message or set checkUps to an empty map.
      print('Error parsing checkUps string: $e');
      checkUps = {};
    }
    EntriesModel entry = EntriesModel(
      title: await storage.read(key: EntryFields.name) ?? "Entry",
      dateTime: DateTime.parse(await storage.read(key: EntryFields.datetime) ??
          DateTime.now().toString()),
      duration: await storage.read(key: EntryFields.duration) ?? "0",
      activities: await storage.read(key: EntryFields.activity) ?? "",
      category: await storage.read(key: EntryFields.category) ?? "N/A",
      type: await storage.read(key: EntryFields.type) ?? "N/A",
      beforeEffects:
          await storage.read(key: EntryFields.beforeEffects) ?? "N/A",
      afterEffects: await storage.read(key: EntryFields.afterEffects) ?? "N/A",
      symptoms: await storage.read(key: EntryFields.symptoms) ?? "N/A",
      checkUps: checkUps,
      additionalInfo: await storage.read(key: EntryFields.additionalInfo) ?? "N/A",
      videoPath: "NA",
    );
    return entry;
  }

  static const String url = "http://localhost:8080/entries";
  Future<List<UserEntryModel>> load<T>(
      Resource<List<UserEntryModel>> resource) async {
    final response = await http.get(Uri.parse(resource.url));
    print(response);
    if (response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  getAll() async {
    final response = await http.get(Uri.parse(url + "/all"));
    print(response);
    if (response.statusCode == 200) {
      return UserEntryModel.getAll(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static update(EntriesModel entry, userId) async {
    UserEntryModel requestObject =
        new UserEntryModel(userId: userId, entry: entry);
    String requestString = jsonEncode(requestObject);
    Map<String, String> customHeaders = {"content-type": "application/json"};
    print(requestString);
    final response = await http.put(Uri.parse(url),
        headers: customHeaders, body: requestString);
    print(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static post(EntriesModel entry) async {
    String requestString = jsonEncode(entry);
    Map<String, String> customHeaders = {"content-type": "application/json"};
    print(requestString);
    final response = await http.post(Uri.parse(url + "/create"),
        headers: customHeaders, body: requestString);
    print(response);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to post data!');
    }
  }
}
