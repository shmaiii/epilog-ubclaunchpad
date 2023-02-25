import 'package:client/widgets/profile/ContactInfo/contact_info_page.dart';
import 'package:client/widgets/profile/ContactInfo/contacts_controller.dart';
import 'package:flutter/material.dart';

class ContactInfoForm extends StatefulWidget {
  final Function() onSubmit;
  const ContactInfoForm({super.key, required this.onSubmit});

  @override
  State<ContactInfoForm> createState() => _ContactInfoFormState();
}

class _ContactInfoFormState extends State<ContactInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String? name;
    String? phoneNumber;
    String? type;
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
              phoneNumber = value!;
            },
            decoration: const InputDecoration(
              hintText: 'Enter new phone number',
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
              type = value!;
            },
            decoration: const InputDecoration(
              hintText: 'Enter new type',
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

                      if (contactId!.isEmpty) {
                        await addContact(
                            name!, phoneNumber!, type!);
                        widget.onSubmit();
                      }

                      if (contactId!.isNotEmpty) {
                        await editContact(name!, phoneNumber!,
                            type!, contactId!);
                        widget.onSubmit();
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (contactId!.isNotEmpty) {
                      await deleteContact(contactId!);
                      contactId = null;
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
