import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtecangel/cubit/cubit.dart';
import 'package:rtecangel/feature/pationScreen.dart';

import '../compoent.dart';
import '../cubit/state.dart';
import '../database_helper.dart';
import 'model.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  void initState() {
    super.initState();
    _loadPatients();
    // TODO: Load patients from database or file system
  }

  void _navigateToPatientDetail( patient) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PatientDetailScreen(patient: patient),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context,state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: ListView.builder(
            itemCount: cubit.PationData.length,
            itemBuilder: (context, index) {
              final patient = cubit.PationData[index];
              return ListTile(
                title: Text(cubit.PationData[index].name),
                subtitle: Text(patient.age.toString()),
                onTap: () => _navigateToPatientDetail(patient),
              );
            },
          ),
        );
      }
    );
  }

   _loadPatients() {
    DatabaseHelper().getAllPatients().then((value) {
      setState(() {
        patients = value;
      });
    });
  }
}
