import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';

import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';
import '../camera/bloc/camera_bloc.dart';

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
    final size = context.screenSize;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AppRouter.pushToHome(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<CameraBloc, CameraState>(
                builder: (context, state) {
                  if (state.status == Status.success) {
                    return Image.file(
                      state.selectedPicture!,
                      width: double.infinity,
                      height: size.height * 0.3,
                      fit: BoxFit.cover,
                    );
                  }
                  return const SizedBox.shrink();
                },
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
                    Wrap(
                      children: ['Map'].map<Chip>(
                        (tag) {
                          return Chip(
                            label: Text(tag),
                            backgroundColor: AppColors.primaryColor,
                          );
                        },
                      ).toList(),
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
            ],
          ),
        ),
      ),
    );
  }
}
