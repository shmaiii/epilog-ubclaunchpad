import 'package:client/model/entries.dart';
import 'package:client/pages/entryEdit.dart';
import 'package:flutter/material.dart';

class entryDetail extends StatefulWidget {
  String userId;
  EntriesModel entry;

  entryDetail({required this.userId, required this.entry});
  _editState createState() => _editState(userId: userId, entry: entry);
}

class _editState extends State<entryDetail> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String userId;
  EntriesModel entry;
  _editState({required this.userId, required this.entry});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("-----------------I am built in the entry detail page");
    print (entry);
    return Scaffold(
      appBar: AppBar(
          title: Text(entry.title),
          actions: [
            editButton(context)
          ],
        ),
        body: (
          mainColumn(context)
        )
    );
  }

  Column mainColumn(BuildContext context) {
    return Column( 
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(20),
                child: const Text(
                  'Seizure Information',
                  textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),                        
                  ),
              ),
              Expanded
              (
                child: gridViewContent(),
              ),
            ],
        );
  }

  TextButton editButton(BuildContext context) {
    return TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () { 
                Navigator.pushNamed(context, '/entryEdit', arguments: {
                      "userId": this.userId, 
                      "entry": this.entry
                  }).then((_) {
                      setState(() {
                        this.entry = entry;
                      });
                  });
              },

              child: Text('Edit'),
            );
  }

  GridView gridViewContent() {
    final double itemWidth = 9;
    final double itemHeight = itemWidth / 3;
    return GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                childAspectRatio: (itemWidth / itemHeight),
                children: <Widget>[
                  gridChildrenContainerKey("Duration: "),
                  gridChildrenContainerValue("${entry.duration} minutes"),               
                  gridChildrenContainerKey("Activities"),
                  gridChildrenContainerValue("..."),
                  gridChildrenContainerKey("Category: "),
                  gridChildrenContainerValue(entry.category),
                  gridChildrenContainerKey("Type"),
                  gridChildrenContainerValue("..."),
                  gridChildrenContainerKey("Before Effect: "),
                  gridChildrenContainerValue("..."),
                  gridChildrenContainerKey("After Effect: "),
                  gridChildrenContainerValue("..."),
                  gridChildrenContainerKey("Symptoms: "),
                  gridChildrenContainerValue(entry.symptoms),
                  gridChildrenContainerKey("Check ups: "),
                  gridChildrenContainerValue("..."),
                ]          
              );
  }

  Container gridChildrenContainerKey(text) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Text(text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
    );
  }

  Container gridChildrenContainerValue(text) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Text(text,
          style: const TextStyle(fontSize: 15)),
    );
  }
}
          
