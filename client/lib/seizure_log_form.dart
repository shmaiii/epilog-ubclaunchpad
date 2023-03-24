import 'package:client/EntryFormPages/CategoryType.dart';
import 'package:client/EntryFormPages/additional_info.dart';
import 'package:client/EntryFormPages/check_up.dart';
import 'package:client/EntryFormPages/Symptoms.dart';
import 'package:client/service/entryManager.dart';
import 'package:flutter/material.dart';
import 'EntryFormPages/NewEntry.dart';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:client/model/entries.dart';

class SeizureLogPage extends StatelessWidget {
  const SeizureLogPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Scaffold(
          body: SeizureLogForm(),
        ),
      ),
    );
  }
}

class SeizureLogForm extends StatefulWidget {
  const SeizureLogForm({super.key});

  @override
  State<SeizureLogForm> createState() => _SeizureLogFormState();
}

List<GlobalKey<FormState>> formKeys =
    List<GlobalKey<FormState>>.generate(pageTitles.length, (i) {
  return GlobalKey();
});

List<Widget> formPages = [
  NewEntry(formKey: formKeys[0], storage: storage),
  CategoryType(formKey: formKeys[1], storage: storage),
  Symptoms(formKey: formKeys[2], storage: storage),
  Checkup(formKey: formKeys[3], storage: storage),
  AdditionalInfo(formKey: formKeys[4], storage: storage)
];

List<String> pageTitles = [
  "New Seizure Log",
  "Category and Type",
  "Symptoms",
  "Check-up",
  "Additional Information"
];

const storage = FlutterSecureStorage();

class _SeizureLogFormState extends State<SeizureLogForm> {
  int formPageInd = 0;

  _exitForm(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    // clear all stored form values
    storage.deleteAll();
  }

  _showExitDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Entry Form?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to exit?'),
                Text('Form data will be lost.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('EXIT'),
              onPressed: () {
                // exit alert dialog and form page
                _exitForm(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showSuccessDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Entry Added!'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                // exit alert dialog and form page
                _exitForm(context);
              },
            ),
          ],
        );
      },
    );
  }

  _showErrorDialog() async {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Something went wrong.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                // exit alert dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Column(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        const SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 0, 17, 0),
              child: CircleAvatar(
                radius: 21,
                backgroundColor: const Color(0xFF571F83),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => {
                    if (formPageInd > 0)
                      {
                        setState(() {
                          formPageInd = max(formPageInd - 1, 0);
                        })
                      }
                    else
                      {_showExitDialog()}
                  },
                ),
              ),
            ),
            Text(
              pageTitles[formPageInd],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            )
          ],
        )
      ]),
      formPages[formPageInd],
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Row(children: [
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (formKeys[formPageInd].currentState!.validate()) {
                    if (formPageInd < formPages.length - 1) {
                      setState(() {
                        formPageInd =
                            min(formPageInd + 1, formPages.length - 1);
                      });
                    } else {
                      try {
                        // attempt submit
                        EntriesModel entry =
                            await EntryManager.buildModel(storage);
                        await EntryManager.post(entry);
                        _showSuccessDialog();
                      } catch (e) {
                        debugPrint("Failed to post");
                        _showErrorDialog();
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                    (formPageInd < formPages.length - 1) ? 'Next >' : 'Submit',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ]),
        ),
      ),
    ]));
  }
}
