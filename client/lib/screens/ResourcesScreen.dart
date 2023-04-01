import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesScreen extends StatefulWidget {
  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildBackButton() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: IconButton(
        alignment: Alignment.topLeft,
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_circle_left,
          size: 40,
          color: Color.fromARGB(231, 115, 4, 140),
        ),
      ),
    );
  }

  Widget buildResources() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Epilepsy Resources',
          style: TextStyle(
              color: Colors.black87, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 60),
        ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Epilepsy   '), Text('Canada')]),
              IconButton(
                onPressed: () {
                  Uri url1 = Uri.parse('https://www.epilepsy.ca/');
                  launchUrl(url1);
                },
                icon: Image.asset('lib/ResourceImages/epilepsycanada.png'),
                iconSize: 150,
              )
            ],
          ),
          onPressed: () {
            Uri url1 = Uri.parse('https://www.epilepsy.ca/');
            launchUrl(url1);
          },
          style: ElevatedButton.styleFrom(
              fixedSize: Size(310, 100),
              backgroundColor: Color.fromARGB(255, 248, 216, 255),
              foregroundColor: Colors.black87,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text('Epilepsy'), Text('Foundation')]),
              IconButton(
                onPressed: () {
                  Uri url2 = Uri.parse('https://www.epilepsy.com/');
                  launchUrl(url2);
                },
                icon: Image.asset('lib/ResourceImages/epilepsyfoundation.png'),
                iconSize: 150,
              )
            ],
          ),
          onPressed: () {
            Uri url2 = Uri.parse('https://www.epilepsy.com/');
            launchUrl(url2);
          },
          style: ElevatedButton.styleFrom(
              fixedSize: Size(310, 100),
              backgroundColor: Color.fromARGB(255, 216, 240, 255),
              foregroundColor: Colors.black87,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildBackButton(),
                      SizedBox(height: 40),
                      buildResources(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
