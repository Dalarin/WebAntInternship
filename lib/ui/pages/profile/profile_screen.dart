import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';
import 'package:webant_internship/ui/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    final textTheme = context.textTheme;

    final size = context.screenSize;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(localization.profile),
        actions: [
          IconButton(
            onPressed: () {
              AppRouter.pushToEditProfile(context);
            },
            icon: const Icon(
              Icons.settings,
              color: AppColors.primaryColor,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: size.width * 0.13,
                    backgroundColor: AppColors.avatarColor,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: size.width * 0.13,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: textTheme.titleLarge,
                      ),
                      const Text(
                        '20.01.2000',
                        style: TextStyle(
                          color: AppColors.inactiveColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children:  [
                  Text.rich(
                    TextSpan(
                      text: localization.loaded,
                      children: const [
                        TextSpan(
                          text: ' 999+',
                          style: TextStyle(
                            color: AppColors.inactiveColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text.rich(
                    TextSpan(
                      text: localization.views,
                      children: const [
                        TextSpan(
                          text: ' 999+',
                          style: TextStyle(
                            color: AppColors.inactiveColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const ImageList(
                media: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
