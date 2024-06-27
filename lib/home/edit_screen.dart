import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/task_model.dart';

import '../MyThemeData.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "edit screen";
  EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var taskModel = ModalRoute.of(context)!.settings.arguments as TaskModel;
    titleController.text = taskModel.title;
    descController.text = taskModel.description;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "To do List",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: [
                const Text("Edit Task"),
                const Spacer(),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    label: Text(
                      "Title",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: MyThemeData.secondColor)),
                  ),
                ),
                const Spacer(),
                TextFormField(
                  controller: descController,
                  decoration: InputDecoration(
                    label: Text(
                      "Description",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: MyThemeData.secondColor)),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyThemeData.secondColor),
                      onPressed: () {
                        taskModel.title = titleController.text;
                        taskModel.description= descController.text;
                        FirebaseFunction.updateTask(taskModel).then((e){
                          FocusScope.of(context).unfocus();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Done Edited'),
                            backgroundColor: Colors.green,
                          ));
                        });
                      },
                      child: const Text("Edit Task",
                          style: TextStyle(color: Colors.white))),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
