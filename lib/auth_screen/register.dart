import 'package:flutter/material.dart';
import 'package:todo_app_firebase/firebase/firebase_function.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  label: AppLocalizations.of(context)!.name,
                  validator: (value){
                    if(nameController.text.isEmpty){
                      return AppLocalizations.of(context)!.nameMustNotBeEmpty;
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
                  label: AppLocalizations.of(context)!.phone,
                  validator: (value){
                    if(phoneController.text.isEmpty){
                      return AppLocalizations.of(context)!.phoneMustNotBeEmpty;
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
                  keyboardType: TextInputType.visiblePassword
              ),
              const SizedBox(
                height: 22,
              ),
              customButton(
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                     FirebaseFunction.createAccount(
                       context: context,
                         emailAddress: emailController.text,
                         password: passwordController.text,
                         name: nameController.text,
                         phone: phoneController.text,
                         onError: (error){
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error),backgroundColor: Colors.red,));
                         },
                         onSuccess: (){
                         ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(AppLocalizations.of(context)!.doneCreate),backgroundColor: Colors.green,));
                       }
                     );
                    }
                  },
                  text: AppLocalizations.of(context)!.register
              )
            ],
          ),
        ),
      ),
    );
  }
}
