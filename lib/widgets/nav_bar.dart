import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  final Widget child;
  final String location;

  const ScaffoldWithNavBar({
    Key? key,
    required this.child,
    required this.location,
  }) : super(key: key);

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _resolveCurrentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Add Photo',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  int _resolveCurrentIndex(int value) {
    if (value == 1) {
      _showImagePickerDialog();
    }

    if (widget.location == '/home') {
      return 0;
    } else if (widget.location == '/profile') {
      return 2;
    } else if (value == 1) {}
    return 0;
  }

  void _showImagePickerDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Выбор источника изображения'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () => _resolveImageSource(ImageSource.camera),
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Камера'),
              ),
              ListTile(
                onTap: () => _resolveImageSource(ImageSource.gallery),
                leading: const Icon(Icons.image),
                title: const Text('Галерея'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _resolveImageSource(ImageSource source) {

  }

}
