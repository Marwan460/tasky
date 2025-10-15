import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/tasks_list.dart';

import '../core/services/preferences_manager.dart';
import '../core/utils/app_colors.dart';
import '../models/task_model.dart';

class ToDoTasks extends StatefulWidget {
  const ToDoTasks({super.key});

  @override
  State<ToDoTasks> createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> {
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
    await Future.delayed(const Duration(milliseconds: 500));
    final finalTask = PreferencesManager().getString('tasks');
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;

      setState(() {
        tasks = taskAfterDecode.map((e) => TaskModel.fromJson(e)).where((e) => e.isDone == false).toList();
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
        title: const Text('To Do Tasks'),
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

                },
              ),
      ),
    );
  }
}
