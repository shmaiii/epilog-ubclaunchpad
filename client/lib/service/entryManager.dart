import 'package:client/model/entries.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Resource<T> {
  final String url;
  T Function (Response response) parse;

  Resource ({required this.url,required this.parse});
}

class EntryManager {
  Future<List<EntriesModel>> load<T>(Resource<List<EntriesModel>> resource) async {
      print("connection url: ");
      print(Uri.parse(resource.url));
      final response = await http.get(Uri.parse(resource.url));
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        throw Exception('Failed to load data!');
      }
  }
}

//   final resultNotifier = ValueNotifier<RequestState>(RequestInitial());
//   static const urlPrefix = 'https://jsonplaceholder.typicode.com';

//   Future<void> makeGetRequest() async {
//     resultNotifier.value = RequestLoadInProgress();
//     final url = Uri.parse('$urlPrefix/posts');
//     Response response = await get(url);
//     print('Status code: ${response.statusCode}');
//     print('Headers: ${response.headers}');
//     print('Body: ${response.body}');
//     _handleResponse(response);
//   }

//   void _handleResponse(Response response) {
//     if (response.statusCode >= 400) {
//       resultNotifier.value = RequestLoadFailure();
//     } else {
//       resultNotifier.value = RequestLoadSuccess(response.body);
//     }
//   }
// }
//   class RequestState {
//   const RequestState();
// }

// class RequestInitial extends RequestState {}

// class RequestLoadInProgress extends RequestState {}

// class RequestLoadSuccess extends RequestState {
//   const RequestLoadSuccess(this.body);
//   final String body;
// }

// class RequestLoadFailure extends RequestState {}
