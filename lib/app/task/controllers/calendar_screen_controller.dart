import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/dashboard/controller/dashboard_screen_controller.dart';
import '/app/task/controllers/common_tasks_controller.dart';
import '/app/task/widgets/calendar_tasks_bottom_view.dart';
import '/core/utils/controllers_helpers.dart';
import '/domain/entities/category_entity.dart';
import '/domain/entities/task_entity.dart';

typedef InCheckPoint = bool Function(DateTime date);
typedef CheckPointPressed = void Function(DateTime date);

class CalendarScreenController extends CommonTasksController {
  RxList<TaskEntity> tasks = <TaskEntity>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await _loadTasks();
    _checkDueDateInArgs();
  }

  List<DateTime> get dates {
    var list = tasks
        .where((p0) => p0.hasDueDate)
        .map((e) => DateTime(e.dueDate!.year, e.dueDate!.month))
        .toSet()
        .toList();

    list.sort((d1, d2) => d1.compareTo(d2));
    return list;
  }

  Future<void> _loadTasks() async {
    loader.start();
    tasks.value = await interactor.unDeletedTasksWithDueDate();
    loader.stop();
  }

  bool inCheckPoint(DateTime date) {
    return tasks.any((e) => DateUtils.isSameDay(e.dueDate, date));
  }

  List<TaskEntity> tasksByDate(DateTime date) {
    return tasks.where((p0) => DateUtils.isSameDay(p0.dueDate, date)).toList();
  }

  void onCheckPointPressed(DateTime date) async {
    var list = tasksByDate(date);
    if (list.isEmpty) return;
    await openDialog(
        CalendarTasksBottomView(tasks: list, onFindCategory: _findCategory),
        barrierColor: Colors.transparent);
  }

  CategoryEntity? _findCategory(int? id) {
    return ControllersHelpers.findOrNull<DashboardScreenController>()
        ?.onFindCategory(id);
  }

  void _checkDueDateInArgs() {
    var date = Get.arguments;
    if (date == null || date is! DateTime) return;
    onCheckPointPressed(date);
  }
}
