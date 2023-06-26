import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webant_internship/extensions/extensions.dart';

import '../../../helpers/helpers.dart';
import '../../../models/media.dart';
import '../../../models/user.dart';
import '../../../resources/resources.dart';
import '../../widgets/widgets.dart';
import '../user/bloc/user_bloc.dart';
import 'bloc/media_info_bloc.dart';

class ImageScreen extends StatelessWidget {
  final Media media;
  final User? user;

  const ImageScreen({
    super.key,
    required this.media,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return BlocBuilder<MediaInfoBloc, MediaInfoState>(
            builder: (context, mediaInfoState) {
              final mediaInfo = mediaInfoState.mediaInfo;

              if (mediaInfoState.status == Status.loading || state.status == Status.loading) {
                return const CustomLoader(radius: 30);
              }

              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CustomImage(
                          media: media,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              final bloc = context.read<MediaInfoBloc>();

                              bloc.add(
                                MediaInfoEvent.changeLike(
                                  userId: user!.id.toString(),
                                ),
                              );
                            },
                            icon: Icon(
                              mediaInfo?.likes.contains(user?.id.toString()) ?? false
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: 38,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            media.name,
                            style: textTheme.headlineMedium?.copyWith(
                              color: AppColors.titleColor,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            state.user?.userName ?? 'User',
                            style: textTheme.titleMedium?.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            media.description,
                            textAlign: TextAlign.justify,
                            style: textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            spacing: 10,
                            children: mediaInfo?.tags.map<Chip>(
                                  (tag) {
                                    return Chip(
                                      label: Text(tag),
                                      backgroundColor: AppColors.primaryColor,
                                    );
                                  },
                                ).toList() ??
                                [],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            DateConverterHelper.convertDate(media.creationDate),
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColors.inactiveColor,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Views: ',
                              children: [
                                TextSpan(
                                  text: '999+',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColors.inactiveColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
