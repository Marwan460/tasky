import 'package:flutter/material.dart';

import '../../add_task_screen.dart';
import '../../../core/utils/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function loadTasks;

  const CustomFloatingActionButton({super.key, required this.loadTasks});

  @override
  Widget build(BuildContext context) {
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
        foregroundColor: AppColors.white,
        label: Text(
          'Add New Task',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: AppColors.white),
        ),
        icon: const Icon(Icons.add, size: 18),
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      ),
    );
  }
}
