import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/build_context_extension.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/widgets/custom_image.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.screenSize;
    final localization = context.localizations;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://img.freepik.com/free-photo/abstract-colorful-splash-3d-background-generative-ai-background_60438-2509.jpg',
              width: double.infinity,
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
                    'Get better - unused exploration',
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.titleColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Username',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Initial design explorations for a online health and wellness platform that unfortunately never made it into the product.'
                        ' Though this was unused work, Have been contemplating on creating a few more of them.',
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    '12 dec. 2020',
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
