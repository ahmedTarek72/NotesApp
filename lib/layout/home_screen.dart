import 'package:Taskaty/shared/cubit/notes_cubit.dart';
import 'package:Taskaty/shared/cubit/notes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/services/reusable_component.dart';

class HomeScreen extends StatelessWidget {
  bool icon = true;

  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesAppCubit()..createDataBAase(),// to create database when open app
      child: BlocConsumer<NotesAppCubit, NotesAppState>(
        listener: (context, state) {
          // to close bottomSheet after entering data
          if (state is InsertToDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              backgroundColor: mainColor,
              title: Text(NotesAppCubit.get(context)
                  .titles[NotesAppCubit.get(context).item]),
              centerTitle: true,
            ),
            // build floating action button
            floatingActionButton: FloatingActionButton(
              backgroundColor: mainColor,
              onPressed: () {
                if (NotesAppCubit.get(context).isButtomSheetOpen) {
                  if (formKey.currentState!.validate()) {
                    NotesAppCubit.get(context).insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    timeController.clear();
                    titleController.clear();
                    dateController.clear();
                  }
                } else {
                  NotesAppCubit.get(context)
                      .changeBottomSheetState(isShow: true, icon: Icons.add);
                  scaffoldKey.currentState?.showBottomSheet((context) {
                        NotesAppCubit.get(context).isButtomSheetOpen = true;
                        return Container(
                          color: Colors.grey[100],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                textfeild(
                                  icon: Icons.title_outlined,
                                  type: TextInputType.text,
                                  label: "Task Title",
                                  controller: titleController,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return "task title must not be empty";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                textfeild(
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then((value) {
                                      try {
                                        timeController.text =
                                            value!.format(context).toString();
                                      } catch (error) {
                                        return ("Error: $error");
                                      }
                                    });
                                  },
                                  icon: Icons.watch_later_rounded,
                                  type: TextInputType.datetime,
                                  label: "Task Time",
                                  controller: timeController,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return "Task time must not be empty";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                textfeild(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse("2025-12-31"),
                                    ).then((value) {
                                      try {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      } catch (error) {
                                        return ('Error:$error');
                                      }
                                    });
                                  },
                                  icon: Icons.calendar_month,
                                  type: TextInputType.text,
                                  label: "Task Date",
                                  controller: dateController,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return "task date must not be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                      .closed
                      .then((value) {
                        NotesAppCubit.get(context).changeBottomSheetState(
                            isShow: false, icon: Icons.edit);
                      });
                }
              },
              child: Icon(NotesAppCubit.get(context).fabIcon),
            ),
            // build bottom navbar
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: mainColor,
              onTap: (index) {
                NotesAppCubit.get(context).changeIndex(index);
              },
              currentIndex: NotesAppCubit.get(context).item,
              items: [
                BottomNavigationBarItem(
                    backgroundColor: mainColor,
                    icon: const Icon(
                      (Icons.menu),
                    ),
                    label: "Tasks"),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.cloud_done_rounded,
                    ),
                    label: "Done"),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive,
                  ),
                  label: "Archived",
                )
              ],
            ),
            // show screen by it's item number
            body: NotesAppCubit.get(context)
                .screens[NotesAppCubit.get(context).item],
          );
        },
      ),
    );
  }
}
