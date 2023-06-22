import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';
import 'package:webant_internship/ui/pages/authentication/bloc/authentication_bloc.dart';

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
      body: SafeArea(
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
                ),
                CustomTextField(
                  hint: localization.password,
                  controller: _passwordController,
                ),
                CustomButton(
                  callback: () {
                    final validate = _formKey.currentState?.validate();

                    if (validate == true) {
                      final bloc = context.read<AuthenticationBloc>();

                      bloc.add(
                        AuthenticationEvent.authenticate(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    }
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
      ),
    );
  }
}
