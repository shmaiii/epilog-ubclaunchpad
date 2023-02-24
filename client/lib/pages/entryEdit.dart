// import 'dart:collection';

// import 'package:client/service/entryManager.dart';
// import 'package:flutter/material.dart';

// import '../model/entries.dart';

// class entryEdit extends StatelessWidget {
//   String userId;
//   EntriesModel entry;
//   entryEdit({required this.userId, required this.entry});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Scaffold(
//           appBar: AppBar(),
//           body: EntryEditForm(entry: entry, userId: userId),
//         ),
//       ),
//     );
//   }
// }

// class EntryEditForm extends StatefulWidget {
//   EntriesModel entry;
//   String userId;
//   EntryEditForm({super.key, required this.entry, required this.userId});
//   @override
//   State<EntryEditForm> createState() => _EntryEditFormState(entry: entry, userId: userId);
// }

// class _EntryEditFormState extends State<EntryEditForm> {
//   EntriesModel entry;
//   String userId;
//   Map<String, String> updatedValues = new Map();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   _EntryEditFormState({required this.entry, required this.userId});

  
//   @override
//   Widget build(BuildContext context) {
//     var seizureKeyList = ["Title", "Duration", "Category", "Symptoms"];
//     var seizureValueList = [entry.title,"${entry.duration} minutes", entry.category, entry.symptoms];
//     return Form(
//         key: _formKey,
//         child: Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
//             child: SingleChildScrollView(
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     const Text(
//                       'Seizure Information',
//                       textAlign: TextAlign.center,
//                       overflow: TextOverflow.ellipsis,
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
//                     ),
//                     _FormTextInput(entry: entry, updatedValues: updatedValues),
//                     Stack(
//                         alignment: Alignment.bottomRight,
//                         clipBehavior: Clip.none,
//                         children: [
//                           //todo: adding a message the info got updated correctly
//                           ElevatedButton(
//                             onPressed: () {
//                                 // Validate will return true if the form is valid, or false if
//                                 // the form is invalid.
//                                 if (_formKey.currentState!.validate()) {
//                                   // Process data.
//                                 }
//                                 for (MapEntry<String, String> element in updatedValues.entries) {
//                                   switch (element.key) {
//                                     case "Title":
//                                       entry.title = element.value;
//                                       break;
//                                     case "Duration":
//                                       entry.duration = int.parse(element.value);
//                                       break;
//                                     case "Category":
//                                       entry.category = element.value;
//                                       break;
//                                     case "Symptom":
//                                       entry.symptoms = element.value;
//                                       break;
//                                   }
//                                 }
//                                 EntryManager.update(entry, userId);
//                             },
//                             child: const Text('Submit'),
//                           ),
//                         ])
//                   ])
//               )
//             )
//         );
//   }
// }

// @immutable
// class _FormTextInput extends StatelessWidget {

//   _FormTextInput({
//     required this.entry,
//     required this.updatedValues
//   });
//   EntriesModel entry;
//   Map<String, String> updatedValues;
//   final double itemWidth = 9;
//   final double itemHeight = 3;
  

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.only(top: 30),
//         child: 
//         //Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               GridView.count(
//                 crossAxisCount: 2,
//                 childAspectRatio: (itemWidth / itemHeight),
//                 shrinkWrap: true,
//                 children: [
//                   gridKey("Title"),
//                   gridValue(entry.title, entry, "Title"),
//                   gridKey("Duration"),
//                   gridValue("${entry.duration} minutes", entry, "Duration"),
//                   gridKey("Category"),
//                   gridValue(entry.category, entry, "Category"),
//                   gridKey("Symptoms"),
//                   gridValue(entry.symptoms, entry, "Symptoms"),        
//                 ]
//               )
//             );
//   }

//   Text gridKey(key) {
//     return Text(
//               key,
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
//             );
//   }

//   TextFormField gridValue(value, EntriesModel entry, key) {
//     return TextFormField(
//               decoration: InputDecoration(
//                   hintText: value,
//                   enabledBorder: const UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black, width: 4.0)),
//                   focusedBorder: const UnderlineInputBorder(
//                       borderSide: BorderSide(color: Colors.black, width: 4.0))),
//               onChanged:(value) => {
//                 if (key == "Title")
//                   updatedValues["Title"] = value
//                 else if (key == "Category")
//                   entry.category = value
//                 else if (key == "Duration")
//                   entry.duration = int.parse(value)
//                 else if (key == "Symptoms")
//                   entry.symptoms = value
//               },
//             );
//   }
// }

import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:client/service/entryManager.dart';
import 'package:flutter/material.dart';

import '../model/entries.dart';


class entryEdit extends StatefulWidget {
  EntriesModel entry;
  String userId;

  // const EntryEditPage({this.entry});
  entryEdit({required this.userId, required this.entry});

  @override
  _EntryEditPageState createState() => _EntryEditPageState();
}

class _EntryEditPageState extends State<entryEdit> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _durationController = TextEditingController();
  final _activitiesController = TextEditingController();
  final _categoryController = TextEditingController();
  final _typeController = TextEditingController();
  final _beforeEffectsController = TextEditingController();
  final _afterEffectsController = TextEditingController();
  final _symptomsController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late final String userId;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.entry.title;
    _durationController.text = widget.entry.duration;
    _activitiesController.text = widget.entry.activities;
    _categoryController.text = widget.entry.category;
    _typeController.text = widget.entry.type;
    _beforeEffectsController.text = widget.entry.beforeEffects;
    _afterEffectsController.text = widget.entry.afterEffects;
    _symptomsController.text = widget.entry.afterEffects;
    _selectedDate = widget.entry.dateTime;
    _selectedTime = TimeOfDay.fromDateTime(widget.entry.dateTime);
    userId = widget.userId;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Widget _buildTextFormField(
      TextEditingController controller, String labelText, String errorText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return errorText;
          }
          return null;
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Entry'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Entry Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entry Title',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    _buildTextFormField(
                      _titleController,
                      'Title',
                      'Please enter a title',
                    ),
                  ],
                ),
              ),


              // Date and Time
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTextFormField(
                        TextEditingController(
                          text: _selectedDate.toString().substring(0, 10),
                        ),
                        'Date',
                        'Please select a date',
                      ),
                    ),
                    IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(Icons.calendar_today),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildTextFormField(
                        TextEditingController(
                          text: _selectedTime.format(context),
                        ),
                        'Time',
                        'Please select a time',
                      ),
                    ),
                    IconButton(
                      onPressed: () => _selectTime(context),
                      icon: Icon(Icons.access_time),
                    ),
                  ],
                ),
              ),

              // Seizure Information
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Seizure Information',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),

              // Duration
              _buildTextFormField(
                _durationController,
                'Duration',
                'Please enter a duration',
              ),

              // Activities
              _buildTextFormField(
                _activitiesController,
                'Activities',
                'Please enter activities',
              ),

              // Category
              _buildTextFormField(
                _categoryController,
                'Category',
                'Please enter a category',
              ),

              // Type
              _buildTextFormField(
                _typeController,
                'Type',
                'Please enter a type',
              ),

              // Before Effects
              _buildTextFormField(
                _beforeEffectsController,
                'Before Effects',
                'Please enter before effects',
              ),

              // After Effects
              _buildTextFormField(
                _afterEffectsController,
                'After Effects',
                'Please enter after effects',
              ),

              _buildTextFormField(_symptomsController, 'Symptoms', 'Please enter your symptoms'),

              // Save Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save the entry
                        final newEntry = EntriesModel(
                          title: _titleController.text,
                          dateTime: DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            _selectedDate.day,
                            _selectedTime.hour,
                            _selectedTime.minute,
                          ),
                          duration: _durationController.text,
                          activities: _activitiesController.text,
                          category: _categoryController.text,
                          type: _typeController.text,
                          beforeEffects: _beforeEffectsController.text,
                          afterEffects: _afterEffectsController.text, 
                          symptoms: _symptomsController.text,
                        );

                        EntryManager.update(newEntry, userId);

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Entry saved successfully!'),
                          ),
                        );

                        // Navigate back to the previous screen
                        Navigator.of(context).pop(newEntry);
                      }
                    },
                    child: Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

