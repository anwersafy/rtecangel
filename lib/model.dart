import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtecangel/compoent.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title: Text("Image Picker from Gallery"),
            backgroundColor: Colors.redAccent
        ),
        body: Container(
            padding: EdgeInsets.only(top:20, left:20, right:20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [

                ElevatedButton(
                    onPressed: () async {
                      image = await picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        //update UI
                      });
                    },
                    child: Text("Pick Image")
                ),

                image == null?Container():
                Image.file(File(image!.path))

              ],)
        )
    );
  }
}
class pIck extends StatefulWidget {
  const pIck({Key? key}) : super(key: key);

  @override
  State<pIck> createState() => _pIckState();
}

class _pIckState extends State<pIck> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.only(top:20, left:20, right:20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [



            image == null?Container():
            Image.file(File(image!.path)),

            ElevatedButton(
                onPressed: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {

                    //update UI
                  });
                },
                child: Text("Pick Image")
            ),

          ],)
    );
  }
}
