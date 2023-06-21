import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/ui/pages/authentication/bloc/authentication_bloc.dart';
import 'package:webant_internship/ui/pages/authentication/register_screen.dart';

import '../../di/di.dart';
import '../../usecases/login_usecase.dart';
import '../../usecases/register_usecase.dart';
import '../pages/authentication/login_screen.dart';

class AppRouter {
  static Future<dynamic> pushToAuthentication(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      BlocProvider(
        create: (context) => AuthenticationBloc(
          loginUseCase: LoginUseCase(
            repository: injection(),
            securedStorage: injection(),
          ),
          registerUseCase: RegisterUseCase(
            repository: injection(),
            securedStorage: injection(),
          ),
        ),
        child: const LoginScreen(),
      ),
    );
  }

  static Future<dynamic> pushToRegistration(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      BlocProvider(
        create: (context) => AuthenticationBloc(
          loginUseCase: LoginUseCase(
            repository: injection(),
            securedStorage: injection(),
          ),
          registerUseCase: RegisterUseCase(
            repository: injection(),
            securedStorage: injection(),
          ),
        ),
        child: const RegisterScreen(),
      ),
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
