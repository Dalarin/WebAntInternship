import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/widgets/custom_image.dart';
import 'package:webant_internship/ui/widgets/custom_textfield.dart';

class UploadImageScreen extends StatelessWidget {
  const UploadImageScreen({super.key});

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
                  CustomTextField(
                    hint: 'Name',
                    controller: TextEditingController(),
                  ),
                  CustomTextField(
                    hint: 'Name',
                    maxLines: 6,
                    controller: TextEditingController(),
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
