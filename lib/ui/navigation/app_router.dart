import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/ui/pages/authentication/register_screen.dart';
import 'package:webant_internship/ui/pages/camera/bloc/camera_bloc.dart';
import 'package:webant_internship/ui/pages/camera/camera_screen.dart';
import 'package:webant_internship/ui/pages/image/image_screen.dart';
import 'package:webant_internship/ui/pages/image/upload_image_screen.dart';
import 'package:webant_internship/ui/pages/onboarding/onboarding_screen.dart';
import 'package:webant_internship/ui/widgets/custom_loader.dart';
import 'package:webant_internship/ui/widgets/custom_scaffold.dart';
import 'package:webant_internship/usecases/image_usecase.dart';
import 'package:webant_internship/usecases/user_usecase.dart';

import '../../di/di.dart';
import '../../models/media.dart';
import '../../resources/resources.dart';
import '../pages/authentication/login_screen.dart';
import '../pages/home/bloc/image_bloc.dart';
import '../pages/image/bloc/media_info_bloc.dart';
import '../pages/user/bloc/user_bloc.dart';
import '../pages/user/edit_profile_screen.dart';

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
      BlocBuilder<UserBloc, UserState>(
        bloc: context.read<UserBloc>(),
        builder: (_, state) {
          if (state.status == Status.success) {
            return BlocProvider.value(
              value: context.read<UserBloc>(),
              child: EditProfileScreen(user: state.user!),
            );
          }

          return const CustomLoader();
        },
      ),
    );
  }

  static Future<dynamic> pushToUploadImage(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<CameraBloc>(),
          ),
          BlocProvider.value(
            value: context.read<ImageBloc>(),
          ),
          BlocProvider(
            create: (context) {
              return MediaInfoBloc(
                imageUseCase: ImageUseCase(
                  repository: injection(),
                  sharedPreferencesRepository: injection(),
                  firebaseRepository: injection(),
                ),
              );
            },
          )
        ],
        child: const UploadImageScreen(),
      ),
    );
  }

  static Future<dynamic> pushToMediaScreen(
    BuildContext context, {
    required Media media,
  }) async {
    return await _pushToPage(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MediaInfoBloc(
              imageUseCase: ImageUseCase(
                repository: injection(),
                sharedPreferencesRepository: injection(),
                firebaseRepository: injection(),
              ),
            )..add(MediaInfoEvent.getMediaInfo(mediaId: media.id.toString())),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              useCase: UserUseCase(
                userRepository: injection(),
              ),
            )..add(UserEvent.getUserById(userId: media.user)),
          ),
        ],
        child: BlocBuilder<UserBloc, UserState>(
          bloc: context.read<UserBloc>(),
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const CustomLoader();
            }

            return ImageScreen(
              media: media,
              user: state.user,
            );
          },
        ),
      ),
    );
  }

  static Future<dynamic> pushToCamera(
    BuildContext context,
  ) async {
    return await _pushToPage(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: context.read<CameraBloc>(),
          ),
          BlocProvider.value(
            value: context.read<ImageBloc>(),
          ),
        ],
        child: const CameraScreen(),
      ),
    );
  }

  static Future<dynamic> pushToHome(
    BuildContext context,
  ) async {
    return await _pushAndRemoveUntil(
      context,
      MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) => UserBloc(
              useCase: UserUseCase(
                userRepository: injection(),
              ),
            )..add(const UserEvent.getCurrentUser()),
          ),
          BlocProvider(
            create: (_) => CameraBloc(),
          ),
          BlocProvider(
            create: (context) => ImageBloc(
              imagesUseCase: ImageUseCase(
                repository: injection(),
                sharedPreferencesRepository: injection(),
                firebaseRepository: injection(),
              ),
            )..add(const ImageEvent.getImages()),
          ),
        ],
        child: const CustomScaffold(),
      ),
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

  static Future<dynamic> popUntilHome(BuildContext context) async {
    Navigator.of(context).popUntil((route) => route.isFirst);
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
