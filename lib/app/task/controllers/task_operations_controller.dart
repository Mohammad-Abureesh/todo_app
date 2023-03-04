import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/app/categories/screens/categories_screen.dart';
import '/app/dashboard/controller/dashboard_screen_controller.dart';
import '/core/utils/controllers_helpers.dart';
import '/core/utils/validations.dart';
import '/domain/entities/category_entity.dart';
import 'common_tasks_controller.dart';

abstract class TaskOperationsController extends CommonTasksController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Form fields controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  ///To manage due date state
  Rxn<DateTime> dueDate = Rxn<DateTime>();

  ///To manage selected category state
  Rxn<CategoryEntity> category = Rxn<CategoryEntity>();

  @override
  void clearData() {
    super.clearData();
    titleController.clear();
    descriptionController.clear();
    category.value = null;
    dueDate.value = null;
  }

  set updateCategoryState(CategoryEntity? category) {
    this.category.value = category;
  }

  set updateDueDateState(DateTime? dueDate) {
    this.dueDate.value = dueDate;
  }

  bool get validForm {
    return formKey.currentState?.validate() ?? false;
  }

  ///To return translated error msg
  String? titleValidator(String? value) {
    return Validations.titleValidator(value)?.tr;
  }

  void refreshTaskInDashboard() {
    ControllersHelpers.findOrNull<DashboardScreenController>()?.refreshTasks();
  }

  Future<CategoryEntity?> pickCategory() async {
    return await openDialog<CategoryEntity?>(const CategoriesScreen());
  }

  void onSelectDueDate(DateTime? date) {
    updateDueDateState = date;
  }
}
