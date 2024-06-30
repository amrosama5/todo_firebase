import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/models/task_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
import 'package:todo_app_firebase/widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime dateTime = DateTime.now();
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    AppLocalizations.of(context)!.addTask,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                ),
                const SizedBox(
                  height: 36,
                ),
                customTextField(
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    context: context,
                    label: AppLocalizations.of(context)!.title,
                    validator: (value) {
                      if (titleController.text.isEmpty) {
                        return AppLocalizations.of(context)!.titleMustNotBeEmpty;
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
                    label: AppLocalizations.of(context)!.description,
                    validator: (value) {
                      if (descController.text.isEmpty) {
                        return AppLocalizations.of(context)!.description;
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 26,
                ),
                 Text(
                   AppLocalizations.of(context)!.selectTime,
                  style: TextStyle(color: pro.theme == ThemeMode.light ? Colors.black :Colors.white),
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
                    style: TextStyle(
                        color:pro.theme == ThemeMode.light ? Colors.grey : Colors.white60,
                        fontWeight: FontWeight.w200,
                        fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 26,
                ),
                customButton(
                  text: AppLocalizations.of(context)!.description,
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
