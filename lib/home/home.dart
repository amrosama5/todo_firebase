import 'package:flutter/material.dart';
import 'package:todo_app_firebase/home/add_task-bottom_sheet.dart';
import 'package:todo_app_firebase/home/tabs/settings_screen.dart';
import 'package:todo_app_firebase/home/tabs/task_screen.dart';

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
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "To do List",
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
            width: 3,
            color: Colors.white
          ),
            borderRadius: BorderRadius.circular(30)
        ),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        padding: EdgeInsets.zero,
        height: MediaQuery.of(context).size.height*0.07,
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
