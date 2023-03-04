import '/domain/entities/task_entity.dart';
import 'task_operations_controller.dart';

class CreateTaskScreenController extends TaskOperationsController {
  Future<void> onAddTask() async {
    if (!validForm) return;

    loader.start();
    var task = TaskEntity.createTask(
        title: titleController.text.trim(),
        description: descriptionController.text,
        categoryId: category.value?.id,
        dueDate: dueDate.value);

    await interactor.createTask(task);
    refreshTaskInDashboard();
    clearData();
    loader.stop();
  }

  void toCategories() async {
    updateCategoryState = await pickCategory();
  }
}
