import 'package:client/widgets/profile/MedicalInfo/medical_info_page.dart';
import 'package:client/widgets/profile/MedicalInfo/medications_controller.dart';
import 'package:flutter/material.dart';

class MedicalInfoForm extends StatefulWidget {
  final Function() onSubmit;
  const MedicalInfoForm({super.key, required this.onSubmit});

  @override
  State<MedicalInfoForm> createState() => _MedicalInfoFormState();
}

class _MedicalInfoFormState extends State<MedicalInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? name;
    String? administrationMethod;
    String? dosage;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            onSaved: (String? value) {
              name = value!;
            },
            decoration: const InputDecoration(
              hintText: 'Enter new name',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            onSaved: (String? value) {
              administrationMethod = value!;
            },
            decoration: const InputDecoration(
              hintText: 'Enter new administration method',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            onSaved: (String? value) {
              dosage = value!;
            },
            decoration: const InputDecoration(
              hintText: 'Enter new dosage',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    if (_formKey.currentState!.validate()) {
                      // Process data.
                      _formKey.currentState!.save();

                      if (medicationId!.isEmpty) {
                        await addMedication(
                            name!, administrationMethod!, dosage!);
                        widget.onSubmit();
                      }

                      if (medicationId!.isNotEmpty) {
                        await editMedication(name!, administrationMethod!,
                            dosage!, medicationId!);
                        widget.onSubmit();
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (medicationId!.isNotEmpty) {
                      await deleteMedication(medicationId!);
                      medicationId = null;
                      widget.onSubmit();
                    }
                  },
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
