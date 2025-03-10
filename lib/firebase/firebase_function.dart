import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_firebase/task_model.dart';

class FirebaseFunction{
  static CollectionReference<TaskModel> getTaskCollection() {
   return FirebaseFirestore.instance.collection("Tasks").withConverter<TaskModel>(
       fromFirestore: (snapshot, _) {
         return TaskModel.fromJson(snapshot.data()!);
       },
       toFirestore: (taskModel, _) {
         return taskModel.toJson();
       },
   );
 }


  static Future<void> addTask(TaskModel taskModel){
    var collection = getTaskCollection();
    var docRef = collection.doc();
    taskModel.id = docRef.id;
    return docRef.set(taskModel);
 }


 static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date){
    return getTaskCollection().where("date",isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch).snapshots();
 }

 static  Future<void> deleteTask(String id){
    return getTaskCollection().doc(id).delete();
 }

 static Future<void>  updateTask(TaskModel model){
    return getTaskCollection().doc(model.id).update(model.toJson());
 }

}