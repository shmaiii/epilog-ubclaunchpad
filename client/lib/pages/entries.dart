import 'package:client/expandable_fab.dart';
import 'package:client/model/userEntryModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../model/entries.dart';
import '../service/entryManager.dart';

class Entries extends StatefulWidget {
  @override
  _EntriesState createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  //List to store the entries
  List<UserEntryModel> _entryModels = <UserEntryModel>[];

  @override
  void initState() {
    super.initState();
    // Fetch the entries from the database
    _populateEntries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _populateEntries();
  }

  // Method to fetch the entries from the database
  void _populateEntries() {
    EntryManager().getAll().then((entryModels) => {
          // Update the state with the new entries
          setState(() => _entryModels = entryModels),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with the title
      floatingActionButton: entriesFAB(context),
      //ListView to display the entries
      body: ListView.builder(
        itemCount: _entryModels.length,
        itemBuilder: (context, index) {
          // Return a Card for each entry
          return Card(
            child: ListTile(
              //On Tap navigate to the entry detail page and pass the necessary arguments
              onTap: () {
                Navigator.pushNamed(context, '/entry', arguments: {
                  "userId": _entryModels[index].userId,
                  "entry": _entryModels[index].entry
                }).then((_) => _populateEntries());
              },
              title: Text(_entryModels[index].entry.title),
            ),
          );
        },
      ),
    );
  }
}
