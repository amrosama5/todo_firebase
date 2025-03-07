import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_firebase/MyThemeData.dart';
import 'package:todo_app_firebase/home/home.dart';
import 'firebase_options.dart';
import 'home/edit_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      themeMode: ThemeMode.light,
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) =>  const Home(),
        EditScreen.routeName: (context) =>   const EditScreen(),
      },
    );
  }
}
