import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/utils/app_style.dart';

import '../../res/assets_res.dart';
import '../utils/app_colors.dart';

class CustomListTile extends StatelessWidget {
  final String leading;
  final void Function()? onTap;
  final String title;
  final Widget? trailing;

  const CustomListTile({super.key, required this.leading, required this.title, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(leading, colorFilter: const ColorFilter.mode(AppColors.white2, BlendMode.srcIn),),
      title: Text(title, style: AppStyle.regular16,),
      trailing: trailing ?? SvgPicture.asset(AssetsRes.ARROW_ICON),
    );
  }
}


