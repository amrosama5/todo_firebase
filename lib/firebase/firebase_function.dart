import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app_firebase/models/task_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/user_model.dart';

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
    required context
  }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await credential.user!.sendEmailVerification();
      await addUser(UserModel(
          id: credential.user?.uid??"",
          name: name,
          phone: phone,
          email: emailAddress
      )).then((v){
        onSuccess();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError(AppLocalizations.of(context)!.weakPassword);
      } else if (e.code == 'email-already-in-use') {
        onError(AppLocalizations.of(context)!.emailAlreadyInUse);
      }
    } catch (e) {
      onError(AppLocalizations.of(context)!.somethingWentWrong);
    }
  }


  static loginUser({
    required emailAddress,
    required password,
    required Function onSuccess,
    required Function onError,
    required context
  })async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      ).then((e){
        if(FirebaseAuth.instance.currentUser?.emailVerified == true){
          onSuccess();
        }else{
          onError(AppLocalizations.of(context)!.verifyEmail);
        }

      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError(AppLocalizations.of(context)!.userNotFound);
      } else if (e.code == 'wrong-password') {
        onError(AppLocalizations.of(context)!.wrongPassword);
      }else{
        onError(AppLocalizations.of(context)!.error);
      }
    }catch(e){
      onError(AppLocalizations.of(context)!.somethingWentWrong);
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



 /// social auth
///
///


  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


}