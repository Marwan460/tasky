import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/res/assets_res.dart';
import 'package:tasky/screens/add_task.dart';

import '../core/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      floatingActionButton: buildFloatingActionButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
              ),
              const SizedBox(height: 16),
              Text(
                'Yuhuu ,Your work Is ',
                style: AppStyle.regular16.copyWith(fontSize: 32),
              ),
              Row(
                children: [
                  Text(
                    'almost done ! ',
                    style: AppStyle.regular16.copyWith(fontSize: 32),
                  ),
                  SvgPicture.asset(
                    AssetsRes.WAVING_HAND,
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFloatingActionButton() {
    return SizedBox(
      height: 40,
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  const AddTask(),
            ),
          );
        },
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white2,
        label: const Text('Add New Task', style: AppStyle.medium14),
        icon: const Icon(Icons.add, size: 18),
      ),
    );
  }
}
