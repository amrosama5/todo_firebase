import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool val=false;
  bool val2=false;
  @override
  Widget build(BuildContext context) {

    var pro = Provider.of<MyProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: Scaffold(
        body:  SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Text(AppLocalizations.of(context)!.theme,textAlign: TextAlign.center,style: TextStyle(color: pro.theme==ThemeMode.light ? Colors.black :Colors.white),),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(AppLocalizations.of(context)!.language,textAlign: TextAlign.center,style: TextStyle(color: pro.theme==ThemeMode.light ? Colors.black :Colors.white),),
                ],
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                      value: val, onChanged: (e){
                        setState(() {
                          val = e;
                          if(val){
                            pro.changeTheme(ThemeMode.dark);
                          }else{
                            pro.changeTheme(ThemeMode.light);
                          }
                        });
                  }),
                  Switch(
                      value: val2, onChanged: (e){
                    setState(() {
                      val2 = e;
                      if(val2){
                        pro.changeLanguageCode("ar");
                      }else{
                        pro.changeLanguageCode("en");
                      }
                    });
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
