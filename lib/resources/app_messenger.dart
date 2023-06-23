import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant_internship/resources/resources.dart';

class AppMessenger {
  final BuildContext context;

  AppMessenger.of(this.context);

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.titleColor,

        content: Row(
          children: [
            const Icon(Icons.info_outline_rounded),
            Text(text),
          ],
        ),
      ),
    );
  }
}
