import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings Page", style: TextStyle(fontSize: 22)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.lightBlue,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            const SizedBox(
              height: 10,
            ),
            buildAccountOption(context, "Change Password"),
            buildAccountOption(context, "Push Notification"),
            buildAccountOption(context, "Update Bio"),
            buildAccountOption(context, "Theme Change"),
            Divider(
              height: 20,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title) {
    return GestureDetector(
        onTap: () {
          // showDialog(context : context, builder: (BuildContext)) {
          //   return AlertDialog(
          //     title: Text(title),
          //     content: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [Text("Option 1"), Text("Option 2")],
          //     ),
          //     actions: [
          //       TextButton(
          //           onPressed: () {
          //             Navigator.of(context).pop();
          //           },
          //           child: Text("close"))
          //     ],
          //   );
          // }
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.grey,
                )
              ],
            )));
  }
}
