import 'package:client/widgets/profile/MedicalInfo/medications_api.dart';
import 'package:flutter/material.dart';

import 'medical_info_form.dart';

class MedicalInfoPage extends StatefulWidget {
  const MedicalInfoPage({super.key});
  @override
  State<MedicalInfoPage> createState() => _MedicalInfoPageState();
}

String? medicationId;

class _MedicalInfoPageState extends State<MedicalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            medicationId = null;
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Medications",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 35,
              ),
              FutureBuilder<List<Medication>>(
                future: readMedications(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> medicationsWidgets = [];
                    for (Medication m in snapshot.data!) {
                      medicationsWidgets.add(TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Name: ${m.name}'),
                              Text(
                                  'Administration Method: ${m.administrationMethod}'),
                              Text('Dosage: ${m.dosage}'),
                            ],
                          ),
                        ),
                        onPressed: () {
                          setState((() {
                            medicationId = m.id;
                          }));
                        },
                      ));
                    }
                    medicationsWidgets.add(TextButton(
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Add new medication'),
                      ),
                      onPressed: () {
                        setState((() {
                          medicationId = "";
                        }));
                      },
                    ));
                    return SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: medicationsWidgets,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(
                height: 35,
              ),
              if (medicationId != null) MedicalInfoForm(
                onSubmit: () {
                  setState((() {}));
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
