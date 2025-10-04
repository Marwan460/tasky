import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/res/assets_res.dart';
import 'package:tasky/screens/profile_screen.dart';
import 'package:tasky/screens/to_do_tasks_screen.dart';

import 'complete_task_screen.dart';
import 'home_screen.dart';

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
        backgroundColor: AppColors.primary,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: AppColors.green,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors.white,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsRes.HOME,
              colorFilter: ColorFilter.mode(
                  _currentIndex == 0 ? AppColors.green : AppColors.white,
                  BlendMode.srcIn),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsRes.TO_DO,
              colorFilter: ColorFilter.mode(
                  _currentIndex == 1 ? AppColors.green : AppColors.white,
                  BlendMode.srcIn),
            ),
            label: 'To DO',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsRes.COMPLETE,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 2 ? AppColors.green : AppColors.white,
                    BlendMode.srcIn),
              ),
              label: 'Completed'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetsRes.PROFILE,
                colorFilter: ColorFilter.mode(
                    _currentIndex == 3 ? AppColors.green : AppColors.white,
                    BlendMode.srcIn),
              ),
              label: 'Profile'),
        ],
      ),
      body: _screens[_currentIndex],
    );
  }
}
