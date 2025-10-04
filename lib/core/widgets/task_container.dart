import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_style.dart';

class TaskContainer extends StatelessWidget {
  final bool? value;
  final void Function()? onPressed;
  final void Function(bool?)? onChanged;
  final String taskName, taskDescription;

  const TaskContainer(
      {super.key,
      this.value,
      this.onChanged,
      required this.taskName,
      required this.taskDescription,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    taskName,
                    style: AppStyle.regular16.copyWith(
                      color: value == true ? AppColors.grey2 : AppColors.white,
                      decoration:
                          value == true ? TextDecoration.lineThrough : null,
                      decorationColor: AppColors.grey2,
                      decorationThickness: 1.5,
                    ),
                  ),
                  SelectableText(
                    taskDescription,
                    style: AppStyle.regular16.copyWith(
                      color: AppColors.grey2,
                      fontSize: 14,
                      decoration:
                          value == true ? TextDecoration.lineThrough : null,
                      decorationColor: AppColors.grey2,
                      decorationThickness: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.more_vert,
                color: value == true ? AppColors.grey2 : AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
