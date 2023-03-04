import 'package:flutter/material.dart';
import 'package:todo_app/app/task/widgets/add_new_task_form.dart';
import 'package:todo_app/core/presentation/style/palette.dart';
import 'package:todo_app/core/utils/controllers_helpers.dart';

import '../controllers/create_task_screen_controller.dart';

class CreateNewTaskScreen extends StatelessWidget {
  const CreateNewTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);
    return BottomSheet(
        backgroundColor: Palette.black800,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: radius, topLeft: radius)),
        onClosing: ControllersHelpers.delete<CreateTaskScreenController>,
        builder: (_) => AddNewTaskForm());
  }
}
