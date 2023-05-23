import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/logo.svg'),
              const SizedBox(
                height: 30,
              ),
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 60,
              ),
              ButtonWidget(
                buttonText: 'Create an account',
                buttonColor: Colors.black,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                callback: () {
                  context.push('/register');
                },
              ),
              ButtonWidget(
                buttonText: 'I already have an account',
                border: Border.all(color: Colors.black),
                callback: () {
                  context.push('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final BoxBorder? border;
  final TextStyle style;
  final VoidCallback? callback;

  const ButtonWidget({
    required this.buttonText,
    Key? key,
    this.border,
    this.callback,
    this.buttonColor = Colors.transparent,
    this.style = const TextStyle(fontSize: 15),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: callback,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            border: border,
            color: buttonColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            buttonText,
            style: style,
          ),
        ),
      ),
    );
  }
}
