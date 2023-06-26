import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/helpers/image_picker_helper.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';
import 'package:webant_internship/ui/pages/authentication/login_screen.dart';
import 'package:webant_internship/ui/pages/camera/bloc/camera_bloc.dart';
import 'package:webant_internship/ui/pages/home/home_screen.dart';

import '../pages/user/profile_screen.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({super.key});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _currentIndex = 0;

  List<Widget> children = [];

  @override
  void initState() {
    children.addAll(
      [
        const HomeScreen(),
        const LoginScreen(),
        const ProfileScreen(),
      ],
    );
    super.initState();
  }

  void _onTap(int index, BuildContext context) {
    if (index != 1) {
      setState(() {
        _currentIndex = index;
      });

      return;
    }
    _showActionSheet(context);
  }

  void _showActionSheet(BuildContext context) {
    final localization = context.localizations;

    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                final images = await ImagePickerHelper.showImagePicker(context);

                if (images != null) {
                  if (context.mounted) {
                    final bloc = context.read<CameraBloc>();

                    bloc.add(
                      CameraEvent.pickImages(
                        file: images.selectedFiles.first.selectedFile,
                      ),
                    );
                  }
                }
              },
              child: Text(
                localization.pickFromGallery,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                AppRouter.pushToCamera(context);
              },
              child: Text(
                localization.makePhoto,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              context.pop();
            },
            child: Text(localization.cancel),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    return Scaffold(
      bottomNavigationBar: BlocListener<CameraBloc, CameraState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            AppRouter.pushToUploadImage(context);
          }
        },
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) => _onTap(index, context),
          items: [
            BottomNavigationBarItem(
              label: localization.feed,
              icon: const Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: localization.addPhoto,
              icon: const Icon(Icons.add_a_photo_outlined),
            ),
            BottomNavigationBarItem(
              label: localization.profile,
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: children[_currentIndex],
      ),
    );
  }
}
