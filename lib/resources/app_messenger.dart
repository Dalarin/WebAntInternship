import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/build_context_extension.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/widgets/custom_loader.dart';

class AppMessenger {
  final BuildContext context;

  AppMessenger.of(this.context);

  void showLoadingMenu() {
    final isLoadingMenu = ModalRoute.of(context)?.isCurrent != true;

    if (isLoadingMenu) {
      context.pop();

      return;
    }

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return const AlertDialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          content: CustomLoader(),
        );
      },
    );
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: AppColors.titleColor,
          content: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
              ),
            ],
          ),
        ),
      );
  }
}
