import 'package:get/get.dart';

import '/app/task/controllers/task_operations_controller.dart';
import '/core/enums/e_task_status.dart';
import '/domain/entities/task_entity.dart';

class TasksTrashController extends TaskOperationsController {
  RxList<TaskEntity> tasks = <TaskEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _readDeletedTasks();
  }

  Future<void> _readDeletedTasks() async {
    loader.start();
    tasks.value = await interactor.deletedTasks();
    loader.stop();
  }

  Future<void> restoreTask(TaskEntity task) async {
    task.updateStatus = TaskStatus.unComplete;
    await interactor.updateTask(task);
    await _readDeletedTasks();
    refreshTaskInDashboard();
  }

  Future<void> delete(TaskEntity task) async {
    await interactor.deleteTask(task);
    await _readDeletedTasks();
    refreshTaskInDashboard();
  }
}
