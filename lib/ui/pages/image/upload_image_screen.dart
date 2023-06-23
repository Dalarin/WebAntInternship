import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';

import '../../widgets/widgets.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

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
                    hint: localization.name,
                    controller: _nameController,
                  ),
                  CustomTextField(
                    hint: localization.description,
                    maxLines: 6,
                    controller: _descriptionController,
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
