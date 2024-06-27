import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_firebase/MyThemeData.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/home/edit_screen.dart';
import 'package:todo_app_firebase/task_model.dart';

class TaskItem extends StatefulWidget {
  TaskModel taskModel;
  TaskItem({required this.taskModel, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: const DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunction.deleteTask(widget.taskModel.id ?? "");
            },
            label: "Delete",
            backgroundColor: Colors.red,
            autoClose: true,
            icon: Icons.delete_forever,
            spacing: 12,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12), topLeft: Radius.circular(12)),
          ),
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, EditScreen.routeName,arguments: widget.taskModel);
            },
            label: "Edit",
            backgroundColor: Colors.blue,
            autoClose: true,
            icon: Icons.delete_forever,
            spacing: 12,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
                topRight: Radius.circular(12)),
          )
        ]),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 80,
                  width: 5,
                  decoration: BoxDecoration(
                      color: MyThemeData.secondColor,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.taskModel.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(widget.taskModel.description ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  widget.taskModel.isDone=!widget.taskModel.isDone;
                  FirebaseFunction.updateTask(widget.taskModel);
                  setState(() {

                  });
                },
                child:  widget.taskModel.isDone != true ? Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MyThemeData.secondColor),
                  child: const Icon(
                    Icons.done,
                    color: MyThemeData.primaryColor,
                    size: 30,
                  )
                ) : const Text("Done!",style: TextStyle(color: Colors.green),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
