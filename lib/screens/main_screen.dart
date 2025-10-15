import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/res/assets_res.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/to_do_tasks_screen.dart';

import 'complete_task_screen.dart';
import 'home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const ToDoTasks(),
    const CompleteTaskScreen(),
    const ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgPicture(AssetsRes.HOME, 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture(AssetsRes.TO_DO, 1),
            label: 'To DO',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture(AssetsRes.COMPLETE, 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgPicture(AssetsRes.PROFILE, 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: _screens[_currentIndex]),
    );
  }

  SvgPicture _buildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index
            ? AppColors.green
            : ThemeController.isDark()
                ? AppColors.grey2
                : AppColors.black2,
        BlendMode.srcIn,
      ),
    );
  }
}
