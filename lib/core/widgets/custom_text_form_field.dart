import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_style.dart';

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
      style: AppStyle.regular16,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyle.regular16.copyWith(color: AppColors.grey),
        filled: true,
        fillColor: const Color(0xff282828),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none
        ),
      ),
      cursorColor: AppColors.white,
    );
  }
}
