import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/core/widgets/tasks_list.dart';
import 'package:tasky/res/assets_res.dart';
import '../core/utils/app_colors.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  List<TaskModel> tasks = [];
  bool isLoading = false;

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
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          });
                          final pref = await SharedPreferences.getInstance();
                          final updateTask =
                              tasks.map((e) => e.toJson()).toList();
                          pref.setString('tasks', jsonEncode(updateTask));
                          loadTasks();
                        },
                      ),
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
        onPressed: () async {
          final bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );
          if (result != null && result) {
            loadTasks();
          }
        },
        backgroundColor: AppColors.green,
        foregroundColor: AppColors.white2,
        label: const Text('Add New Task', style: AppStyle.medium14),
        icon: const Icon(Icons.add, size: 18),
      ),
    );
  }
}
