import 'package:flutter/material.dart';
import 'package:todo_app_firebase/my_theme_data.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/home/add_task_bottom_sheet.dart';
import 'package:todo_app_firebase/home/tabs/settings_screen.dart';
import 'package:todo_app_firebase/home/tabs/task_screen.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../auth_screen/auth.dart';
class Home extends StatefulWidget {
  const Home({super.key});
  static const String routeName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index=0;
  ///https://todo-app-fa213.firebaseapp.com/__/auth/handler
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
          "${AppLocalizations.of(context)!.appbarName} , ${AppLocalizations.of(context)!.hello} ${provider.userModel?.name.toUpperCase()}",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: provider.theme == ThemeMode.light ? Colors.white : const Color(0xff141922),fontSize: 16),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: provider.theme == ThemeMode.light ? Colors.white : const Color(0xff141922),
            builder: (context)
          {
            return const AddTaskBottomSheet();
          },);
        },
        shape: RoundedRectangleBorder(
          side:  BorderSide(
            width: 4,
            color: provider.theme == ThemeMode.light ? Colors.white : const Color(0xff141922)
          ),
            borderRadius: BorderRadius.circular(30)
        ),
        backgroundColor: provider.theme == ThemeMode.light ? MyThemeData.primaryColor : MyThemeData.secondDarkColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: provider.theme == ThemeMode.light ? Colors.white :const Color(0xff141922),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
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
  List<Widget> screens= [ const TaskScreen(), const SettingsScreen()];
}
