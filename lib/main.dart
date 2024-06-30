import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_firebase/my_theme_data.dart';
import 'package:todo_app_firebase/home/home.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
import 'auth_screen/auth.dart';
import 'firebase_options.dart';
import 'home/edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider()..loadTheme()..loadLanguage(),
      child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    var  provider=Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.theme,
      locale: Locale(provider.langCode),
      initialRoute: provider.firebaseUser != null && provider.firebaseUser!.emailVerified == true ? Home.routeName : Auth.routeName,
      routes: {
        Home.routeName: (context) => const Home(),
        EditScreen.routeName: (context) => const EditScreen(),
        Auth.routeName: (context) => const Auth(),
      },
    );
  }
}
