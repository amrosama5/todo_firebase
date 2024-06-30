import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firebase/my_theme_data.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/home/task_item.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
import '../../models/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskScreen extends StatefulWidget {
   const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Column(
      children: [
        DatePicker(
          height: MediaQuery.of(context).size.height * 0.14,
          DateTime.now(),
          initialSelectedDate: dateTime,
          selectionColor: pro.theme == ThemeMode.light ? MyThemeData.secondColor : const Color(0xff141922),
          selectedTextColor: Colors.white,
          locale: pro.langCode=="en"?"en":"ar",
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
                return  Center(child: Text(AppLocalizations.of(context)!.error));
              }
              var tasks = snapshot.data?.docs.map((e) => e.data()).toList();
              if(tasks!.isEmpty){
                return  Center(child: Text(AppLocalizations.of(context)!.notHaveTasks));
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
