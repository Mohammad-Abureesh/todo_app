import 'package:flutter/material.dart';

import '/app/dashboard/widgets/task_card.dart';
import '/core/presentation/widgets/space_widget.dart';
import '/domain/entities/task_entity.dart';
import 'empty_tasks_list.dart';

class TasksListView extends StatelessWidget {
  final List<TaskEntity> tasks;
  final UpdateTaskState onUpdateState;
  final OnFindCategory onFindCategory;
  final bool emptyState;

  const TasksListView(
      {Key? key,
      required this.tasks,
      required this.onUpdateState,
      required this.emptyState,
      required this.onFindCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (emptyState) return const EmptyTasksList();
    return ListView.separated(
      itemCount: tasks.length,
      separatorBuilder: (_, index) => const Space.vertical(10.0),
      itemBuilder: (_, index) {
        final task = tasks.elementAt(index);
        return TaskCard(
            task: task,
            onUpdateState: onUpdateState,
            onFindCategory: onFindCategory);
      },
    );
  }
}
