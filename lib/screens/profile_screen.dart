import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_list_tile.dart';
import 'package:tasky/core/widgets/custom_switch.dart';
import 'package:tasky/screens/user_details_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';
import '../core/services/preferences_manager.dart';
import '../core/theme/theme_controller.dart';
import '../core/utils/app_colors.dart';
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
            child: CircularProgressIndicator(
              color: AppColors.green,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Center(
                  child: Column(
                    children: [
                      const CustomAvatar(),
                      const SizedBox(height: 6),
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        motivationQuote!,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Profile Info',
                  style: Theme.of(context).textTheme.bodyLarge,
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
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (context, value, child) {
                      return CustomSwitch(
                        value: ThemeController.themeNotifier.value ==
                            ThemeMode.dark,
                        onChanged: (value) {
                          ThemeController.toggleTheme();
                        },
                      );
                    },
                  ),
                ),
                const Divider(),
                CustomListTile(
                  onTap: () {
                    _showAlertDialog();
                  },
                  leading: AssetsRes.LOG_OUT_ICON,
                  title: 'Delete Account',
                ),
              ],
            ),
          );
  }


  _showAlertDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Delete Account'),
              content:
                  const Text('Are you sure you want to delete this account?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
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
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Delete'),
                ),
              ]);
        });
  }
}
