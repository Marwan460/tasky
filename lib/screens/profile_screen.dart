import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/core/widgets/custom_list_tile.dart';
import 'package:tasky/core/widgets/custom_switch.dart';
import 'package:tasky/screens/user_details_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';
import '../core/services/preferences_manager.dart';
import '../core/widgets/custom_avatar.dart';
import '../res/assets_res.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userName;
  String? motivationQuote;
  bool isLoading = true;
  bool isDarkMode = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    userName = PreferencesManager().getString('name') ?? '';
    motivationQuote = PreferencesManager().getString('motivation_quote') ??
        'One task at a time. One step closer.';
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
                      Text(
                        motivationQuote!,
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
                CustomListTile(
                  leading: AssetsRes.PROFILE,
                  title: 'User Details',
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(
                          userName: userName,
                          motivationQuote: motivationQuote ?? '',
                        ),
                      ),
                    );
                    if (result != null) {
                      _loadData();
                    }
                  },
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
                CustomListTile(
                  onTap: () async {
                    PreferencesManager().remove('name');
                    PreferencesManager().remove('motivation_quote');
                    PreferencesManager().remove('tasks');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const WelcomeScreen();
                      }),
                      (Route<dynamic> route) => false,
                    );
                  },
                  leading: AssetsRes.LOG_OUT_ICON,
                  title: 'Delete Account',
                ),
              ],
            ),
          );
  }
}
