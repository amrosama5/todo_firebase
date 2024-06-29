import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/home/home.dart';
import 'package:todo_app_firebase/provider/my_provider.dart';

import '../widget.dart';

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
              label: "Email",
              validator: (value){
                final bool emailValid =
                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if(!emailValid){
                  return 'Email Valid';
                }
                if(emailController.text.isEmpty){
                  return "Email must not be empty";
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
                label: "Password",
                validator: (value){
                  if(passwordController.text.length < 6){
                    return 'password must at least 6 char';
                  }
                  if(passwordController.text.isEmpty){
                    return "Password must not be empty";
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
                if(formKey.currentState!.validate()){
                   FirebaseFunction.loginUser(
                      emailAddress: emailController.text,
                      password: passwordController.text,
                    onSuccess: (){
                        provider.initUser();
                        Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);
                    },
                    onError: (error){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error),backgroundColor: Colors.red,));
                    }
                  );
                }
              },
              text: "Login"
            )
          ],
        ),
      ),
    );
  }
}
