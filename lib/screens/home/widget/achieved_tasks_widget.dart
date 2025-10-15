import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/core/theme/theme_controller.dart';

import '../../../core/utils/app_colors.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({
    super.key,
    required this.doneTasks,
    required this.totalTasks,
    required this.percent,
  });

  final int doneTasks;
  final int totalTasks;
  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ThemeController.isDark() ? Colors.transparent : const Color(0xffD1DAD6),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Achieved Tasks',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                '$doneTasks Out of $totalTasks Done',
                style: Theme.of(context).textTheme.displaySmall,
              )
            ],
          ),
          const Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: -pi / 2,
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: CircularProgressIndicator(
                    value: percent / 100,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(AppColors.green),
                    backgroundColor: AppColors.secondaryLight,
                    color: AppColors.green,
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text(
                '$percent%',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          )
        ],
      ),
    );
  }
}
