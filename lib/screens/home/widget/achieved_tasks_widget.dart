import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';

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
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Achieved Tasks', style: AppStyle.regular16,),
              Text('$doneTasks Out of $totalTasks Done', style: AppStyle.regular14,)
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
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.green),
                    backgroundColor: AppColors.grey,
                    color: AppColors.green,
                    strokeWidth: 4,
                  ),
                ),
              ),
              Text('$percent%', style: AppStyle.medium14,)
            ],
          )
        ],
      ),
    );
  }
}
