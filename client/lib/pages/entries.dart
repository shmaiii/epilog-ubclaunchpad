import 'package:client/model/userEntryModel.dart';
import 'package:client/pages/entryDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/entries.dart';
import '../service/entryManager.dart';

class Entries extends StatefulWidget {

  @override
  createState() => EntriesState();
}

class EntriesState extends State<Entries> {
  List<UserEntryModel> _entryModels = <UserEntryModel>[];

  @override
  void initState() {
    super.initState();
    _populateEntries();
  }

  void _populateEntries() {
    EntryManager().getAll().then((entryModels) => {
      setState(() => {
        _entryModels = entryModels
      })
    });
  }

  Padding _buildItemsForListView(BuildContext context, int index) {
      return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                      Navigator.pushNamed(context, '/entry', arguments: {
                          "userId": _entryModels[index].userId, 
                          "entry": _entryModels[index].entry
                      }).then((_) => _populateEntries());
                  },
                  title: Text(_entryModels[index].entry.title),
                ),
              )
              );
  }

  @override
  Widget build(BuildContext context) {
    print("The entries page is built with the following information");
    _entryModels.forEach((entry) => print(entry.entry.title));
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