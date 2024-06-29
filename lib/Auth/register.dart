import 'package:flutter/material.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';

import '../widget.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children:
            [
              const SizedBox(
                height: 22,
              ),
              customTextField(
                  context: context,
                  controller: nameController,
                  label: "Name",
                  validator: (value){
                    if(nameController.text.isEmpty){
                      return "Name must not be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name
              ),
              const SizedBox(
                height: 22,
              ),
              customTextField(
                  context: context,
                  controller: phoneController,
                  label: "Phone",
                  validator: (value){
                    if(phoneController.text.isEmpty){
                      return "Phone must not be empty";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone
              ),
              const SizedBox(
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
              const SizedBox(
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
                  keyboardType: TextInputType.visiblePassword
              ),
              const SizedBox(
                height: 22,
              ),
              customButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                     FirebaseFunction.createAccount(
                         emailAddress: emailController.text,
                         password: passwordController.text,
                         name: nameController.text,
                         phone: phoneController.text,
                         onError: (error){
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error),backgroundColor: Colors.red,));
                         },
                         onSuccess: (){
                         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Done"),backgroundColor: Colors.green,));
                       }
                     );
                    }
                  },
                  text: "Register"
              )
            ],
          ),
        ),
      ),
    );
  }
}
