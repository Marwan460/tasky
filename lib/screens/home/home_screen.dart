import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/screens/home/widget/custom_floating_action_button.dart';
import 'package:tasky/res/assets_res.dart';
import 'package:tasky/screens/home/widget/high_priority_tasks_widget.dart';
import 'package:tasky/screens/home/widget/home_app_bar.dart';
import 'package:tasky/screens/home/widget/sliver_task_list_widget.dart';
import '../../core/utils/app_colors.dart';
import '../high_priority_screen.dart';
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
    PreferencesManager().getString('name');
    setState(() {});
  }

  loadTasks() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    final finalTask = PreferencesManager().getString('tasks');
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

  _doneTask(bool? value, int? index) async {
    setState(() {
      tasks[index!].isDone = value ?? false;
      _calculatePercentage();
    });
    final updateTask = tasks.map((e) => e.toJson()).toList();
    await PreferencesManager().setString('tasks', jsonEncode(updateTask));
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeAppBar(name: name ?? ''),
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
                  AchievedTasksWidget(
                      doneTasks: doneTasks, totalTasks: totalTasks, percent: percent),
                  const SizedBox(height: 8),
                  HighPriorityTasksWidget(
                    tasks: tasks,
                    onChanged: (bool? value, int? index) {
                      _doneTask(value, index);
                    },
                    onTap: () async{
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HighPriorityScreen(),
                        ),
                      );
                      loadTasks();
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'My Tasks',
                    style: AppStyle.regular20,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            isLoading
                ? const SliverToBoxAdapter(
                  child: Center(
                                child: CircularProgressIndicator(
                  color: AppColors.white,
                                ),
                              ),
                )
                : SliverTaskListWidget(
              tasks: tasks,
              onTap: (bool? value, int? index) {
                _doneTask(value, index);
              },
            )
          ],
        )

      ),
    );
  }
}
