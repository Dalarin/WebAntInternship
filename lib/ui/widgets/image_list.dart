import 'package:flutter/material.dart';
import 'package:webant_internship/ui/widgets/widgets.dart';

import '../../models/media.dart';

class ImageList extends StatelessWidget {
  final List<Media> media;
  const ImageList({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
      itemCount: media.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 1 / .7,
      ),
      itemBuilder: (BuildContext context, int index) {
        return CustomImage(media: media[index]);
      },
    );
  }
}
