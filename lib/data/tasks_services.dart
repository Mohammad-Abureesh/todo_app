import 'package:todo_app/core/data/service_settings.dart';

import '/core/constants/data_base_config.dart';
import '/core/data/data_base_services.dart';
import '/core/enums/e_task_status.dart';
import '/domain/entities/task_entity.dart';
import '/domain/interactors/tasks_interactor.dart';

class TasksServices extends DataBaseServices<TaskEntity>
    with ServiceSettingMixin
    implements TasksInteractor {
  @override
  String get table => DbConfig.taskT;

  @override
  Future<List<TaskEntity>> allTasks() {
    return retrieveAll(table, TaskEntity.fromMap);
  }

  @override
  Future<void> createTask(TaskEntity model) async {
    await insert(model);
  }

  @override
  Future<void> deleteTask(TaskEntity model) async {
    await delete(model);
  }

  @override
  Future<List<TaskEntity>> fetchByStatus(TaskStatus status) {
    return retrieveAll(table, TaskEntity.fromMap,
        condition: 'status=${status.index}');
  }

  @override
  Future<void> updateTask(TaskEntity model) async {
    await update(model);
  }

  @override
  Future<List<TaskEntity>> deletedTasks() async {
    return await fetchByStatus(TaskStatus.deleted);
  }

  @override
  Future<List<TaskEntity>> unDeletedTasksWithDueDate() {
    return retrieveAll(
      table,
      TaskEntity.fromMap,
      condition: 'status!=${TaskStatus.deleted.index} AND dueDate IS NOT NULL',
    );
  }
}
