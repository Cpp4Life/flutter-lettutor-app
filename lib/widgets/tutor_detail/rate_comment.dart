import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/styles/index.dart';
import '../../models/index.dart' as model;
import '../index.dart';

class RateCommentWidget extends StatelessWidget {
  final model.Feedback feedback;

  const RateCommentWidget(this.feedback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedImageNetworkWidget(feedback.firstInfo?.avatar),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            feedback.firstInfo!.name as String,
                            style: const TextStyle(
                              fontSize: LetTutorFontSizes.px14,
                              fontWeight: LetTutorFontWeights.medium,
                            ),
                          ),
                          RatingWidget(count: feedback.rating!)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  feedback.content!.isEmpty ? 'Very good' : feedback.content!,
                  style: const TextStyle(
                    fontSize: LetTutorFontSizes.px14,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat('E, dd-MM-yyyy').format(feedback.createdAt!),
                  style: const TextStyle(color: LetTutorColors.greyScaleDarkGrey),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
