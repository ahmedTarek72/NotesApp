import 'package:Taskaty/shared/cubit/notes_cubit.dart';
import 'package:Taskaty/shared/cubit/notes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/services/reusable_component.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesAppCubit, NotesAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (NotesAppCubit.get(context).doneTasks.length==0) {
          return buildImptyScreen(icon: Icons.cloud_done_rounded);
        } else {
          return ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(
                NotesAppCubit.get(context).doneTasks[index], context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
            itemCount: NotesAppCubit.get(context).doneTasks.length);
        }
      },
    );
  }
}
