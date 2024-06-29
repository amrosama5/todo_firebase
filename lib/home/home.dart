import 'package:flutter/material.dart';
import 'package:todo_app_firebase/MyThemeData.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/home/add_task-bottom_sheet.dart';
import 'package:todo_app_firebase/home/tabs/settings_screen.dart';
import 'package:todo_app_firebase/home/tabs/task_screen.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
import 'package:provider/provider.dart';

import '../Auth/auth.dart';
class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index=0;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(onPressed: (){
            FirebaseFunction.logoutUser();
            Navigator.pushNamedAndRemoveUntil(context, Auth.routeName, (route) => false,);
          }, icon: const Icon(Icons.logout_outlined))
        ],
        title: Text(
          "To do List ,Hello ${provider.userModel?.name.toUpperCase()}",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
        backgroundColor: const Color(0xff5D9CEC),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context)
          {
            return const AddTaskbottomSheet();
          },);
        },
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 4,
            color: Colors.white
          ),
            borderRadius: BorderRadius.circular(30)
        ),
        backgroundColor: MyThemeData.primaryColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: index,
          onTap: (int value){
            index=value;
            setState(() {

            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
          ],
        ),
      ),
      body: screens[index],
    );
  }
  List<Widget> screens= [ const TaskScreen(),const SettingsScreen()];
}
