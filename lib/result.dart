import 'package:flutter/material.dart';
import 'package:rtecangel/compoent.dart';
import 'package:rtecangel/cubit/cubit.dart';
import 'package:rtecangel/database_helper.dart';
import 'package:rtecangel/profile.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import 'feature/profile.dart';
import 'files.dart';

class Result extends StatefulWidget {
   Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {

    super.initState();
    AppCubit.get(context).CaptureScreenShot() ;  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: AppCubit.get(context).key,
      child: Scaffold(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  angleReader()));

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
      ),
    );
  }
}
