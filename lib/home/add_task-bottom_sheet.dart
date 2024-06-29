import 'package:flutter/material.dart';
import 'package:todo_app_firebase/MyThemeData.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_firebase/widget.dart';

class AddTaskbottomSheet extends StatefulWidget {
  const AddTaskbottomSheet({super.key});

  @override
  State<AddTaskbottomSheet> createState() => _AddTaskbottomSheetState();
}

class _AddTaskbottomSheetState extends State<AddTaskbottomSheet> {
  DateTime dateTime = DateTime.now();
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 26,
                ),
                Text(
                  "Add Task",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  height: 36,
                ),
                customTextField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    context: context,
                    label: "Title",
                    validator: (value) {
                      if (titleController.text.isEmpty) {
                        return 'title must not be empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 36,
                ),
                customTextField(
                    controller: descController,
                    keyboardType: TextInputType.multiline,
                    context: context,
                    label: "Description",
                    validator: (value) {
                      if (descController.text.isEmpty) {
                        return 'description must not be empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 26,
                ),
                const Text(
                  "Select Time",
                  style: TextStyle(color: Colors.black),
                ),
                const SizedBox(
                  height: 26,
                ),
                TextButton(
                  onPressed: () {
                    viewDatePicker(context);
                  },
                  child: Text(
                    dateTime.toString().substring(0, 10),
                    style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w200,
                        fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                customButton(
                  text: "Add Task",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseFunction.addTask(
                        TaskModel(
                          title: titleController.text,
                          description: descController.text,
                          dateTime: dateTime.toString().substring(11),
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          date: DateUtils.dateOnly(dateTime)
                              .millisecondsSinceEpoch,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(
                  height: 26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  viewDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedDate != null) {
      dateTime = selectedDate;
      setState(() {});
    }
  }
}
