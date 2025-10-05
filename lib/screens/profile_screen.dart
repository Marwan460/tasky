import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_style.dart';
import '../core/widgets/custom_avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'My Profile',
            style: AppStyle.regular20,
          ),
        ),
        Center(
          child: CustomAvatar(),
        )
      ],
    );
  }
}
