import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import '../../res/assets_res.dart';

class CustomListTile extends StatelessWidget {
  final String leading;
  final void Function()? onTap;
  final String title;
  final Widget? trailing;

  const CustomListTile(
      {super.key,
      required this.leading,
      required this.title,
      this.trailing,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: CustomSvgPicture(assetName: leading),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: trailing ??
          const CustomSvgPicture(assetName: AssetsRes.ARROW_ICON),
    );
  }
}
