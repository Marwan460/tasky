import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool? value;
  final void Function(bool? p1)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
