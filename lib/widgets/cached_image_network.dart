import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/assets/index.dart';

class CachedImageNetworkWidget extends StatelessWidget {
  final String? imageUrl;

  const CachedImageNetworkWidget(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 60,
      width: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? 'https://picsum.photos/200/300',
          fit: BoxFit.cover,
          width: double.maxFinite,
          height: double.maxFinite,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Image.asset(
            LetTutorImages.avatar,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
