import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/models/media.dart';
import 'package:webant_internship/resources/resources.dart';

import 'widgets.dart';

class CustomImage extends StatelessWidget {
  final Media media;

  const CustomImage({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.screenSize.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.inactiveColor,
      ),
      child: Image.network(
        '${AppConst.mediaUrl}/${media.image?.name}',
        fit: BoxFit.cover,
        loadingBuilder: (context, widget, progress) {
          if (progress == null) return widget;
          return const CustomLoader();
        },
        errorBuilder: (context, _, __) {
          return const Icon(
            Icons.error_outline_outlined,
            color: AppColors.errorColor,
          );
        },
      ),
    );
  }
}