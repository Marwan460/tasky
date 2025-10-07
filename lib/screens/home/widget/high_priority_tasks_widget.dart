import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/widgets/custom_checkbox.dart';
import 'package:tasky/res/assets_res.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_style.dart';
import '../../../models/task_model.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(bool?, int?) onChanged;
  final void Function() onTap;

  const HighPriorityTasksWidget(
      {super.key, required this.tasks, required this.onChanged, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'High Priority Tasks',
                  style: AppStyle.regular14.copyWith(color: AppColors.green),
                ),
              ),
              ...tasks.where((e) => e.isHighPriority).take(4).map((e) {
                return Row(
                  children: [
                    CustomCheckbox(
                        value: e.isDone,
                        onChanged: (value) {
                          final index = tasks.indexWhere((element) {
                            return e.taskID == element.taskID;
                          });
                          onChanged(value, index);
                        }),
                    const SizedBox(width: 8),
                    Text(
                      e.taskName,
                      style: AppStyle.regular16,
                    ),
                  ],
                );
              })
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.grey),
                ),
                child: SvgPicture.asset(AssetsRes.ARROW_UP_RIGHT),
              ),
            ),
          )
        ],
      ),
    );
  }
}
