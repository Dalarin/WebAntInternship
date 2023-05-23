import 'package:flutter/material.dart';
import 'package:webant_internship/screens/login_screen.dart';
import 'package:webant_internship/screens/splash_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create account'),
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
              children:  [
                TextFormFieldWidget(
                  hint: 'Username*',
                  controller: _usernameController,
                ),
                TextFormFieldWidget(
                  hint: 'Birthday',
                  controller: _birthDateController,
                ),
                TextFormFieldWidget(
                  hint: 'E-mail*',
                  controller: _emailController,
                ),
                TextFormFieldWidget(
                  hint: 'Password*',
                  controller: _passwordController,
                ),
                TextFormFieldWidget(
                  hint: 'Confirm password*',
                  controller: _repeatPasswordController,
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  buttonText: 'Create account',
                  buttonColor: Colors.black,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  callback: () {
                    final validate = _formKey.currentState?.validate();
                    if (validate == true) {

                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
