import 'package:client/duration_picker.dart';
import 'package:client/pages/category.dart';
import 'package:flutter/material.dart';
import 'package:client/FormInputs/FormTextInput.dart';
import 'package:client/date_time_input.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


// class AdditionalInfo extends StatelessWidget {
//   const AdditionalInfo({
//     Key? key,
//     required GlobalKey<FormState> formKey,
//     required this.storage,
//   })  : _formKey = formKey,
//         super(key: key);

//   final GlobalKey<FormState> _formKey;
//   final FlutterSecureStorage storage;

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Form(
//         key: _formKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(height: 15.0),
//               Text(
//                 'Any additional notes?',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               TextFormField(
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Type here...',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ]);
//   }
// }


//  -----


class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.storage,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final FlutterSecureStorage storage;

  @override
  _AdditionalInfoState createState() => _AdditionalInfoState();
}

// class _AdditionalInfoState extends State<AdditionalInfo> {
//   final _textController = TextEditingController();

//   @override
//   void dispose() {
//     _textController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Form(
//         key: widget._formKey,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(height: 15.0),
//               Text(
//                 'Any additional notes?',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               TextFormField(
//                 controller: _textController,
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                   hintText: 'Type here...',
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ]);
//   }

//   String get additionalNotes => _textController.text;
// }


// ----

class _AdditionalInfoState extends State<AdditionalInfo> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadAdditionalNotes();
  }

  void _loadAdditionalNotes() async {
    String? notes = await widget.storage.read(key: 'additional_notes');
    if (notes != null) {
      _textController.text = notes;
    }
  }

  void _saveAdditionalNotes(String notes) async {
    await widget.storage.write(key: 'additional_notes', value: notes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
        key: widget._formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 15.0),
              Text(
                'Any additional notes?',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                controller: _textController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type here...',
                ),
                onChanged: (value) {
                  _saveAdditionalNotes(value);
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  String get additionalNotes => _textController.text;
}
