import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rtecangel/result.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child:LottieBuilder.asset('images/13893-eco-living.json')),
          const Text(
            'R-Tec',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 69),
          ),
          SizedBox(
            width: 150,
            height: 150,
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  Result()));
                },
                icon: Image.asset('images/icons8-forward-button-50.png')),
          )
        ],
      ),
    );
  }
}
