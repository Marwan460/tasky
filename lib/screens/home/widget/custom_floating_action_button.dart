import 'package:flutter/material.dart';

import '../../add_task_screen.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';

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
        foregroundColor: AppColors.white2,
        label: const Text('Add New Task', style: AppStyle.medium14),
        icon: const Icon(Icons.add, size: 18),
      ),
    );
  }
}
