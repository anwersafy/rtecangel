import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'files.dart';

class Result extends StatelessWidget {
   Result({Key? key}) : super(key: key);
  final Uri adafruit =Uri.parse('https://io.adafruit.com/Smart_System2023/dashboards/angel-proj');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 1,),
            Container(
              width: 200,
                height: 200,
                child: IconButton(onPressed: (){
                  launchUrl(adafruit);

                }, icon: Image.asset('images/result.png'))),
            Spacer(flex: 1,),
            Container(
              width: 200,
                height: 200,
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Files()));
                }, icon: Image.asset('images/folder.png'))),
            Spacer(flex: 1,),



          ],
        ),
      ),
    );
  }
}
