import 'package:flutter/material.dart';
import 'package:todo_app_firebase/auth_screen/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login.dart';

class Auth extends StatelessWidget {
  static const String routeName= "Auth";
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
     length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  Text(AppLocalizations.of(context)!.appName),
          bottom:  TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Text(AppLocalizations.of(context)!.login,style: const TextStyle(color: Colors.white,fontSize: 22),),
              Text(AppLocalizations.of(context)!.register,style: const TextStyle(color: Colors.white,fontSize: 22),),
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
