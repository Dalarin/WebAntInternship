import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';

import '../../resources/resources.dart';

class TextFieldChip extends StatefulWidget {
  final Function(String)? onSubmitted;

  const TextFieldChip({super.key, this.onSubmitted});

  @override
  State<TextFieldChip> createState() => _TextFieldChipState();
}

class _TextFieldChipState extends State<TextFieldChip> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

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
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 12),
            hintText: localization.inputLabelHint,
            suffixIcon: const Icon(
              Icons.close,
              color: AppColors.primaryColor,
            ),
            border: InputBorder.none,
          ),
          onSubmitted: (String value) {
            widget.onSubmitted?.call(value);

            _controller.clear();
          },
        ),
      ),
    );
  }
}
