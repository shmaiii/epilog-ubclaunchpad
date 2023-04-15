import 'package:client/expandable_fab.dart';
import 'package:client/model/userEntryModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../model/entries.dart';
import '../service/entryManager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Entries extends StatefulWidget {
  @override
  _EntriesState createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {
  // List to store the entries
  List<UserEntryModel> _entryModels = <UserEntryModel>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false); // Add RefreshController
  @override
  void initState() {
    super.initState();
    // Fetch the entries from the database
    _populateEntries();
  }

  // Remove didChangeDependencies() method as it's not necessary

  // Method to fetch the entries from the database
  // Method to fetch the entries from the database
  Future<void> _populateEntries() async {
    try {
      List<UserEntryModel> entryModels = await EntryManager().getAll();
      setState(() {
        _entryModels = entryModels;
      });
      _refreshController.refreshCompleted(); // Mark the refresh as completed
    } catch (e) {
      _refreshController
          .refreshFailed(); // Mark the refresh as failed in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with the title
      appBar: AppBar(
        // Add AppBar with a title
        title: Text('Entries'),
      ),
      floatingActionButton: entriesFAB(context),
      // ListView to display the entries wrapped with a RefreshIndicator
      body: SmartRefresher(
        enablePullDown: true, // Enable pull down to refresh
        header: WaterDropHeader(), // Add a header to indicate refreshing
        controller:
            _refreshController, // Use _refreshController to control the refresh state
        onRefresh:
            _populateEntries, // Call _populateEntries when pulled to refresh
        child: ListView.builder(
          itemCount: _entryModels.length,
          itemBuilder: (context, index) {
            // Return a Card for each entry
            return Card(
              child: ListTile(
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
      ),
    );
  }
}
