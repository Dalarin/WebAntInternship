import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/localizations_extension.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool required;
  final bool readOnly;
  final int maxLines;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final VoidCallback? callback;
  final Function(String?)? onChange;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.validator,
    this.callback,
    this.onChange,
    this.suffixIcon,
    this.readOnly = false,
    this.required = true,
    this.maxLines = 1,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: callback,
        onChanged: onChange,
        validator: (String? text) {
          if (!required) return null;

          if (text == null || text.isEmpty) {
            return context.localizations.fillField(hint);
          }
          return validator?.call(text);
        },
        controller: controller,
        decoration: InputDecoration(
          label: Text(hint),
          suffixIcon: suffixIcon,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
