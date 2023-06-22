import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(const CameraEvent.initialize()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: BlocBuilder<CameraBloc, CameraState>(
            builder: (context, state) {
              if (state.status == Status.success) {
                return Column(
                  children: [
                    CameraPreview(state.controller!),
                    const SizedBox(height: 15),
                    const CircleAvatar(
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
