import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../theme/theme_controller.dart';
import '../utils/app_colors.dart';

class CustomSvgPicture extends StatelessWidget {
  final String assetName;
  final int? currentIndex;
  final bool withColorFilter;
  final double? width, height;

  const CustomSvgPicture(
      {super.key,
      required this.assetName,
      this.currentIndex,
      this.withColorFilter = true, this.width, this.height});

  const CustomSvgPicture.withColorFilter(
      {super.key,
      required this.assetName,
      this.currentIndex, this.width, this.height,
      }) : withColorFilter = false;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              ThemeController.isDark() ? AppColors.grey2 : AppColors.black2,
              BlendMode.srcIn)
          : null,
    );
  }
}
