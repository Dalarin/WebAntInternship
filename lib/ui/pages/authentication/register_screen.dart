import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/helpers/date_converter_helper.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';
import 'package:webant_internship/ui/pages/authentication/bloc/authentication_bloc.dart';

import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.createAccount),
        centerTitle: true,
      ),
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: _authorizationListener,
        child: SingleChildScrollView(
          child: SafeArea(
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
                      hint: localization.usernameRequired,
                      controller: _usernameController,
                    ),
                    CustomTextField(
                      readOnly: true,
                      required: false,
                      callback: _showDatePicker,
                      hint: localization.birthday,
                      controller: _birthDateController,
                    ),
                    CustomTextField(
                      hint: localization.emailRequired,
                      controller: _emailController,
                    ),
                    CustomTextField(
                      validator: _validatePasswordIdentity,
                      hint: localization.passwordRequired,
                      controller: _passwordController,
                    ),
                    CustomTextField(
                      validator: _validatePasswordIdentity,
                      hint: localization.confirmPasswordRequired,
                      controller: _repeatPasswordController,
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      buttonText: localization.createAccount,
                      buttonColor: Colors.black,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      callback: () {
                        final validate = _formKey.currentState?.validate();
                        if (validate == true) {
                          final bloc = context.read<AuthenticationBloc>();

                          bloc.add(
                            AuthenticationEvent.register(
                              username: _usernameController.text,
                              email: _emailController.text,
                              birthDate: _selectedDate,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? _validatePasswordIdentity(String? value) {
    if (_passwordController.text != _repeatPasswordController.text) {
      return context.localizations.passwordMissmatch;
    }
    return null;
  }

  void _authorizationListener(BuildContext context, AuthenticationState state) {
    AppMessenger.of(context).showLoadingMenu();

    if (state.status == Status.success) {
      AppRouter.pushToHome(context);
    }
    if (state.status == Status.failure) {
      AppMessenger.of(context).showSnackBar(
        state.errorEnum.message(context.localizations),
      );
    }
  }

  void _showDatePicker() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(1900),
      lastDate: DateTime(2020),
    );

    if (date != null) {
      _selectedDate = date;
      _birthDateController.text = DateConverterHelper.convertDate(_selectedDate!);
    }
  }
}
