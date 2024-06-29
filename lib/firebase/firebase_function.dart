import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_firebase/task_model.dart';

import '../user_model.dart';

class FirebaseFunction{

  /// Tasks Functions
  static CollectionReference<TaskModel> getTaskCollection() {
   return FirebaseFirestore.instance.collection(TaskModel.collectionName).withConverter<TaskModel>(
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
    return getTaskCollection()
        .where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("date",isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch)
        .orderBy("dateTime",descending: true)
        .snapshots();
 }

 static  Future<void> deleteTask(String id){
    return getTaskCollection().doc(id).delete();
 }

 static Future<void>  updateTask(TaskModel model){
    return getTaskCollection().doc(model.id).update(model.toJson());
 }





  /// Auth  Functions
  /// Auth  Functions
  /// Auth  Functions


  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance.collection(UserModel.collectionName).withConverter<UserModel>(
      fromFirestore: (snapshot, _) {
        return UserModel.fromJson(snapshot.data()!);
      },
      toFirestore: (userModel, _) {
        return userModel.toJson();
      },
    );
  }


  static Future<void> addUser(UserModel userModel){
    var collection = getUserCollection();
    var docRef = collection.doc(userModel.id);
    return docRef.set(userModel);
  }


  static void createAccount({
    required String emailAddress,
    required String password,
    required String name,
    required String phone,
    required Function onError,
    required Function onSuccess,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      addUser(UserModel(
          id: credential.user?.uid??"",
          name: name,
          phone: phone,
          email: emailAddress
      )).then((v){
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('weak-password');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      }
    } catch (e) {
      onError('something went wrong');
    }
  }


  static loginUser({
    required emailAddress,
    required password,
    required Function onSuccess,
    required Function onError,
  })async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      ).then((e){
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      }else{
        onError('Error');
      }
    }catch(e){
      onError('something went wrong');
    }
  }


  static logoutUser()async{
    await FirebaseAuth.instance.signOut();
  }




 static Future<UserModel?> readUserInfo()async
 {
   DocumentSnapshot<UserModel> documentSnapshot=await getUserCollection()
       .doc(FirebaseAuth.instance.currentUser!.uid).get();
   return documentSnapshot.data();
 }

}