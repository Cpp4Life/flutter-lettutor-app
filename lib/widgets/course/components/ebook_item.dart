import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/assets/index.dart';
import '../../../core/styles/index.dart';

class EbookItemWidget extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String fileUrl;
  final String level;

  const EbookItemWidget({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.fileUrl,
    required this.level,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(Uri.parse(fileUrl))) {
          await launchUrl(Uri.parse(fileUrl));
        }
      },
      child: Card(
        elevation: 8,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Image.asset(
                  LetTutorImages.course,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: LetTutorFontSizes.px16,
                        fontWeight: LetTutorFontWeights.medium,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: LetTutorFontSizes.px12,
                          color: LetTutorColors.greyScaleDarkGrey,
                        ),
                      ),
                    ),
                    Text(
                      level,
                      style: const TextStyle(
                        fontSize: LetTutorFontSizes.px14,
                        color: LetTutorColors.greyScaleDarkGrey,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
