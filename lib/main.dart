import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/di/di.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/pages/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:webant_internship/ui/widgets/custom_scaffold.dart';
import 'package:webant_internship/usecases/login_usecase.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            loginUseCase: LoginUseCase(
              repository: injection(),
              securedStorage: injection(),
            ),
          )..add(const AuthenticationEvent.started()),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const CustomScaffold(),
      ),
    );
  }
}
