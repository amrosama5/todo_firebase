import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:todo_app_firebase/home/home.dart';

import '../widget.dart';

class Login extends StatelessWidget {
   Login({super.key});
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: formKey,
        child: Column(
          children:
          [
            SizedBox(
              height: 22,
            ),
            customTextField(
              context: context,
              controller: emailController,
              label: "Email",
              validator: (value){
                if(emailController.text.isEmpty){
                  return "Email must not be empty";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress
            ),
            SizedBox(
              height: 22,
            ),
            customTextField(
                context: context,
                controller: passwordController,
                label: "Password",
                validator: (value){
                  if(passwordController.text.isEmpty){
                    return "Password must not be empty";
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress
            ),
            SizedBox(
              height: 22,
            ),
            customButton(
              onPressed: (){
                if(formKey.currentState!.validate()){
                  FirebaseFunction.loginUser(
                      emailAddress: emailController.text,
                      password: passwordController.text,
                    onSuccess: (){
                        Navigator.pushNamedAndRemoveUntil(context, Home.routeName, (route) => false);
                    },
                    onError: (error){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
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
