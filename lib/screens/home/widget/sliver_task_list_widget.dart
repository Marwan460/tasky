import 'package:flutter/material.dart';
import '../../../core/widgets/task_container.dart';
import '../../../models/task_model.dart';

class SliverTaskListWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;

  const SliverTaskListWidget(
      {super.key, required this.tasks, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ?  SliverToBoxAdapter(
          child: Center(
              child: Text(
                'No Tasks Yet',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
        )
        : SliverPadding(
      padding: const EdgeInsets.only(bottom: 80),
          sliver: SliverList.builder(
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
            ),
        );
  }
}
