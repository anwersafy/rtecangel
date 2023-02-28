import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rtecangel/cubit/cubit.dart';
import 'package:rtecangel/profile.dart';

import 'cubit/state.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase() ,
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {},
        builder: (context,state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home:  SplashScreen(),
          );
        }
      ),
    );
  }
}


