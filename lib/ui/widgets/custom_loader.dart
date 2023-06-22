import 'package:flutter/cupertino.dart';
import 'package:webant_internship/extensions/extensions.dart';

class CustomLoader extends StatelessWidget {
  final double radius;
  const CustomLoader({super.key, this.radius = 15});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: radius,
        color: context.theme.colorScheme.primary,
      ),
    );
  }
}
