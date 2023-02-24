import 'package:client/model/entries.dart';
import 'package:client/pages/entryEdit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/entryEdit', arguments: {
                "userId": this.userId, 
                "entry": this.entry
              }).then((updatedEntry) {
                if (updatedEntry != null) {
                      setState(() {
                        entry =  updatedEntry as EntriesModel;
                      });
                }
                  });
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              'Seizure Information',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 3 / 1,
              children: <Widget>[
                _gridChildrenContainerKey("Time:"),
                _gridChildrenContainerValue(DateFormat.yMMMMd().format(entry.dateTime)),
                _gridChildrenContainerKey("Duration:"),
                _gridChildrenContainerValue(entry.duration),
                _gridChildrenContainerKey("Activities:"),
                _gridChildrenContainerValue(entry.activities),
                _gridChildrenContainerKey("Category:"),
                _gridChildrenContainerValue(entry.category),
                _gridChildrenContainerKey("Type:"),
                _gridChildrenContainerValue(entry.type),
                _gridChildrenContainerKey("Before Effect:"),
                _gridChildrenContainerValue(entry.beforeEffects),
                _gridChildrenContainerKey("After Effect:"),
                _gridChildrenContainerValue(entry.afterEffects),
                _gridChildrenContainerKey("Symptoms:"),
                _gridChildrenContainerValue(entry.symptoms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _gridChildrenContainerKey(String text) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Container _gridChildrenContainerValue(String text) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

// import 'package:client/model/entries.dart';
// import 'package:client/pages/entryEdit.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class entryDetail extends StatelessWidget {
//   final String userId;
//   final EntriesModel entry;

//   const entryDetail({required this.userId, required this.entry});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(entry.title),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               Navigator.pushNamed(context, '/entryEdit', arguments: {
//                 "userId": this.userId, 
//                 "entry": this.entry
//               }).then((_) {
//                       setState(() {
//                         this.entry = entry;
//                       });
//                   });
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             margin: const EdgeInsets.all(20),
//             child: const Text(
//               'Seizure Information',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 25.0,
//               ),
//             ),
//           ),
//           Expanded(
//             child: GridView.count(
//               crossAxisCount: 2,
//               childAspectRatio: 3 / 1,
//               children: <Widget>[
//                 _gridChildrenContainerKey("Time:"),
//                 _gridChildrenContainerValue(DateFormat.yMMMMd().format(entry.dateTime)),
//                 _gridChildrenContainerKey("Duration:"),
//                 _gridChildrenContainerValue(entry.duration),
//                 _gridChildrenContainerKey("Activities:"),
//                 _gridChildrenContainerValue(entry.activities),
//                 _gridChildrenContainerKey("Category:"),
//                 _gridChildrenContainerValue(entry.category),
//                 _gridChildrenContainerKey("Type:"),
//                 _gridChildrenContainerValue(entry.type),
//                 _gridChildrenContainerKey("Before Effect:"),
//                 _gridChildrenContainerValue(entry.beforeEffects),
//                 _gridChildrenContainerKey("After Effect:"),
//                 _gridChildrenContainerValue(entry.afterEffects),
//                 _gridChildrenContainerKey("Symptoms:"),
//                 _gridChildrenContainerValue(entry.symptoms),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Container _gridChildrenContainerKey(String text) {
//     return Container(
//       padding: const EdgeInsets.all(10.0),
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontSize: 15,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }

//   Container _gridChildrenContainerValue(String text) {
//     return Container(
//       padding: const EdgeInsets.all(10.0),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 15),
//       ),
//     );
//   }
// }

// import 'package:client/model/entries.dart';
// import 'package:client/pages/entryEdit.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class entryDetail extends StatelessWidget {
//   final EntriesModel entry;
//   final String userId;

//   const entryDetail({required this.entry, required this.userId});

//   Widget _buildText(String label, String value, BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: Theme.of(context).textTheme.headline5,
//           ),
//           Text(
//             value,
//             style: Theme.of(context).textTheme.bodyText1,
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Entry Detail'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               Navigator.pushNamed(context, '/entryEdit', arguments: {
//                       "userId": this.userId, 
//                       "entry": this.entry
//                   }).then((_) {
//                       // setState(() {
//                       //   this.entry = entry;
//                       // });
//                       // TODO
//                   });
//               },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Entry Title
//             _buildText('Entry Title', entry.title, context),

//             // Date and Time
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildText(
//                       'Date',
//                       DateFormat.yMMMMd().format(entry.dateTime),
//                     context),
//                   ),
//                   Expanded(
//                     child: _buildText(
//                       'Time',
//                       DateFormat.jm().format(entry.dateTime),
//                     context),
//                   ),
//                 ],
//               ),
//             ),

//             // Seizure Information
//             _buildText('Seizure Information', '', context),

//             // Duration
//             _buildText('Duration', entry.duration, context),

//             // Activities
//             _buildText('Activities', entry.activities, context),

//             // Category
//             _buildText('Category', entry.category, context),

//             // Type
//             _buildText('Type', entry.type, context),

//             // Before Effects
//             _buildText('Before Effects', entry.beforeEffects, context),

//             // After Effects
//             _buildText('After Effects', entry.afterEffects, context),

//             // Symptoms
//             _buildText('Symptoms', entry.symptoms, context),
//           ],
//         ),
//       ),
//     );
//   }
// }