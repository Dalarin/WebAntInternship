import 'package:flutter/material.dart';

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
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 12),
            hintText: 'Input label..',
            suffixIcon: Icon(
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
