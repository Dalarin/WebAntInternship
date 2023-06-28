import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/helpers/helpers.dart';
import 'package:webant_internship/ui/navigation/app_router.dart';

import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';
import 'bloc/camera_bloc.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  void initState() {
    CameraHelper.initialize().then(
      (value) {
        setState(() {});
      },
    );

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (CameraHelper.initialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      CameraHelper.dispose();
    } else if (state == AppLifecycleState.resumed) {
      CameraHelper.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CameraBloc, CameraState>(
        listener: (context, state) {
          AppMessenger.of(context).showLoadingMenu();

          if (state.status == Status.success) {
            AppRouter.pushToUploadImage(context);
          }
        },
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Builder(
                builder: (context) {
                  if (CameraHelper.initialized) {
                    return SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CameraPreview(CameraHelper.controller!),
                    );
                  }
                  return const CustomLoader();
                },
              ),
              GestureDetector(
                onTap: () {
                  final bloc = context.read<CameraBloc>();

                  bloc.add(const CameraEvent.takePicture());
                },
                child: const Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 45,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 42,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 38,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
