import 'package:flutter/material.dart';
import 'package:webant_internship/di/di.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/pages/onboarding/onboarding_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setDi();

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const OnBoardingScreen(),
    );
  }
}
