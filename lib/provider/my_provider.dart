import 'package:flutter/material.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyProvider extends ChangeNotifier{
  UserModel? userModel;
  User? firebaseUser;
  String langCode="en";
  SharedPreferences? sharedPreferences;
  ThemeMode?  theme = ThemeMode.light;


  void changeLanguageCode(String langCode){
    this.langCode = langCode;
    notifyListeners();
    saveLanguage(langCode);
  }



  saveLanguage(String lang){
    sharedPreferences!.setString('lang',lang);
  }

  Future<void> loadLanguage()async{
    sharedPreferences =await SharedPreferences.getInstance();
    String? lang=sharedPreferences!.getString('lang');
    if(lang!=null){
      changeLanguageCode(lang);
    }
  }

  changeTheme(ThemeMode themeMode){
    theme = themeMode;
    notifyListeners();
    saveTheme(themeMode);
  }


  saveTheme(ThemeMode themeMode){
    String theme = themeMode == ThemeMode.dark ?"dark":"light";
    sharedPreferences!.setString('theme',theme);
  }

  Future<void> loadTheme()async{
    sharedPreferences =await SharedPreferences.getInstance();
    String? theme=sharedPreferences!.getString('theme');
    if(theme!=null){
      if(theme=="dark") {
        changeTheme(ThemeMode.dark);
      } else if(theme=="light"){
        changeTheme(ThemeMode.light);
      }
    }
  }

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