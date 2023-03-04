import 'package:flutter/material.dart';
import 'package:todo_app/app/task/screens/create_new_task_screen.dart';
import 'package:todo_app/core/applicationManagers/navigation_manager.dart';
import 'package:todo_app/core/presentation/style/palette.dart';

const double _floatDimension = 70.0;

class AddTaskFloatButton extends StatelessWidget {
  const AddTaskFloatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox.square(
            dimension: _floatDimension,
            child: FloatingActionButton(
              backgroundColor: Palette.mainColor,
              onPressed: _openCreateTaskSheet,
              child: const Icon(Icons.add, size: 35.0, color: Palette.white),
            )));
  }

  void _openCreateTaskSheet() {
    NavigationManager.openBottomSheet(const CreateNewTaskScreen());
  }
}
