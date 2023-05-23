import 'package:flutter/material.dart';
import 'package:webant_internship/models/media.dart';

class ImageWidget extends StatelessWidget {
  final Media media;

  const ImageWidget({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://gallery.prod1.webant.ru/media/${media.image!.name}',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
