import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tasky/core/enums/task_item_actions_enum.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/models/task_model.dart';

import 'custom_button.dart';
import 'custom_checkbox.dart';
import 'custom_switch.dart';
import 'custom_text_form_field.dart';

class TaskContainer extends StatelessWidget {
  final bool? value;
  final TaskModel model;
  final void Function()? onPressed;
  final void Function(bool?)? onChanged;
  final void Function(int) onDelete;
  final void Function() onEdit;

  const TaskContainer({super.key,
    this.value,
    this.onChanged,
    this.onPressed,
    required this.onDelete,
    required this.model, required this.onEdit,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme
              .of(context)
              .colorScheme
              .primaryContainer,
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
                    model.taskName,
                    style: value == false
                        ? Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        : Theme
                        .of(context)
                        .textTheme
                        .titleMedium,
                  ),
                  SelectableText(
                    model.taskDescription,
                    style: value == false
                        ? Theme
                        .of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14)
                        : Theme
                        .of(context)
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
              onSelected: (value) async{
                switch (value) {
                  case TaskItemActionsEnum.delete:
                    _showAlertDialog(context);
                  case TaskItemActionsEnum.edit:
                    final result = await _showModalBottomSheet(context, model);
                    if (result == true) {
                      onEdit();
                    }
                }
              },
              itemBuilder: (context) =>
                  TaskItemActionsEnum.values.map((e) {
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

  _showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Delete Task'),
              content: const Text('Are you sure you want to delete this task?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    onDelete(model.taskID);
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                  child: const Text('Delete'),
                ),
              ]);
        });
  }

  Future<bool?> _showModalBottomSheet(BuildContext context, TaskModel model) {
    TextEditingController taskNameController =
    TextEditingController(text: model.taskName);
    TextEditingController taskDescriptionController =
    TextEditingController(text: model.taskDescription);
    GlobalKey<FormState> key = GlobalKey<FormState>();
    bool isHighPriority = model.isHighPriority;
    return showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.7,
              minChildSize: 0.4,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return StatefulBuilder(builder: (context, setState) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task Name',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            CustomTextFormField(
                              onChanged: (value) {},
                              controller: taskNameController,
                              hintText: 'Finish UI design for login screen',
                              validator: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return 'Please Enter Task Name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Task Description',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            CustomTextFormField(
                              onChanged: (value) {},
                              controller: taskDescriptionController,
                              hintText:
                              'Finish onboarding UI and hand off to devs by Thursday.',
                              maxLines: 5,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'High Priority',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                                CustomSwitch(
                                  value: isHighPriority,
                                  onChanged: (value) {
                                    setState(() {
                                      isHighPriority = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              onPressed: () async {
                                if (key.currentState?.validate() ?? false) {
                                  final taskJson = PreferencesManager().getString('tasks');

                                  List<dynamic> tasks = [];

                                  if (taskJson != null) {
                                    tasks = jsonDecode(taskJson);
                                  }

                                  TaskModel newModel = TaskModel(
                                    taskID: model.taskID,
                                    taskName: taskNameController.text,
                                    taskDescription: taskDescriptionController.text,
                                    isHighPriority: isHighPriority,
                                    isDone: model.isDone,
                                  );

                                  final item = tasks.firstWhere((e) => e['taskID'] == model.taskID);

                                  final int index = tasks.indexOf(item);
                                  tasks[index] = newModel;

                                  final taskEncode = jsonEncode(tasks);
                                  await PreferencesManager().setString('tasks', taskEncode);
                                  Navigator.pop(context, true);
                                }
                              },
                              title: 'Add Task',
                              icon: const Icon(Icons.edit, size: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              });
        });
  }
}
