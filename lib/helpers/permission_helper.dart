import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestPermissions() async {
    await [Permission.camera, Permission.mediaLibrary].request();

    final cameraPermission = await Permission.camera.isGranted;
    final mediaLibraryPermission = await Permission.mediaLibrary.isGranted;

    return cameraPermission && mediaLibraryPermission;
  }
}
