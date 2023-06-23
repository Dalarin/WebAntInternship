import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';

import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _usernameController = TextEditingController();
  final _birthDayController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    final textTheme = context.textTheme;

    final size = context.screenSize;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text(localization.accountSettings),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(localization.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
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
                          const SizedBox(height: 10),
                          Text(localization.tapToUpload)
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      hint: localization.usernameRequired,
                      controller: _usernameController,
                    ),
                    CustomTextField(
                      hint: localization.birthday,
                      controller: _birthDayController,
                    ),
                    CustomTextField(
                      hint: localization.emailRequired,
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      localization.changePassword,
                      style: textTheme.headlineMedium!.copyWith(
                        color: AppColors.titleColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CustomTextField(
                      hint: localization.oldPassword,
                      controller: _passwordController,
                    ),
                    CustomTextField(
                      hint: localization.newPassword,
                      controller: TextEditingController(),
                    ),
                    CustomTextField(
                      hint: localization.confirmNewPassword,
                      controller: TextEditingController(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        localization.signOut,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text.rich(
                      TextSpan(
                        text: localization.youCan,
                        children: [
                          TextSpan(
                            text: localization.deleteAccountConfirm.toLowerCase(),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _showConfirmDeleteProfile(context);
                              },
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmDeleteProfile(BuildContext context) {
    final localization = context.localizations;
    final textTheme = context.textTheme;

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                localization.deleteAccount,
                style: textTheme.headlineMedium!.copyWith(
                  color: AppColors.titleColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                localization.deleteAccountDescription,
                textAlign: TextAlign.center,
                style: textTheme.titleSmall!.copyWith(
                  color: AppColors.inactiveColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                callback: () {
                  Navigator.of(dialogContext).pop();
                },
                buttonText: localization.cancel,
                border: Border.all(color: Colors.black),
              ),
              CustomButton(
                buttonText: localization.deleteAccountConfirm,
                buttonColor: Colors.black,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
