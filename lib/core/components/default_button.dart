import 'package:flutter/material.dart';
import 'package:group_55_database/core/colors/app_color.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({super.key, required this.label, required this.onPress});

  String label;
  void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      minWidth: MediaQuery.sizeOf(context).width - 40,
      padding: const EdgeInsets.all(15),
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
