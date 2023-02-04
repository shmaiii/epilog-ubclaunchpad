import 'package:client/widgets/profile/ContactInfo/contact_info_page.dart';
import 'package:client/widgets/profile/MedicalInfo/medical_info_page.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'ProfileSettingsPage.dart';
import 'setting.dart';
import 'package:http/http.dart' as http;

import 'FetchProfile.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class MultipleButton extends StatelessWidget {
  const MultipleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      title: 'Navigation Basics',
      home: Scaffold(
        body: Center(
          child: Container(
            height: 600.0,
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //Text("data"),
                  // top container
                  Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Image.asset('./assets/profile.png',
                            scale: 5.1, alignment: Alignment.topLeft),
                        Column(
                          // verticalDirection: VerticalDirection.down,
                          children: const [
                            Text(
                              'Hello Julia',
                              style: TextStyle(fontSize: 50.0),
                            ), //
                            Text(
                              'small bio',
                              style: TextStyle(fontSize: 20.0),
                            ), //
                          ],
                        )
                      ])),
                  // Container(
                  //   child: Image.asset('./assets/profile.png'),
                  // ),
                  // Expanded(
                  //   child: Image.asset('./assets/profile.png'),
                  // ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingPage()));
                      },
                      child: const Text("User Settings"),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ContactInfoPage()));
                      },
                      child: const Text("Emergency Contact"),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MedicalInfoPage()));
                      },
                      child: const Text("User Medical Information"),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileSettingsPage()));
                      },
                      child: 
                      Column(children: [
                          FutureBuilder<ProfileInfo>(
                            future: fetchProfile(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data!.full_name);
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<ProfileInfo>(
                            future: fetchProfile(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data!.age.toString());
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<ProfileInfo>(
                            future: fetchProfile(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data!.address.toString());
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                      ],)
                      
                      
                    
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  //const SecondRoute({super.key});
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(4, 9, 35, 1),
                Color.fromRGBO(39, 105, 171, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 73),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Go back!'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'My\nProfile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'Nisebuschgardens',
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    height: height * 0.43,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double innerHeight = constraints.maxHeight;
                        double innerWidth = constraints.maxWidth;
                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: innerHeight * 0.72,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 80,
                                    ),
                                    const Text(
                                      'Simon',
                                      style: TextStyle(
                                        color: Color.fromRGBO(39, 105, 171, 1),
                                        fontFamily: 'Nunito',
                                        fontSize: 37,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'YYY',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            const Text(
                                              '10',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 25,
                                            vertical: 8,
                                          ),
                                          child: Container(
                                            height: 50,
                                            width: 3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'TTT',
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                            const Text(
                                              '1',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    39, 105, 171, 1),
                                                fontFamily: 'Nunito',
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                    // child: Image.asset(
                                    //   'profile.png',
                                    //   width: innerWidth * 0.45,
                                    //   fit: BoxFit.fitWidth,
                                    // ),
                                    ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: height * 0.5,
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Selection',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          const Divider(
                            thickness: 2.5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ElevatedButton(
                                child: const Text("emergency contact"),
                                onPressed: () {
                                  print('You pressed the button.');
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: height * 0.15,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
