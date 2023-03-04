import 'package:flutter/material.dart';
import 'package:todo_app/app/root/root_widget.dart';
import 'package:todo_app/core/applicationManagers/pre_launch_manager.dart';

void main() async {
  await PreLaunchManager.ensureInitialized();
  runApp(const ToDoApp());
}
