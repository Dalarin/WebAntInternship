import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';

import '../../widgets/widgets.dart';

class UploadImageScreen extends StatelessWidget {
  const UploadImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

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
            CustomButton(
              buttonText: localization.upload,
              buttonColor: Colors.black,
              style: const TextStyle(color: Colors.white),
              callback: () {},
            ),
          ],
        ),
      ),
    );
  }
}
