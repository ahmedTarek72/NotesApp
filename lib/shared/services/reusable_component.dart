import 'package:Taskaty/shared/cubit/notes_cubit.dart';
import 'package:flutter/material.dart';

Color mainColor = const Color.fromARGB(255, 20, 16, 63); // color of app

// build text form field item
Widget textfeild({
  required IconData icon,
  required TextInputType type,
  required String label,
  required TextEditingController controller,
  Function()? onTap,
  bool showCursor = false,
  bool readOnly = false,
  required FormFieldValidator<String> validate,
}) {
  return Container(
    color: Colors.white,
    child: TextFormField(
      showCursor: showCursor,
      validator: validate,
      readOnly: readOnly,
      controller: controller,
      onTap: onTap,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 20, 16, 63), width: 3)),
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      keyboardType: type,
    ),
  );
}

// build item shape on screen
Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        NotesAppCubit.get(context).deleteData(
          id: model['id'],
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: mainColor,
              radius: 40,
              child: Text("${model['time']}"),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${model['title']}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${model['date']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  NotesAppCubit.get(context)
                      .updateDate(status: "done", id: model['id']);
                },
                icon: const Icon(Icons.cloud_done_rounded)),
            GestureDetector(
              onLongPress: () {
                NotesAppCubit.get(context)
                    .updateDate(status: 'new', id: model['id']);
              },
              onTap: () {
                NotesAppCubit.get(context)
                    .updateDate(status: 'archived', id: model['id']);
              },
              child: const Icon((Icons.archive_rounded)),
            )
          ],
        ),
      ),
    );
// build impty screen when no tasks added
Widget buildImptyScreen({required IconData icon,context}){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,size: 100,color: mainColor,),
        Text("No Tasks Yet, Please Add some Tasks",style: TextStyle(fontSize: 20,color: mainColor),),
        
      ],
    ),
  );
}
