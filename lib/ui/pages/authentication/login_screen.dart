import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/extensions/field_enum_extension.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';
import 'package:webant_internship/ui/pages/authentication/bloc/authentication_bloc.dart';

import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.logIn),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: _authorizationListener,
        builder: (context, state) {
          final values = state.fields;

          final keys = state.fields!.keys;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 30,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hint: localization.email,
                      controller: _emailController,
                      showError: keys.contains(Fields.emailField),
                      errorText: values?[Fields.emailField]?.message(localization),
                    ),
                    CustomTextField(
                      hint: localization.password,
                      controller: _passwordController,
                      showError: keys.contains(Fields.passwordField),
                      errorText: values?[Fields.passwordField]?.message(localization),
                    ),
                    CustomButton(
                      callback: () {
                        // final validate = _formKey.currentState?.validate();

                        // if (validate == true) {
                        final bloc = context.read<AuthenticationBloc>();

                        bloc.add(
                          AuthenticationEvent.authenticate(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                        // }
                      },
                      buttonText: localization.logIn,
                      buttonColor: Colors.black,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      child: Text(localization.createAnAccount),
                      onPressed: () {
                        AppRouter.pushToRegistration(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _authorizationListener(BuildContext context, AuthenticationState state) {
    AppMessenger.of(context).showLoadingMenu();

    if (state.status == Status.success) {
      AppRouter.pushToHome(context);
    }
    if (state.status == Status.failure && (state.fields?.isEmpty ?? true)) {
      AppMessenger.of(context).showSnackBar(
        state.errorEnum.message(context.localizations),
      );
    }
  }
}
