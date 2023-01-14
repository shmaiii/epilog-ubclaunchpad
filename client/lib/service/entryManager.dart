import 'package:client/model/entries.dart';
import 'package:client/model/userEntryModel.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class Resource<T> {
  final String url;
  T Function (Response response) parse;

  Resource ({required this.url,required this.parse});
}

class EntryManager {
  static const String url = "http://localhost:8080/entries"; 
  Future<List<UserEntryModel>> load<T>(Resource<List<UserEntryModel>> resource) async {
      final response = await http.get(Uri.parse(resource.url));
      print(response);
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        throw Exception('Failed to load data!');
      }
  }

  getAll() async {
    final response = await http.get(Uri.parse(url + "/all"));
    print(response);
    if(response.statusCode == 200) {
        return UserEntryModel.getAll(response);
    } else {
        throw Exception('Failed to load data!');
    }
  }

  static update(EntriesModel entry, userId) async {
    UserEntryModel requestObject = new UserEntryModel(userId: userId, entry: entry);
    String requestString = jsonEncode(requestObject);
    Map<String, String> customHeaders = {
      "content-type": "application/json"
    };
    print(requestString);
    final response = await http.put(Uri.parse(url), headers: customHeaders, body: requestString);
      print(response);
      if(response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception('Failed to load data!');
      }
  }
}