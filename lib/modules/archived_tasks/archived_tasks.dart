import 'package:Taskaty/shared/cubit/notes_cubit.dart';
import 'package:Taskaty/shared/cubit/notes_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/services/reusable_component.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (NotesAppCubit.get(context).archivedTasks.length ==0) {
      return buildImptyScreen( icon: Icons.archive_rounded);
    } else {
      return BlocConsumer<NotesAppCubit, NotesAppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(
                NotesAppCubit.get(context).archivedTasks[index], context),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],
                ),
            itemCount: NotesAppCubit.get(context).archivedTasks.length);
      },
    );
    }
  }
}
