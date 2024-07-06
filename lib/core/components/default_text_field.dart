import 'package:flutter/material.dart';
import 'package:group_55_database/core/colors/app_color.dart';

class DefaultTextField extends StatelessWidget {
  DefaultTextField({super.key, required this.controller, required this.label});

  TextEditingController controller;
  String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelStyle: const TextStyle(
            color: primaryColor,
          ),
          labelText: label,
        ),
      ),
    );
  }
}
