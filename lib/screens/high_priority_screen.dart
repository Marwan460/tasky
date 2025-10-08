import 'dart:convert';

import 'package:flutter/material.dart';

import '../core/services/preferences_manager.dart';
import '../core/utils/app_colors.dart';
import '../core/widgets/tasks_list.dart';
import '../models/task_model.dart';

class HighPriorityScreen extends StatefulWidget {
  const HighPriorityScreen({super.key});

  @override
  State<HighPriorityScreen> createState() => _HighPriorityScreenState();
}

class _HighPriorityScreenState extends State<HighPriorityScreen> {
  List<TaskModel> highPriorityTasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  loadTasks() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        highPriorityTasks = taskAfterDecode
            .map((e) => TaskModel.fromJson(e))
            .where((e) => e.isHighPriority)
            .toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('High Priority Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: AppColors.white,
          ),
        )
            : TasksList(
          tasks: highPriorityTasks,
          onTap: (bool? value, int? index) async {
            setState(() {
              highPriorityTasks[index!].isDone = value ?? false;
            });
            final allData = PreferencesManager().getString('tasks');;
            if (allData != null) {
              List<TaskModel> allDataList = (jsonDecode(allData) as List)
                  .map((e) => TaskModel.fromJson(e))
                  .toList();
              final newIndex = allDataList.indexWhere((e) => e.taskID == highPriorityTasks[index!].taskID);
              allDataList[newIndex] = highPriorityTasks[index!];
              await PreferencesManager().setString('tasks', jsonEncode(allDataList));
            }
          },
        ),
      ),
    );
  }
}
