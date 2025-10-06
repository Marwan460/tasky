import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/screens/home/widget/custom_floating_action_button.dart';
import 'package:tasky/core/widgets/tasks_list.dart';
import 'package:tasky/res/assets_res.dart';
import 'package:tasky/screens/home/widget/home_app_bar.dart';
import '../../core/utils/app_colors.dart';
import 'widget/achieved_tasks_widget.dart';
import '../../models/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  List<TaskModel> tasks = [];
  bool isLoading = false;
  int totalTasks = 0;
  int doneTasks = 0;
  int percent = 0;

  @override
  void initState() {
    super.initState();
    getUserName();
    loadTasks();
  }

  getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    setState(() {});
  }

  loadTasks() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    final prefs = await SharedPreferences.getInstance();
    final finalTask = prefs.getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;



      setState(() {
        tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).toList();
        _calculatePercentage();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _calculatePercentage() {
    totalTasks = tasks.length;
    doneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTasks == 0 ? 0 : (doneTasks / totalTasks * 100).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(loadTasks: loadTasks),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(name: name!),
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
            const SizedBox(height: 16),
            AchievedTasksWidget(doneTasks: doneTasks, totalTasks: totalTasks, percent: percent),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    )
                  : TasksList(
                      tasks: tasks,
                      onTap: (bool? value, int? index) async {
                        setState(() {
                          tasks[index!].isDone = value ?? false;
                          _calculatePercentage();
                        });
                        final pref = await SharedPreferences.getInstance();
                        final updateTask =
                            tasks.map((e) => e.toJson()).toList();
                        pref.setString('tasks', jsonEncode(updateTask));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

