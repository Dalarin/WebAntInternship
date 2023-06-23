import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/widgets/custom_image.dart';

import '../../../models/media.dart';

class ImageScreen extends StatelessWidget {
  final Media media;

  const ImageScreen({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              media: media,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    media.name,
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.titleColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    media.user ?? 'User',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    media.image?.name ?? 'Media description',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    media.creationDate.toString(),
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.inactiveColor,
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Views: ',
                      children: [
                        TextSpan(
                          text: '999+',
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.inactiveColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
