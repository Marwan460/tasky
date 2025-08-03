import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_style.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/models/task_model.dart';

import '../core/widgets/custom_switch.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  bool isHighPriority = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: false,
        iconTheme: const IconThemeData(color: AppColors.white2),
        title: Text(
          'New Task',
          style: AppStyle.regular16.copyWith(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Task Name',
                style: AppStyle.regular16,
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                onChanged: (value) {},
                controller: taskNameController,
                hintText: 'Finish UI design for login screen',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please Enter Task Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Task Description',
                style: AppStyle.regular16,
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
                    style: AppStyle.regular16.copyWith(fontSize: 16),
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
              const Spacer(),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    TaskModel model = TaskModel(
                        taskName: taskNameController.text,
                        taskDescription: taskDescriptionController.text,
                        isHighPriority: isHighPriority,
                       );

                    final pref = await SharedPreferences.getInstance();

                    final taskJson = pref.getString('tasks');
                    List<dynamic> listTasks = [];
                    if (taskJson != null) {
                      listTasks = jsonDecode(taskJson);
                    }
                    listTasks.add(model.toJson());
                    final taskEncode = jsonEncode(listTasks);
                    await pref.setString('tasks', taskEncode);
                    Navigator.pop(context,true);
                  }
                },
                title: 'Add Task',
                icon: const Icon(Icons.add, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
