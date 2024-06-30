import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/models/task_model.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
import 'package:todo_app_firebase/widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var pro = Provider.of<MyProvider>(context);
    var taskModel = ModalRoute.of(context)!.settings.arguments as TaskModel;
    titleController.text = taskModel.title;
    descController.text = taskModel.description;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.appbarName,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
        ),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Card(
            color: pro.theme == ThemeMode.light ? Colors.white : const Color(0XFF141922),
            child: Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                children:
                [
                  Text(AppLocalizations.of(context)!.editTask),
                  const Spacer(),
                  customTextField(
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      context: context,
                      label: AppLocalizations.of(context)!.title,
                      validator: (value){
                        if(titleController.text.isEmpty){
                          return AppLocalizations.of(context)!.titleMustNotBeEmpty;
                        }
                      }
                  ),
                  const Spacer(),
                  customTextField(
                      controller: descController,
                      keyboardType: TextInputType.multiline,
                      context: context,
                      label: AppLocalizations.of(context)!.description,
                      validator: (value){
                        if(descController.text.isEmpty){
                          return AppLocalizations.of(context)!.descriptionMustNotBeEmpty;
                        }
                      }
                  ),
                  const Spacer(),
                  customButton(
                    text: AppLocalizations.of(context)!.editTask,
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        if(taskModel.title != titleController.text || taskModel.description != descController.text){
                          taskModel.title = titleController.text;
                          taskModel.description = descController.text;
                          FirebaseFunction.updateTask(taskModel).then((e)
                          {
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(AppLocalizations.of(context)!.doneEdit),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          );
                        }else{
                          return ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!.pleaseChangeTitleOrDescription,style: const TextStyle(color: Colors.black),),
                              backgroundColor: Colors.amber,
                            ),
                          );
                        }
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
