import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../result.dart';
import 'model.dart';

class PatientForm extends StatefulWidget {
  @override
  _PatientFormState createState() => _PatientFormState();
}


class _PatientFormState extends State<PatientForm> {
  final Uri adafruit =Uri.parse('https://io.adafruit.com/Smart_System2023/dashboards/angel-proj');

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _controller = ScreenshotController();

  void _savePatient() async {
    if (_formKey.currentState!.validate()) {
      final patient = Patient(
        name: _nameController.text,
        age: int.parse(_ageController.text),
        phone: _phoneController.text,
        address: _addressController.text,
      );
      final imageFile = await _controller.capture();
      patient.screenshotPath = imageFile.toString();
      // TODO: Save patient to database or file system
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Screenshot(
                  controller: _controller,
                  child:Container(
                      width: 200,
                      height: 200,
                      child: IconButton(onPressed: (){
                        // alertDialog(context);

                        launchUrl(adafruit);
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  Result()));
                        //Navigator.push(context, MaterialPageRoute(builder: (context) =>  dataInput()));

                      }, icon: Image.asset('images/result.png'))),
// Your app UI here,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePatient,
                child: Text('Save Patient'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
