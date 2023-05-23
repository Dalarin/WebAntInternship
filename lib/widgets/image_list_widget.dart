import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webant_internship/models/media.dart';

class ImageListWidget extends StatelessWidget {
  final Media media;

  const ImageListWidget({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (media.image == null) {
      return const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.redAccent,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        context.push(
          '/home/image/${media.id}',
          extra: media,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black,
          image: DecorationImage(
            image: NetworkImage(
              'https://gallery.prod1.webant.ru/media/${media.image!.name}',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
