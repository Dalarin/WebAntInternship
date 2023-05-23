import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:webant_internship/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:webant_internship/blocs/image_bloc/image_bloc.dart';
import 'package:webant_internship/blocs/image_picker_bloc/image_picker_bloc.dart';
import 'package:webant_internship/utils/router.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => ImageBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, type) {
          return MaterialApp.router(
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: const Color(0xFFED5992),
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}
