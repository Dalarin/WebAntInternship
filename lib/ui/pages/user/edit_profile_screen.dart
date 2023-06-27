import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/helpers/date_converter_helper.dart';
import 'package:webant_internship/models/user.dart';
import 'package:webant_internship/ui/pages/user/bloc/user_bloc.dart';

import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;

  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _usernameController = TextEditingController();
  final _birthDayController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _passwordKey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController.text = widget.user.userName;
    _emailController.text = widget.user.email;
    _birthDayController.text = DateConverterHelper.convertDate(widget.user.birthDate);
    super.initState();
  }

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
            onPressed: () {
              final bloc = context.read<UserBloc>();

              if (_passwordController.text.isNotEmpty) {
                final validate = _passwordKey.currentState?.validate();

                if (validate == true) {
                  bloc.add(
                    UserEvent.changePassword(
                      oldPassword: _passwordController.text,
                      newPassword: _newPasswordController.text,
                      userId: widget.user.id,
                    ),
                  );
                }
              }

              final validate = _formKey.currentState?.validate();

              if (validate == true) {
                final user = widget.user.copyWith(
                  userName: _usernameController.text,
                  email: _emailController.text,
                );

                bloc.add(
                  UserEvent.updateUser(user: user),
                );
              }
            },
            child: Text(localization.save),
          ),
        ],
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          AppMessenger.of(context).showLoadingMenu();

          if (state.status == Status.success) {
            AppMessenger.of(context).showSnackBar(
              localization.dataUpdated,
            );

            context.pop();
          } else if (state.status == Status.failure) {
            AppMessenger.of(context).showSnackBar(
              localization.errorUpdate,
            );
          }
        },
        child: SafeArea(
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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hint: localization.usernameRequired,
                              controller: _usernameController,
                            ),
                            CustomTextField(
                              readOnly: true,
                              required: false,
                              hint: localization.birthday,
                              controller: _birthDayController,
                            ),
                            CustomTextField(
                              hint: localization.emailRequired,
                              controller: _emailController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        localization.changePassword,
                        style: textTheme.headlineSmall!.copyWith(
                          color: AppColors.titleColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Form(
                        key: _passwordKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              hint: localization.oldPassword,
                              controller: _passwordController,
                            ),
                            CustomTextField(
                              validator: _validatePasswordIdentity,
                              hint: localization.newPassword,
                              controller: _newPasswordController,
                            ),
                            CustomTextField(
                              validator: _validatePasswordIdentity,
                              hint: localization.confirmNewPassword,
                              controller: _confirmPasswordController,
                            ),
                          ],
                        ),
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
      ),
    );
  }

  String? _validatePasswordIdentity(String? value) {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      return context.localizations.passwordMissmatch;
    }
    return null;
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
