import 'package:flutter/material.dart';

import '../../resources/resources.dart';

class TextFieldChip extends StatelessWidget {
  const TextFieldChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IntrinsicWidth(
        child: TextField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 12),
            hintText: 'Input label..',
            suffixIcon: Icon(
              Icons.close,
              color: AppColors.primaryColor,
            ),
            border: InputBorder.none,
          ),
          onSubmitted: (String? text) {
            if (text != null && text.isNotEmpty) {}
          },
        ),
      ),
    );
  }
}
