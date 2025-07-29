import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final void Function(bool) onChanged;

  const CustomSwitch({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: AppColors.green,
    );
  }
}
