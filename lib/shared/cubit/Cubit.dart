import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archivedTasks/ArchivedTasks_Screen.dart';
import 'package:todo/modules/doneTasks/DoneTasks_Screen.dart';
import 'package:todo/modules/newTasks/NewTasks_Screen.dart';
import 'package:todo/shared/cubit/States.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  int index = 0;

  final List<Widget> screens = [
    Tasks(),
    Done(),
    Archived(),
  ];

  final List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(int index) {
    this.index = index;
    emit(AppChangeBottomNavBar());
  }

  bool isSheet = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({
    required bool isShow,
    required IconData icon,
  }) {
    isSheet = isShow;
    fabIcon = icon;
    emit(AppChangeBottomsheet());
  }

  Database? database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];


  void createDataBase(){
    openDatabase(
      'toDo.db',
      version: 1,
      onCreate: (database , version){
        if (kDebugMode) {
          print('dataBase created');
        }
        try {
          database.execute(
              'CREATE TABLE tasks(id integer primary key , title text , date text , time text , status text)');
          if (kDebugMode) {
            print('table created');
          }
        } catch (error) {
          if (kDebugMode) {
            print('Error when creating table ${error.toString()}');
          }
        }
      },
      onOpen: (database){
        getDataFromDatabase(database);
        if (kDebugMode) {
          print('dataBase opened');
        }
      }
    ).then((value){
      database = value;
      emit(AppCreateDataBase());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database?.transaction((txn) async {
      try {
        txn.rawInsert(
            'INSERT INTO tasks(title , date , time , status)VALUES("$title" , "$date" , "$time" , "new")');
        if (kDebugMode) {
          print('inserted successfully');
        }
        emit(AppInsertDataBase());
        getDataFromDatabase(database);
      } catch (error) {
        if (kDebugMode) {
          print('Error when inserting ${error.toString()}');
        }
      }
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    database?.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element){
        if(element['status'] == 'new'){
          newTasks.add(element);
        }else if(element['status'] == 'done'){
          doneTasks.add(element);
        }else{
          archivedTasks.add(element);
        }
      });
      emit(AppGetDataBase());
    });
    // print(tasks);
  }

  void updateDataBase({required String status, required int id}) async{
    database?.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status , id],
    ).then((value){
      getDataFromDatabase(database);
      emit(AppUpdateDataBase());
    });
  }

  void deleteDataBase({required int id}) async{
    database?.rawUpdate(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value){
      getDataFromDatabase(database);
      emit(AppDeleteDataBase());
    });
  }
}

