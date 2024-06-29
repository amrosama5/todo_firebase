import 'package:flutter/material.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/task_model.dart';
import 'package:todo_app_firebase/widget.dart';
class EditScreen extends StatefulWidget {
  static const String routeName = "edit screen";
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
        child: Form(
          key: formKey,
          child: Card(
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children: [
                  const Text("Edit Task"),
                  const Spacer(),
                  customTextField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      context: context,
                      label: "Title",
                      validator: (value){
                        if(titleController.text.isEmpty){
                          return 'Title must not be empty';
                        }
                      }
                  ),
                  const Spacer(),
                  customTextField(
                      controller: descController,
                      keyboardType: TextInputType.multiline,
                      context: context,
                      label: "Description",
                      validator: (value){
                        if(descController.text.isEmpty){
                          return 'description must not be empty';
                        }
                      }
                  ),
                  const Spacer(),
                  customButton(
                    text: "Edit Task",
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        taskModel.title = titleController.text;
                        taskModel.description = descController.text;
                        FirebaseFunction.updateTask(taskModel).then((e)
                        {
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Done Edited'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
