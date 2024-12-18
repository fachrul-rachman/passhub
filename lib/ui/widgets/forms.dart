import 'package:flutter/material.dart';
import 'package:passhub/shared/themed.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final bool isPin;
  final Function(String)? onFieldSubmitted;
  const CustomFormField({
    super.key,
    required this.title,
    this.obscureText = false,
    this.controller,
    this.isShowTitle = true,
    this.keyboardType,
    this.isPin = false,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
          Text(
            title,
            style: blueTextStyle.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        if (isShowTitle)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          maxLength: isPin ? 6 : 200,
          decoration: InputDecoration(
            hintStyle: blueTextStyle.copyWith(
              fontSize: 14,
            ),
            hintText: !isShowTitle ? title : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: blueDarkColor),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }
}