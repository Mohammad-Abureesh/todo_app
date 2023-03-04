import 'package:flutter/material.dart';
import 'package:todo_app/app/task/widgets/edit_task_screen_app_bar.dart';

import '/app/task/controllers/edit_task_screen_controller.dart';
import '/app/task/widgets/edit_task_screen_body.dart';
import '/core/utils/controllers_helpers.dart';
import '/domain/entities/task_entity.dart';

class EditTaskScreen extends StatelessWidget {
  final TaskEntity task;

  const EditTaskScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ControllersHelpers.inject(EditTaskScreenController(task: task));

    return Scaffold(
      appBar: const EditTaskScreenAppBar(),
      body: EditTaskScreenBody(),
    );
  }
}
