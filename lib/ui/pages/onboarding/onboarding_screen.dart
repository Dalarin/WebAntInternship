import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webant_internship/extensions/build_context_extension.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';
import 'package:webant_internship/ui/pages/authentication/bloc/authentication_bloc.dart';
import 'package:webant_internship/ui/widgets/custom_button.dart';
import 'package:webant_internship/usecases/login_usecase.dart';
import 'package:webant_internship/usecases/register_usecase.dart';

import '../../../di/di.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppAssets.logo,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                context.localizations.welcome,
                style: context.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 60,
              ),
              CustomButton(
                buttonText: context.localizations.createAnAccount,
                buttonColor: Colors.black,
                style: context.textTheme.titleMedium!.apply(
                  color: Colors.white,
                ),
                callback: () {
                  AppRouter.pushToRegistration(context);
                },
              ),
              CustomButton(
                buttonText: context.localizations.iHaveAccount,
                border: Border.all(color: Colors.black),
                style: context.textTheme.titleMedium!,
                callback: () {
                  AppRouter.pushToAuthentication(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
