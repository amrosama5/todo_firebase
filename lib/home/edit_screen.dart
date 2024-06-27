import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  static const String routeName = "edit screen" ;
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "To do List",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
      body: const Card(

      ),
    );
  }
}
