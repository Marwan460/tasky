import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/task_container.dart';

import '../../models/task_model.dart';
import '../utils/app_style.dart';

class TasksList extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;

  const TasksList({super.key, required this.tasks, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? const Center(
            child: Text(
              'No Tasks Yet',
              style: AppStyle.regular24,
            ),
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.075),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskContainer(
                taskName: tasks[index].taskName,
                taskDescription: tasks[index].taskDescription,
                value: tasks[index].isDone,
                onChanged: (bool? value) {
                  onTap(value, index);
                },
              );
            },
          );
  }
}
