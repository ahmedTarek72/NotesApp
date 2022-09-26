import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../modules/archived_tasks/archived_tasks.dart';
import '../../modules/done_tasks/done_tasks.dart';
import '../../modules/new_tasks/new_tasks.dart';
import 'notes_state.dart';

class NotesAppCubit extends Cubit<NotesAppState> {
  NotesAppCubit() : super(NotesInitial());
  static NotesAppCubit get(context) => BlocProvider.of(context);
  int item = 0;
  List<Widget> screens = [
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks()
  ];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<String> titles = [
    "Tasks",
    "DoneTasks",
    "Archived Tasks",
  ];
  late Database database;
  // change icon you choose on buttom navBar
  void changeIndex(int index) {
    item = index;
    emit(ChangeBottomNavBarState());
  }

  // create database for first time
  void createDataBAase() {
    openDatabase("todo.db", version: 1,
        onCreate: (Database database, int version) {
      database
          .execute(
              'CREATE TABLE Test (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)')
          .then((value) => "DataBase Created");
    }, onOpen: (database) {
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  insertToDatabase(
      {required String title, required String time, required String date}) {
    database.transaction((txn) async {
      await txn
          .rawInsert(
              "INSERT INTO test (title, date , time, status) VALUES ('$title','$date','$time','new')")
          .then((value) {
        print('$value inserted Successfully');
        emit(InsertToDataBaseState());
        getDataFromDatabase(database);
      });

      return null;
    });
  }

  getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM Test').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(GetDataFromDataBaseState());
    });
  }

  bool isButtomSheetOpen = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isButtomSheetOpen = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }

  void updateDate({
    required String status,
    required int id,
  }) async {
    database.rawUpdate('UPDATE test SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      getDataFromDatabase(database);

      emit(UpdateDateBaseState());
    });
  }
  void deleteData({
    required int id,
  }) async {
    database
        .rawDelete('DELETE FROM test WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);

      emit(DeleteDateBaseState());
    });
  }
}
