import 'package:flutter/material.dart';
import 'package:webant_internship/ui/pages/authentication/register_screen.dart';
import 'package:webant_internship/ui/pages/home/home_screen.dart';
import 'package:webant_internship/ui/pages/profile/edit_profile_screen.dart';

import '../pages/authentication/login_screen.dart';

class AppRouter {
  static Future<dynamic> pushToAuthentication(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      const LoginScreen(),
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

  static Future<dynamic> pushToHome(
    BuildContext context,
  ) async {
    return await _pushAndRemoveUntil(
      context,
      const HomeScreen(),
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
