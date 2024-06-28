import 'package:flutter/material.dart';
import 'package:todo_app_firebase/Auth/login.dart';
import 'package:todo_app_firebase/Auth/register.dart';

class Auth extends StatelessWidget {
  static const String routeName= "Auth";
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
     length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Text("Login",style: TextStyle(color: Colors.white,fontSize: 22),),
              Text("Register",style: TextStyle(color: Colors.white,fontSize: 22),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Login(),
            Register()
          ],
        ),
      ),
    );
  }
}
