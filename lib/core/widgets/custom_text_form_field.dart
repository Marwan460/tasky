import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String) onChanged;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final int? maxLines;
  const CustomTextFormField({super.key, required this.onChanged, this.validator, required this.controller, this.maxLines = 1, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
      ),
    );
  }
}
