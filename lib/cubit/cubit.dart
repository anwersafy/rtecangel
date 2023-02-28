import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:rtecangel/cubit/state.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:ui' as ui;



class AppCubit extends Cubit<AppStates> {
  int currentIndex = 0;


  late Database database;
  bool isBottomSheetShown = false;
  IconData fab = Icons.edit;

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('created');
      database
          .execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL,
        $columnState TEXT NOT NULL,
        $columnScreenshotPath TEXT NOT NULL
      )
    ''')
          .then((value) {
        print('table creted');
      }).catchError((onError) {
        print('error');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('Opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertIntoDatabase({
    required int id,
    required String name,
    required dynamic age,
    required String state,
    required String screenshotPath,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO $table ($columnId, $columnName, $columnAge, $columnState, $columnScreenshotPath) VALUES ($id, $name, $age, $state, $screenshotPath)')
          .then((value) {
        print('${value.toString()} inserted successfully');
        emit(AppInsertIntoDataState());
        getDataFromDatabase(database);
      }).catchError((onError) {
        print('error occurred {$onError.toString()}');
      });
      return Future(() => null);
    });
  }
List PationData=[];
  void getDataFromDatabase(database) {
    PationData=[];

    emit(AppLoadingState());
    List<Map> tasks;
    database.rawQuery("SELECT * FROM $table").then((value) {
      tasks = value;
      emit(AppGetDatabaseState());
      tasks.forEach((element) {
        //print(element['status']);
       PationData.add(element);


      });
    });
  }

  void updateData({required String status, required int id}) async {
    database.rawUpdate(
        'UPDATE $table SET $columnState = ? WHERE $columnId = ?',
        ['$status', id]).then((value)  {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });

  }
  void deleteData({required int id}) async {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });

  }
  static final String table = 'patient_table';
  static final String  columnId = '_id';
  static final String columnName = 'name';
  static final String columnAge = 'age';
  static final String columnState = 'state';
  static final String columnScreenshotPath = 'screenshot_path';

  late var key = GlobalKey();

  void CaptureScreenShot() async{
    //get paint bound of your app screen or the widget which is wrapped with RepaintBoundary.
    RenderRepaintBoundary bound = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    if(bound.debugNeedsPaint){
      Timer(Duration(seconds: 5),()=>CaptureScreenShot());
      return null;
    }
    ui.Image image = await bound.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    // this will save image screenshot in gallery
    if(byteData != null ){
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}.png');
      print(resultsave);
    }
  }
}
