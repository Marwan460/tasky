import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/app_style.dart';
import '../../../res/assets_res.dart';

class HomeAppBar extends StatelessWidget {
  final String name;
  const HomeAppBar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AssetsRes.AVATAR,
          width: 42,
          height: 42,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $name',
              style: AppStyle.regular16,
            ),
            Text(
              'One task at a time.One step closer.',
              style: AppStyle.regular16.copyWith(
                fontSize: 14,
                color: const Color(0xffC6C6C6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
