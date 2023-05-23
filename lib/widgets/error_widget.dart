import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webant_internship/utils/constants.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset('assets/no_connection.svg'),
          const SizedBox(height: 35),
          const Text(
            'Oh shucks!',
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          const Text(
            'Slow or no internet connection.\nPlease check your internet settings',
            style: TextStyle(
              color: Color(0xFF8C8C8C),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
