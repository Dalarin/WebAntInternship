import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/localizations_extension.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool required;
  final bool readOnly;
  final TextEditingController controller;
  final VoidCallback? callback;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.validator,
    this.callback,
    this.readOnly = false,
    this.required = true,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        readOnly: readOnly,
        onTap: callback,
        validator: (String? text) {
          if (!required) return null;
          validator?.call(text);
          if (text == null || text.isEmpty) {
            return context.localizations.fillField(hint);
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
