//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/entries.dart';
import '../model/entries.dart';
import '../service/entryManager.dart';

class Entries extends StatefulWidget {

  @override
  createState() => EntriesState();
}

class EntriesState extends State<Entries> {
  // ignore: deprecated_member_use, prefer_collection_literals
  List<EntriesModel> _entryModels = <EntriesModel>[];

  @override
  void initState() {
    super.initState();
    _populateEntries();
  }

  void _populateEntries() {
    EntryManager().load(EntriesModel.all).then((entryModels) => {
      setState(() => {
        _entryModels = entryModels
      })
    });
  }

  Padding _buildItemsForListView(BuildContext context, int index) {
      // return ListTile(
      //   title: Text(_entryModels[index].title), 
      // );
      return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                  },
                  title: Text(_entryModels[index].title),
                ),
              )
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Entries'),
        ),
        body: ListView.builder(
          itemCount: _entryModels.length,
          itemBuilder: _buildItemsForListView,
        )
      );
  }

}


// class Entries extends StatefulWidget {
//   @override
//   _EntriesState createState() => _EntriesState();
// }

// class Entries extends StatelessWidget {
//   final stateManager = EntryManager();
//   List<EntriesModel> entries = [
//     EntriesModel(title: "a"),
//     EntriesModel(title: "b"),
//   ];

//   // @override
//   // void initState() {
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           backgroundColor: Colors.blue[900],
//           title: const Text('Welcome to Entries'),
//         ),
//         body: ListView.builder(
//           itemCount: entries.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
//               child: Card(
//                 child: ListTile(
//                   onTap: () {
//                     stateManager.makeGetRequest();
//                   },
//                   title: Text(entries[index].title),
//                 ),
//               )
//               );
//           })
//     );
//   }
// }