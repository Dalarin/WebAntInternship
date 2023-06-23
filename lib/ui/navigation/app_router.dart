import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/ui/pages/authentication/register_screen.dart';
import 'package:webant_internship/ui/pages/camera/bloc/camera_bloc.dart';
import 'package:webant_internship/ui/pages/camera/camera_screen.dart';
import 'package:webant_internship/ui/pages/image/upload_image_screen.dart';
import 'package:webant_internship/ui/pages/onboarding/onboarding_screen.dart';
import 'package:webant_internship/ui/pages/profile/edit_profile_screen.dart';
import 'package:webant_internship/ui/widgets/custom_scaffold.dart';

import '../pages/authentication/login_screen.dart';

class AppRouter {
  static Future<dynamic> pushToAuthentication(
    BuildContext context,
  ) async {
    return await _pushAndRemoveUntil(
      context,
      const LoginScreen(),
    );
  }

  static Future<dynamic> pushToOnBoarding(
    BuildContext context,
  ) async {
    return await _pushAndRemoveUntil(
      context,
      const OnBoardingScreen(),
    );
  }

  static Future<dynamic> pushToEditProfile(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      const EditProfileScreen(),
    );
  }

  static Future<dynamic> pushToUploadImage(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      BlocProvider.value(
        value: context.read<CameraBloc>(),
        child: const UploadImageScreen(),
      ),
    );
  }

  static Future<dynamic> pushToCamera(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      BlocProvider.value(
        value: context.read<CameraBloc>(),
        child: const CameraScreen(),
      ),
    );
  }

  static Future<dynamic> pushToHome(
    BuildContext context,
  ) async {
    return await _pushAndRemoveUntil(
      context,
      const CustomScaffold(),
    );
  }

  static Future<dynamic> pushToRegistration(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      const RegisterScreen(),
    );
  }

  static Future<dynamic> _pushAndRemoveUntil(
    BuildContext context,
    Widget page, {
    bool rootNavigator = false,
    RouteSettings? routeSettings,
  }) async {
    return await Navigator.of(context, rootNavigator: rootNavigator).pushAndRemoveUntil(
      MaterialPageRoute<dynamic>(
        builder: (context) => page,
        settings: routeSettings,
      ),
      (_) => false,
    );
  }

  static Future<dynamic> _pushToPage(
    BuildContext context,
    Widget page, {
    bool closeTabs = false,
    RouteSettings? routeSettings,
  }) async {
    return await Navigator.of(context, rootNavigator: closeTabs).push(
      MaterialPageRoute<dynamic>(
        builder: (context) => page,
        settings: routeSettings,
      ),
    );
  }
}
