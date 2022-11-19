import 'dart:convert';

import 'package:client/service/entryManager.dart';

class EntriesModel {
  String title;

  EntriesModel({required this.title});

  factory EntriesModel.fromJson(Map<String, dynamic> json) {
    return EntriesModel(title: json['title']);
  }
  //url: 'https://jsonplaceholder.typicode.com/todos',
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