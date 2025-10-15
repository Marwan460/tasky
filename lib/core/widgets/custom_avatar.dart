import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';

import '../../res/assets_res.dart';
import '../utils/app_colors.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: SvgPicture.asset(
              AssetsRes.AVATAR,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: ThemeController.isDark() ? const Color(0xff282828) : AppColors.white2,
              border: Border.all(
                color: ThemeController.isDark() ? Colors.transparent : const Color(0xffD1DAD6),
              )
            ),
            child:  Icon(
              Icons.camera_alt_outlined,
              color: Theme.of(context).iconTheme.color,
              size: 26,
            ),
          ),
        )
      ],
    );
  }
}
