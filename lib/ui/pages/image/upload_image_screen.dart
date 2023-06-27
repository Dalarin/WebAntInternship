import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';
import 'package:webant_internship/ui/pages/home/bloc/image_bloc.dart';
import 'package:webant_internship/ui/pages/image/bloc/media_info_bloc.dart';

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

  final List<String> _tags = [];

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    final size = context.screenSize;

    return WillPopScope(
      onWillPop: () async {
        AppRouter.popUntilHome(context);

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            AppMessenger.of(context).showLoadingMenu();

            if (state.status == Status.success) {
              final mediaBloc = context.read<MediaInfoBloc>();

              mediaBloc.add(
                MediaInfoEvent.createMediaInfo(
                  tags: _tags,
                  mediaId: state.media.first.id.toString(),
                ),
              );

              AppMessenger.of(context).showSnackBar(localization.fileUploaded);

              AppRouter.popUntilHome(context);
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: BlocBuilder<CameraBloc, CameraState>(
                builder: (context, state) {
                  if (state.status != Status.success) {
                    return const CustomLoader();
                  }

                  if (state.status == Status.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.file(
                          state.selectedPicture!,
                          width: double.infinity,
                          height: size.height * 0.3,
                          fit: BoxFit.cover,
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
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 15,
                                children: [
                                  ..._tags.map(
                                    (tag) {
                                      return Transform.scale(
                                        scale: 1.1,
                                        child: InputChip(
                                          onDeleted: () {
                                            _tags.remove(tag);
                                            setState(() {});
                                          },
                                          label: Text(tag),
                                          padding: EdgeInsets.zero,
                                          deleteIcon: const Icon(Icons.close),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  TextFieldChip(
                                    onSubmitted: (String text) {
                                      if (text.isNotEmpty) {
                                        _tags.add(text);
                                      }
                                    },
                                  ),
                                  Transform.scale(
                                    scale: 1.1,
                                    child: InputChip(
                                      onDeleted: () {},
                                      padding: EdgeInsets.zero,
                                      label: Text(localization.addTag),
                                      deleteIcon: const Icon(Icons.add),
                                      backgroundColor: Colors.transparent,
                                      deleteIconColor: AppColors.primaryColor,
                                      labelStyle: const TextStyle(
                                        color: AppColors.primaryColor,
                                      ),
                                      side: const BorderSide(
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              CustomButton(
                                buttonText: localization.upload,
                                buttonColor: Colors.black,
                                style: const TextStyle(color: Colors.white),
                                callback: () {
                                  final bloc = context.read<ImageBloc>();

                                  bloc.add(
                                    ImageEvent.uploadImage(
                                      file: state.selectedPicture!,
                                      title: _nameController.text,
                                      description: _descriptionController.text,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
