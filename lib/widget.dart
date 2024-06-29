import 'package:flutter/material.dart';

import 'my_theme_data.dart';

Widget customTextField(
    {required controller,
    required keyboardType,
    required context,
    required label,
    required validator
    }) {
  return TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      label: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Colors.black),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: MyThemeData.secondColor),
      ),
    ),
    keyboardType: keyboardType,
  );
}

Widget customButton({required text, required onPressed}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: MyThemeData.secondColor),
        onPressed: onPressed,
        child: Text(text,style: const TextStyle(color: Colors.white),),
    ),
  );
}
