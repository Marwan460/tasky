import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              color: const Color(0xff282828),
            ),
            child: const Icon(
              Icons.camera_alt,
              color: AppColors.white,
              size: 26,
            ),
          ),
        )
      ],
    );
  }
}
