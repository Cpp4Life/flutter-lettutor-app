import 'package:flutter/material.dart';

import '../core/styles/styles.dart';

class TextFieldWidget extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final bool obscureText;

  const TextFieldWidget({
    this.label,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText ?? '',
          hintStyle: const TextStyle(
            color: LetTutorColors.greyScaleMediumGrey,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: LetTutorColors.greyScaleMediumGrey, width: 0.4),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        style: const TextStyle(fontSize: LetTutorFontSizes.px14),
      ),
    );
  }
}
