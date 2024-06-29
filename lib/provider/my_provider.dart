import 'package:flutter/cupertino.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
class MyProvider extends ChangeNotifier{
  UserModel? userModel;
  User? firebaseUser;


  MyProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser != null){
      initUser();
    }
  }


  initUser()async{
   userModel = await FirebaseFunction.readUserInfo();
   notifyListeners();
  }

}