import 'package:client/EntryFormPages/CategoryType.dart';
import 'package:client/EntryFormPages/Symptoms.dart';
import 'package:client/service/entryManager.dart';
import 'package:flutter/material.dart';
import 'EntryFormPages/NewEntry.dart';
import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
];

List<String> pageTitles = [
  "New Seizure Log",
  "Category and Type",
  "Symptoms",
];

const storage = FlutterSecureStorage();

class _SeizureLogFormState extends State<SeizureLogForm> {
  int formPageInd = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Column(children: [
      const Padding(
        padding: EdgeInsets.only(top: 30, left: 30),
        child: Align(
          alignment: Alignment.topLeft,
          child: BackButton(),
        ),
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(
          pageTitles[formPageInd],
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
        )
      ]),
      formPages[formPageInd],
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Row(children: [
            if (formPageInd > 0)
              Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      formPageInd = max(formPageInd - 1, 0);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('< Back',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (formKeys[formPageInd].currentState!.validate()) {
                    if (formPageInd < formPages.length - 1) {
                      setState(() {
                        formPageInd =
                            min(formPageInd + 1, formPages.length - 1);
                      });
                    } else {
                      // attempt submit
                      EntryManager.buildModel(storage);
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
