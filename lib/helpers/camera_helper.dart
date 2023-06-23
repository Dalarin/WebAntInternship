import 'package:camera/camera.dart';

class CameraHelper {
  static CameraController? controller;

  static bool get initialized {
    return controller != null;
  }

  static void dispose() {
    controller!.dispose();
  }


  static Future<XFile> takePictures() {
    return controller!.takePicture();
  }


  static Future<void> initialize() async {
    final cameras = await availableCameras();

    controller = CameraController(cameras.first, ResolutionPreset.ultraHigh);

    await controller!.initialize();
  }
}
