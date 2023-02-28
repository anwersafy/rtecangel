import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../compoent.dart';
import 'form.dart';

class webPage extends StatefulWidget {
  @override
  _webPageState createState() => _webPageState();
}

class _webPageState extends State<webPage> {

  final Uri adafruit =Uri.parse('https://io.adafruit.com/Smart_System2023/dashboards/angel-proj');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
      appBar: AppBar(
        title: Text('Web'),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
            width: 200,
            height: 200,
            child: IconButton(onPressed: (){
              // alertDialog(context);

              launchUrl(adafruit);
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  PatientForm()));
              //Navigator.push(context, MaterialPageRoute(builder: (context) =>  dataInput()));

            }, icon: Image.asset('images/result.png'))),
      ),

    );
}
}
