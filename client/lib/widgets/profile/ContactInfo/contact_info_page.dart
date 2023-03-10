import 'package:client/widgets/profile/ContactInfo/contacts_controller.dart';
import 'package:flutter/material.dart';

import 'contact_info_form.dart';

class ContactInfoPage extends StatefulWidget {
  const ContactInfoPage({super.key});
  @override
  State<ContactInfoPage> createState() => _ContactInfoPageState();
}

String? contactId;

class _ContactInfoPageState extends State<ContactInfoPage> {
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
            contactId = null;
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
                "Contacts",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 35,
              ),
              FutureBuilder<List<Contact>>(
                future: readContacts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Widget> contactsWidgets = [];
                    for (Contact c in snapshot.data!) {
                      contactsWidgets.add(TextButton(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Name: ${c.name}'),
                              Text(
                                  'Phone Number: ${c.phoneNumber}'),
                              Text('Type: ${c.type}'),
                            ],
                          ),
                        ),
                        onPressed: () {
                          setState((() {
                            contactId = c.id;
                          }));
                        },
                      ));
                    }
                    contactsWidgets.add(TextButton(
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Add new contact'),
                      ),
                      onPressed: () {
                        setState((() {
                          contactId = "";
                        }));
                      },
                    ));
                    return SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: contactsWidgets,
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
              if (contactId != null) ContactInfoForm(
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
