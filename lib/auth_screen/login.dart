import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/home/home.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';
import '../models/user_model.dart';
import '../widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatelessWidget {
   Login({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: formKey,
        child: Column(
          children:
          [
            const SizedBox(
              height: 22,
            ),
            customTextField(
              context: context,
              controller: emailController,
              label: AppLocalizations.of(context)!.email,
              validator: (value){
                final bool emailValid =
                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if(!emailValid){
                  return AppLocalizations.of(context)!.emailValid;
                }
                if(emailController.text.isEmpty){
                  return AppLocalizations.of(context)!.emailMustNotBeEmpty;
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress
            ),
            const SizedBox(
              height: 22,
            ),
            customTextField(
                context: context,
                controller: passwordController,
                label: AppLocalizations.of(context)!.password,
                validator: (value){
                  if(passwordController.text.length < 6){
                    return AppLocalizations.of(context)!.passwordMustAtLeast6Char;
                  }
                  if(passwordController.text.isEmpty){
                    return AppLocalizations.of(context)!.passwordMustNotBeEmpty;
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress
            ),
            const SizedBox(
              height: 22,
            ),
            customButton(
              onPressed: (){
                if(formKey.currentState!.validate())
                {
                    FirebaseFunction.loginUser(
                      context: context,
                        emailAddress: emailController.text,
                        password: passwordController.text,
                        onSuccess: (){
                          if(FirebaseAuth.instance.currentUser?.emailVerified == true){
                            provider.initUser();
                            Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);
                          }else{

                            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(AppLocalizations.of(context)!.verifyEmail,style: const TextStyle(color: Colors.black),),backgroundColor: Colors.yellow,));
                          }
                        },
                        onError: (error){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error),backgroundColor: Colors.red,));
                        }
                    );
                }
              },
              text: AppLocalizations.of(context)!.login
            ),
            const SizedBox(
              height: 26,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                const Expanded(
                  child: Divider(
                    thickness: 2,
                    endIndent: 10,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: ()async{
                    UserCredential credential=await FirebaseFunction.signInWithGoogle();
                    await FirebaseFunction.addUser(UserModel(
                        id: credential.user?.uid??"",
                        name: credential.user?.displayName??"google user",
                        phone: credential.user?.phoneNumber??"",
                        email: credential.user?.email??""
                    )).then((v){
                      provider.initUser();
                      Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);
                    });
                  },
                  child: const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white60,
                    backgroundImage: NetworkImage(
                      "https://th.bing.com/th/id/R.1214cc6c68987d8cd09d62e08d96a824?rik=yGEmp8nggfzBaQ&pid=ImgRaw&r=0"
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: ()async{
                    UserCredential  credential =await FirebaseFunction.signInWithFacebook();
                    await FirebaseFunction.addUser(UserModel(
                        id: credential.user?.uid??"",
                        name: credential.user?.displayName??"facebook user",
                        phone: credential.user?.phoneNumber??"",
                        email: credential.user?.email??""
                    )).then((v){
                      provider.initUser();
                      Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);
                    });
                  },
                  child: const CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white60,
                    backgroundImage: NetworkImage(
                        "https://1.bp.blogspot.com/-S8HTBQqmfcs/XN0ACIRD9PI/AAAAAAAAAlo/FLhccuLdMfIFLhocRjWqsr9cVGdTN_8sgCPcBGAYYCw/s1600/f_logo_RGB-Blue_1024.png"
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white38,
                  child: Icon(Icons.phone),
                ),
                const Expanded(
                  child: Divider(
                    thickness: 2,
                    indent: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
