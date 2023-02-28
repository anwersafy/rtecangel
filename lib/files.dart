import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'compoent.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'database_helper.dart';
import 'feature/pationScreen.dart';
import 'feature/profile.dart';
import 'model.dart';

class Files extends StatefulWidget {
  const Files({Key? key}) : super(key: key);

  @override
  State<Files> createState() => _FilesState();
}

class _FilesState extends State<Files> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var caseController = TextEditingController();
  var dateController = TextEditingController();
  var valueController = TextEditingController();
  var scanController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
      builder: (context,state) {
        return Form(
          key: formKey,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              body: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: ageController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an age';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Age',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: dateController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an date';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Date',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: valueController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an value';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Value',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: caseController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an Pathological case';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Pathological case',
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   width: 400,
                        //   height: 300,
                        //   child: image == null
                        //       ? Center(
                        //           child: Text('No image selected.'),
                        //         )
                        //       : Image.file(
                        //           File(image!.path),
                        //           fit: BoxFit.cover,
                        //         ),
                        // )
                      ],
                    ),
            Container(
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
              scanController.text = image!.path;
              patients.add(Patient(
                  name: nameController.text,
                  age: ageController.value,
                  state: caseController.text,
                  screenshotPath: scanController.text));


            //update UI
            });
            },
            child: Text("Pick Image")
            ),

            ],)
            ),
                    SizedBox(
                      height: 10,
                    ),
                    // ElevatedButton(
                    //   onPressed: () => pickImage(),
                    //   child: Text('Pick an image'),
                    // ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          var patient = Patient(
                            name: nameController.text,
                            age: ageController.value,
                            state: caseController.text,
                            screenshotPath: scanController.text,
                          );
                          patients.add(patient);
                          AppCubit.get(context).insertIntoDatabase(
                            id: 0,
                              name: nameController.text,
                              age: ageController.value,
                              state: caseController.text,
                              screenshotPath: scanController.text
                          );
                           DatabaseHelper().insertPatient(patient);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),

                ),
          ),
        );
      }
    );
  }
}
