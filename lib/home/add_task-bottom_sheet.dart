import 'package:flutter/material.dart';
import 'package:todo_app_firebase/MyThemeData.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/task_model.dart';

class AddTaskbottomSheet extends StatefulWidget {
  const AddTaskbottomSheet({super.key});

  @override
  State<AddTaskbottomSheet> createState() => _AddTaskbottomSheetState();
}

class _AddTaskbottomSheetState extends State<AddTaskbottomSheet> {
  DateTime dateTime=DateTime.now();
  var titleController=TextEditingController();
  var descController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: MyThemeData.secondColor)),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
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
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: MyThemeData.secondColor)),
              ),
            ),
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
              onPressed: (){
                viewDatePicker(context);
              },
              child: Text(dateTime.toString().substring(0,10),style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w200,fontSize: 30),),

            ),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyThemeData.secondColor),
                    onPressed: () {
                      FirebaseFunction.addTask(
                          TaskModel(
                              title: titleController.text,
                              description: descController.text,
                              date: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch,
                          ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text("Add Task", style: TextStyle(color: Colors.black)))),
            const SizedBox(
              height: 26,
            ),
          ],
        ),
      ),
    );
  }

  viewDatePicker(BuildContext context)async{
    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if(selectedDate!=null) {
      dateTime = selectedDate;
      setState(() {

      });
    }
  }
}
