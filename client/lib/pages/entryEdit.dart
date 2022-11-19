import 'package:client/model/entries.dart';
import 'package:flutter/material.dart';

class entryEdit extends StatefulWidget {
  EntriesModel entry;
  entryEdit({required this.entry});
  _editState createState() => _editState(entry: entry);
}

class _editState extends State<entryEdit> {
  EntriesModel entry;
  _editState({required this.entry});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(entry.title),
        ),
        body: Form(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  entry.title,
                  textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),                        
                ),
                const Text(
                  'Seizure Information',
                  textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),                        
                ),
                Expanded
                (child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: <Widget>[
                    Text("Duration: "),
                    Text("..."),
                    Text("Activities: "),
                    Text("...: "),
                    Text("Category: "),
                    Text("...: "),
                    Text("Type: "),
                    Text("...: "),
                    Text("Before Effect: "),
                    Text("...: "),
                    Text("After Effect: "),
                    Text("...: "),
                    Text("Symptoms: "),
                    Text("...: "),
                    Text("Check ups: "),
                    Text("...: "),
                  ]          
                ),
                ),
                // Expanded(
                //   child: FittedBox(
                //     child: FlutterLogo(),
                //   ),
                // ),
              ],
          )
          
        )
    ));
  }
}