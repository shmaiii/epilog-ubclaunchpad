import 'dart:convert';

import 'package:client/service/entryManager.dart';

class EntriesModel {
  String title;

  EntriesModel({required this.title});

  factory EntriesModel.fromJson(Map<String, dynamic> json) {
    return EntriesModel(title: json['title']);
  }

  static Resource<List<EntriesModel>> get all {
    return Resource(
        url: 'https://jsonplaceholder.typicode.com/todos',
        parse: (response) {
          final result = json.decode(response.body);
          print(result);
          Iterable list = result;
          return list.map((model) => EntriesModel.fromJson(model)).toList();
        }
      );
  }
}