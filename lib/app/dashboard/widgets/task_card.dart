import 'package:flutter/material.dart';
import 'package:todo_app/app/task/screens/edit_task_screen.dart';
import 'package:todo_app/core/applicationManagers/navigation_manager.dart';
import 'package:todo_app/core/constants/icons_keys.dart';
import 'package:todo_app/core/extensions/date_time_ext.dart';
import 'package:todo_app/core/presentation/widgets/svg_icon.dart';

import '/app/dashboard/widgets/task_category_card.dart';
import '/core/enums/e_task_status.dart';
import '/core/presentation/style/palette.dart';
import '/core/presentation/widgets/build_text.dart';
import '/core/presentation/widgets/space_widget.dart';
import '/domain/entities/category_entity.dart';
import '/domain/entities/task_entity.dart';

typedef UpdateTaskState = void Function(TaskStatus, TaskEntity);
typedef OnFindCategory = CategoryEntity? Function(int?);

class TaskCard extends StatelessWidget {
  final TaskEntity task;
  final UpdateTaskState onUpdateState;
  final OnFindCategory onFindCategory;
  final bool disableNavToDetails;

  const TaskCard(
      {Key? key,
      required this.task,
      required this.onUpdateState,
      required this.onFindCategory,
      this.disableNavToDetails = false})
      : super(key: key);

  void _openEditScreen() {
    NavigationManager.openScreen(EditTaskScreen(task: task));
  }

  void _onChanged(val) {
    var state = (val ?? false) ? TaskStatus.complete : TaskStatus.unComplete;
    onUpdateState.call(state, task);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: task.isDeleted || disableNavToDetails ? null : _openEditScreen,
        leading: task.isDeleted
            ? SvgIcon(icon: IconsKeys.trash, color: Colors.red)
            : Transform.scale(
                scale: 1.20,
                child: Checkbox(
                    value: task.isComplete,
                    side: const BorderSide(color: Palette.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0)),
                    onChanged: _onChanged)),
        minVerticalPadding: 4.0,
        subtitle: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Space.vertical(10.0),
              BuildText(data: task.title, translate: false, fontSize: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildText(
                      data: task.dueDate?.dueDateFormat ?? '',
                      translate: false,
                      fontSize: 16.0),
                  const Spacer(),
                  task.hasCategory
                      ? TaskCategoryCard(
                          category: onFindCategory.call(task.category)!)
                      : const Space.empty()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
