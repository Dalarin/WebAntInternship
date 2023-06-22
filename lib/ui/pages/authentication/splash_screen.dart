import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';
import 'package:webant_internship/ui/pages/authentication/bloc/authentication_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            AppRouter.pushToHome(context);
          } else if (state.status == Status.initial) {
            AppRouter.pushToAuthentication(context);
          } else if (state.status == Status.failure) {
            AppRouter.pushToAuthentication(context);
          }
        },
        child: SafeArea(
          child: Center(
            child: SvgPicture.asset(
              AppAssets.logo,
            ),
          ),
        ),
      ),
    );
  }
}
