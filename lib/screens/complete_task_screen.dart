import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/widgets/tasks_list.dart';

import '../core/services/preferences_manager.dart';
import '../models/task_model.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  List<TaskModel> tasks = [];
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
    await Future.delayed(const Duration(milliseconds: 300));
    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).where((e) => e.isDone == true).toList();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _deleteTask(int id) {
    setState(() {
      tasks.removeWhere((e) => e.taskID == id);
    });
    final updateTask = tasks.map((e) => e.toJson()).toList();
    PreferencesManager().setString('tasks', jsonEncode(updateTask));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.green,
                ),
              )
            : TasksList(
                tasks: tasks,
                onTap: (bool? value, int? index) async {
                  setState(() {
                    tasks[index!].isDone = value ?? false;
                  });
                  final allData = PreferencesManager().getString('tasks');
                  if (allData != null) {
                    List<TaskModel> allDataList = (jsonDecode(allData) as List)
                        .map((e) => TaskModel.fromJson(e))
                        .toList();
                    final newIndex = allDataList.indexWhere((e) => e.taskID == tasks[index!].taskID);
                    allDataList[newIndex] = tasks[index!];
                    await PreferencesManager().setString('tasks', jsonEncode(allDataList));
                    loadTasks();
                  }
                }, onDelete: (int id) {
                  _deleteTask(id);
        },
              ),
      ),
    );
  }
}
