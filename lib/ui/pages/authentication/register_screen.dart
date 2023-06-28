import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/extensions/field_enum_extension.dart';
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
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: _authorizationListener,
        builder: (context, state) {
          final values = state.fields;

          final keys = state.fields!.keys;

          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      hint: localization.usernameRequired,
                      controller: _usernameController,
                      showError: keys.contains(Fields.usernameField),
                      errorText: values?[Fields.usernameField]?.message(localization),
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
                      showError: keys.contains(Fields.emailField),
                      errorText: values?[Fields.emailField]?.message(localization),
                    ),
                    CustomTextField(
                      hint: localization.passwordRequired,
                      controller: _passwordController,
                      showError: keys.contains(Fields.passwordField),
                      errorText: values?[Fields.passwordField]?.message(localization),
                    ),
                    CustomTextField(
                      hint: localization.confirmPasswordRequired,
                      controller: _repeatPasswordController,
                      showError: keys.contains(Fields.repeatPasswordField),
                      errorText: values?[Fields.repeatPasswordField]?.message(localization),
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
                        final bloc = context.read<AuthenticationBloc>();

                        bloc.add(
                          AuthenticationEvent.register(
                            username: _usernameController.text,
                            email: _emailController.text,
                            birthDate: _selectedDate,
                            password: _passwordController.text,
                            repeatPassword: _repeatPasswordController.text,
                          ),
                        );
                      },
                    ),
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
    if (state.fields?.keys.isEmpty ?? true) {
      AppMessenger.of(context).showLoadingMenu();
    }

    if (state.status == Status.success) {
      AppRouter.pushToHome(context);
    }
    if (state.status == Status.failure && (state.fields?.keys.isEmpty ?? true)) {
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
