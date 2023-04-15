import 'package:flutter/material.dart';

import '../core/styles/index.dart';

class SearchBarWidget extends StatelessWidget {
  final String title;

  const SearchBarWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: const Icon(Icons.search),
          prefixIconConstraints: const BoxConstraints(minWidth: 36),
          hintText: title,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          filled: true,
          fillColor: LetTutorColors.greyScaleLightGrey,
        ),
        textAlignVertical: TextAlignVertical.bottom,
        style: const TextStyle(
          fontSize: LetTutorFontSizes.px12,
        ),
      ),
    );
  }
}
