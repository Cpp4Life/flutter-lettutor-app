import 'package:flutter/material.dart';

import '../core/styles/index.dart';

class BottomModalSheet {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required Widget widget,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return SafeArea(
          right: false,
          left: false,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: LetTutorColors.paleGrey,
                      ),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: LetTutorFontSizes.px14,
                          fontWeight: LetTutorFontWeights.medium,
                        ),
                      ),
                    ),
                    Expanded(
                      child: widget,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
