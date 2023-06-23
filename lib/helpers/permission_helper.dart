import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCameraPermission() async {
    await Permission.camera.request();

    return await Permission.camera.isGranted;
  }

  static Future<bool> requestMediaPermission() async {
    await Permission.mediaLibrary.request();

    return await Permission.mediaLibrary.isGranted;
  }
}
