import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/ui/pages/authentication/login_screen.dart';
import 'package:webant_internship/ui/pages/home/home_screen.dart';
import 'package:webant_internship/ui/pages/profile/profile_screen.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold({super.key});

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  int _currentIndex = 0;

  List<Widget> children = [];

  @override
  void initState() {
    children.addAll(
      [
        const HomeScreen(),
        const LoginScreen(),
        const ProfileScreen(),
      ],
    );
    super.initState();
  }

  void _onTap(int index) {
    if (index != 1) {
      setState(() {
        _currentIndex = index;
      });

      return;
    }
    _showActionSheet();
  }

  void _showActionSheet() {
    final localization = context.localizations;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: Text(
              localization.pickFromGallery,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: Text(
              localization.makePhoto,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {},
          child: Text(localization.cancel),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            label: localization.feed,
            icon: const Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: localization.addPhoto,
            icon: const Icon(Icons.add_a_photo_outlined),
          ),
          BottomNavigationBarItem(
            label: localization.profile,
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: SafeArea(
        child: children[_currentIndex],
      ),
    );
  }
}
