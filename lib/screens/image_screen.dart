import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webant_internship/models/media.dart';
import 'package:webant_internship/utils/constants.dart';
import 'package:webant_internship/widgets/image_widget.dart';

class ImageScreen extends StatelessWidget {
  final Media media;

  const ImageScreen({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
                background: ImageWidget(media: media),
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
                      media.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: kPrimaryColor,
                      ),
                    ),
                    Text(
                      media.user ?? 'Отсутствует пользователь',
                      style: const TextStyle(
                        fontSize: 15,
                        color: kAccentColor,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      media.description,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

