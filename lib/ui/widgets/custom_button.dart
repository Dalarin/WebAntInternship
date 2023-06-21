import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final BoxBorder? border;
  final TextStyle style;
  final VoidCallback? callback;

  const CustomButton({
    required this.buttonText,
    Key? key,
    this.border,
    this.callback,
    this.buttonColor = Colors.transparent,
    this.style = const TextStyle(fontSize: 15),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            border: border,
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            buttonText,
            style: style,
          ),
        ),
      ),
    );
  }
}