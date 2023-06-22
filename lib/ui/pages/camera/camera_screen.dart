import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/resources/app_enums.dart';

import 'bloc/camera_bloc.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
      ],
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(const CameraEvent.initialize()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<CameraBloc, CameraState>(
            builder: (context, state) {
              if (state.status == Status.success) {
                return Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CameraPreview(state.controller!),
                    ),
                    GestureDetector(
                      onTap: () {
                        state.controller!.takePicture();
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
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
