import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';

class CustomError extends StatelessWidget {
  final String message;

  const CustomError({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final localization = context.localizations;

    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            AppAssets.errorLogo,
            width: context.screenSize.width * 0.5,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            localization.errorMessage,
            style: textTheme.headlineSmall!.apply(
              color: AppColors.titleColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            message,
            style: textTheme.titleSmall!.apply(
              color: AppColors.inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
