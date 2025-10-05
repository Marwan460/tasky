import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/core/widgets/custom_list_tile.dart';
import 'package:tasky/core/widgets/custom_switch.dart';
import '../core/widgets/custom_avatar.dart';
import '../res/assets_res.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final String userName;
  bool isLoading = true;
  bool isDarkMode = true;

  @override
  void initState() {
    super.initState();
    loadUserName();
  }

  loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('name') ?? '';
    setState(() {});
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Profile',
                  style: AppStyle.regular20,
                ),
                Center(
                  child: Column(
                    children: [
                      const CustomAvatar(),
                      const SizedBox(height: 6),
                      Text(
                        userName,
                        style: AppStyle.regular20,
                      ),
                      const Text(
                        'One task at a time. One step closer.',
                        style: AppStyle.regular14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Profile Info',
                  style: AppStyle.regular20,
                ),
                const SizedBox(height: 16),
                const CustomListTile(
                  leading: AssetsRes.PROFILE,
                  title: 'User Details',
                ),
                const Divider(),
                CustomListTile(
                  leading: AssetsRes.DARK_ICON,
                  title: 'Dark Mode',
                  trailing: CustomSwitch(
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
                        });
                      }),
                ),
                const Divider(),
                const CustomListTile(
                  leading: AssetsRes.LOG_OUT_ICON,
                  title: 'Log Out',
                ),
              ],
            ),
          );
  }
}
