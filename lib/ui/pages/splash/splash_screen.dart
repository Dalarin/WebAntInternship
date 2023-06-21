import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webant_internship/di/di.dart';
import 'package:webant_internship/resources/resources.dart';

import 'bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(
        storage: injection(),
      )..add(SplashEvent()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state.status == SplashStatus.authorized) {
            } else if (state.status == SplashStatus.unauthorized) {}
          },
          child: SafeArea(
            child: Center(
              child: SvgPicture.asset(AppAssets.logo),
            ),
          ),
        ),
      ),
    );
  }
}
