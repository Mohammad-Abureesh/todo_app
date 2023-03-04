import '/core/enums/e_task_status.dart';
import '/domain/entities/task_entity.dart';

abstract class TasksInteractor {
  Future<void> createTask(TaskEntity model);

  Future<void> updateTask(TaskEntity model);

  Future<void> deleteTask(TaskEntity model);

  Future<List<TaskEntity>> allTasks();

  Future<List<TaskEntity>> fetchByStatus(TaskStatus status);

  Future<List<TaskEntity>> deletedTasks();

  Future<List<TaskEntity>> unDeletedTasksWithDueDate();
}
