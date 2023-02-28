import 'dart:io';

import 'package:flutter/material.dart';

import 'model.dart';

class PatientDetailScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patient.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Age: ${patient.age}'),
                  SizedBox(height: 8),
                  Text('Phone: ${patient.phone}'),
                  SizedBox(height: 8),
                  Text('Address: ${patient.address}'),
                ],
              ),
            ),
            Image.file(File(patient.screenshotPath!)),
          ],
        ),
      ),
    );
  }
}
