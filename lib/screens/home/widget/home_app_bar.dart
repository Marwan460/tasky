import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'One task at a time.One step closer.',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ],
    );
  }
}
