import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/di/di.dart';
import 'package:webant_internship/extensions/extensions.dart';
import 'package:webant_internship/resources/resources.dart';
import 'package:webant_internship/ui/widgets/widgets.dart';
import 'package:webant_internship/usecases/image_usecase.dart';

import '../home/bloc/image_bloc.dart';
import 'bloc/user_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localizations;
    final textTheme = context.textTheme;

    final size = context.screenSize;

    return BlocProvider(
      create: (context) => ImageBloc(
        imagesUseCase: ImageUseCase(
          sharedPreferencesRepository: injection(),
          firebaseRepository: injection(),
          repository: injection(),
        ),
      )..add(const ImageEvent.getImagesForCurrentUser()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(localization.profile),
            actions: [
              IconButton(
                onPressed: () {
                  // AppRouter.pushToEditProfile(context);
                },
                icon: const Icon(
                  Icons.settings,
                  color: AppColors.primaryColor,
                ),
              )
            ],
          ),
          body: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const CustomLoader();
              }
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: size.width * 0.13,
                            backgroundColor: AppColors.avatarColor,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: size.width * 0.13,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user!.userName,
                                style: textTheme.titleLarge,
                              ),
                              Text(
                                state.user!.birthDate.toString(),
                                style: const TextStyle(
                                  color: AppColors.inactiveColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BlocBuilder<ImageBloc, ImageState>(
                      builder: (context, state) {
                        return ImageList(
                          media: state.media,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
