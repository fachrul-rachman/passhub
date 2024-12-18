import 'package:flutter/material.dart';
import 'package:passhub/models/password_model.dart';
import 'package:passhub/shared/themed.dart';

class CustomFormFieldUpdate extends StatefulWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final bool isPin;
  final Function(String)? onFieldSubmitted;
  final bool onlyRead;

  const CustomFormFieldUpdate({
    super.key,
    required this.title,
    this.obscureText = false,
    this.controller,
    this.isShowTitle = true,
    this.keyboardType,
    this.isPin = false,
    this.onlyRead = false,
    this.onFieldSubmitted,
  });

  @override
  State<CustomFormFieldUpdate> createState() => _CustomFormFieldUpdateState();
}

class _CustomFormFieldUpdateState extends State<CustomFormFieldUpdate> {
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowTitle)
          Text(
            widget.title,
            style: blueTextStyle.copyWith(
              fontSize: 14,
              fontWeight: medium,
            ),
          ),
        if (widget.isShowTitle)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          readOnly: widget.onlyRead,
          obscureText: widget.isPin ? !_passwordVisible : widget.obscureText,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintStyle: blueTextStyle.copyWith(
              fontSize: 14,
            ),
            hintText: !widget.isShowTitle ? widget.title : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: blueDarkColor),
            ),
            contentPadding: const EdgeInsets.all(12),
            suffixIcon: widget.isPin
                ? IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: redColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : null,
          ),
          onFieldSubmitted: widget.onFieldSubmitted,
        ),
      ],
    );
  }
}
