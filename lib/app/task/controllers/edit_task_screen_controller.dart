import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:todo_app/app/task/screens/calendar_screen.dart';

import '/app/dashboard/controller/dashboard_screen_controller.dart';
import '/app/task/controllers/task_operations_controller.dart';
import '/app/task/widgets/delete_task_alert.dart';
import '/core/constants/locale_keys.dart';
import '/core/enums/e_task_status.dart';
import '/core/utils/controllers_helpers.dart';
import '/domain/entities/task_entity.dart';

class EditTaskScreenController extends TaskOperationsController {
  EditTaskScreenController({required TaskEntity task}) : task = task.obs;

  final Rx<TaskEntity> task;

  @override
  void onInit() {
    super.onInit();
    _initFields();
  }

  ///To initialize form fields
  void _initFields() {
    var task = this.task.value;
    titleController.text = task.title;
    descriptionController.text = task.description;
    updateDueDateState = task.dueDate;
    updateCategoryState =
        ControllersHelpers.findOrNull<DashboardScreenController>()
            ?.onFindCategory(task.category);
  }

  void selectCategory() async {
    var category = await pickCategory();
    if (category != null) updateCategoryState = category;
  }

  Future<void> onSaveEdit() async {
    if (!validForm) return;
    task.value
      ..description = descriptionController.text
      ..setTitle = titleController.text
      ..setCategory = category.value?.id
      ..setDueDate = dueDate.value;

    await interactor.updateTask(task.value);
    refreshTaskInDashboard();
  }

  void markTaskAsComplete() async {
    if (task.value.isComplete) return;
    await _setTaskStatus(TaskStatus.complete);
    back();
  }

  void onDeleteButtonPressed() async {
    var msg = '${LocaleKeys.taskTitle.tr} : ${task.value.title}';
    var r = await openDialog<bool?>(DeleteTaskAlert(msg: msg));
    if (r != true) return;
    await _setTaskStatus(TaskStatus.deleted);
    back();
  }

  Future<void> _setTaskStatus(TaskStatus status) async {
    task.value.updateStatus = status;
    await interactor.updateTask(task.value);
    refreshTaskInDashboard();
  }

  Future<void> shareCurrentTaskDetails() async {
    await Share.share(task.value.toString());
  }

  @override
  void onSelectDueDate(DateTime? date) {
    if (date == null) return;
    super.onSelectDueDate(date);
  }

  void showOnCalendar() {
    if (dueDate.value == null) return;
    openScreen(const CalendarScreen(), args: dueDate.value);
  }
}
