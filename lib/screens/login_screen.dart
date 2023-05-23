import 'package:flutter/material.dart';
import 'package:webant_internship/screens/splash_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 30,
          ),
          child: Column(
            children: [
              TextFormFieldWidget(
                hint: 'Email',
                controller: _emailController,
              ),
              TextFormFieldWidget(
                hint: 'Password',
                controller: _passwordController,
              ),
              const ButtonWidget(
                buttonText: 'Log In',
                buttonColor: Colors.black,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              TextButton(
                child: const Text('Create account'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFormFieldWidget extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const TextFormFieldWidget({
    Key? key,
    this.validator,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        validator: (String? text) {
          validator?.call(text);
          if (text == null || text.isEmpty) {
            return 'Заполните поле $hint';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
