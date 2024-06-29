import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_firebase/my_theme_data.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/home/task_item.dart';

import '../../task_model.dart';

class TaskScreen extends StatefulWidget {
   const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(
          height: MediaQuery.of(context).size.height * 0.14,
          DateTime.now(),
          initialSelectedDate: dateTime,
          selectionColor: MyThemeData.secondColor,
          selectedTextColor: Colors.white,
          locale: "en",
          onDateChange: (selectedDate) {
            dateTime = selectedDate;
            setState(() {

            });
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>> (
            stream: FirebaseFunction.getTasks(dateTime),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasError){
                return const Center(child: Text("Error"));
              }
              var tasks = snapshot.data?.docs.map((e) => e.data()).toList();
              if(tasks!.isEmpty){
                return const Center(child: Text("Not have tasks"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(
                    taskModel: tasks[index],
                  );
                },
                itemCount: tasks.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
