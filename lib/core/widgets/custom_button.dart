import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_style.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final double? width;
  final Widget? icon;
  final void Function() onPressed;

  const CustomButton(
      {super.key, required this.onPressed, required this.title, this.width, this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        side: BorderSide.none,
        fixedSize: Size(width ?? MediaQuery.of(context).size.width, 40),
      ),
      onPressed: onPressed,
      label: Text(
        title,
        style: AppStyle.medium14,
      ),
      icon: icon ?? const SizedBox(),
    );
  }
}
