import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MultipleButton extends StatelessWidget {
  const MultipleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            height: 600.0,
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // top container
                  new Expanded(
                    child: new Text(
                      'Hello Julia',
                      style: new TextStyle(fontSize: 50.0),
                    ), // todo, add the two texts,
                  ),
                  new Expanded(
                    child: Image.asset('./assets/profile.png'),
                  ),
                  buttonWidget("User Settings", context, "/first"),
                  buttonWidget("User Medical Info", context, "/second"),
                  buttonWidget("User Profile", context, "/third"),
                  //buttonWidget("User Medical Info", context, "/fourth"),
                ]),
          ),
        ),
      ),
    );
  }

  Widget buttonWidget(String label, BuildContext context, String pathName) {
    return ButtonTheme(
      minWidth: 200.0,
      height: 80.0,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, pathName);
        },
        child: Text(label),
      ),
    );
  }

  Widget largeButtonWidget(
      String label, BuildContext context, String pathName) {
    return ButtonTheme(
        minWidth: 200.0,
        height: 80.0,
        child: GFButton(
          onPressed: () {
            Navigator.pushNamed(context, pathName);
          },
          text: "secondary",
          shape: GFButtonShape.pills,
        ));
  }
}
