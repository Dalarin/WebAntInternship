import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webant_internship/blocs/users_bloc/users_bloc.dart';
import 'package:webant_internship/models/media.dart';
import 'package:webant_internship/utils/constants.dart';
import 'package:webant_internship/utils/enums.dart';
import 'package:webant_internship/widgets/image_widget.dart';

class ImageScreen extends StatefulWidget {
  final Media media;

  const ImageScreen({Key? key, required this.media}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    if (widget.media.user != null) {
      context.read<UsersBloc>().add(GetUserById(widget.media.user!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == Status.success) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    leading: IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: ImageWidget(media: widget.media),
                    ),
                  ),
                  SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.media.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor,
                            ),
                          ),
                          Text(
                            state.user.first.email ?? 'Отсутствует пользователь',
                            style: const TextStyle(
                              fontSize: 15,
                              color: kAccentColor,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            widget.media.description,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
