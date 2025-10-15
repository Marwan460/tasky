import 'package:flutter/material.dart';
import 'package:tasky/core/enums/task_item_actions_enum.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/utils/app_colors.dart';

import 'custom_checkbox.dart';

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
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ThemeController.isDark()
                ? Colors.transparent
                : const Color(0xffD1DAD6),
          ),
        ),
        child: Row(
          children: [
            CustomCheckbox(value: value, onChanged: onChanged),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    taskName,
                    style: value == false
                        ? Theme.of(context).textTheme.bodyMedium
                        : Theme.of(context).textTheme.titleMedium,
                  ),
                  SelectableText(
                    taskDescription,
                    style: value == false
                        ? Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14)
                        : Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
            PopupMenuButton<TaskItemActionsEnum>(
              icon: Icon(
                Icons.more_vert,
                color: ThemeController.isDark()
                    ? (value == true
                        ? const Color(0xffA0A0A0)
                        : AppColors.grey2)
                    : (value == true
                        ? const Color(0xff6A6A6A)
                        : AppColors.black2),
              ),
              onSelected: (value) {
                switch (value){
                  case TaskItemActionsEnum.edit:
                  case TaskItemActionsEnum.delete:
                }
              },
              itemBuilder: (context) => TaskItemActionsEnum.values.map((e) {
                return PopupMenuItem<TaskItemActionsEnum>(
                  value: e,
                  child: Text(e.name),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
