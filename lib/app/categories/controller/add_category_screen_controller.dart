import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '/app/categories/controller/categories_screen_controller.dart';
import '/app/categories/controller/common_categories_controller.dart';
import '/app/categories/widgets/icons_picker.dart';
import '/core/utils/controllers_helpers.dart';
import '/core/utils/validations.dart';
import '/domain/entities/category_entity.dart';

class AddCategoryScreenController extends CommonCategoriesController {
  AddCategoryScreenController() : formKey = GlobalKey<FormState>();

  final GlobalKey<FormState> formKey;

  TextEditingController nameController = TextEditingController();

  Rxn<int> color = Rxn<int>();

  Rxn<int> icon = Rxn<int>();

  Future<void> onAddCategory() async {
    if (!_isValidForm) return;

    var category = CategoryEntity.create(
        name: nameController.text,
        icon: IconData(icon.value!),
        color: Color(color.value!));

    await interactor.createCategory(category);
    ControllersHelpers.findOrNull<CategoriesScreenController>()?.refreshList();
    clearData();
  }

  bool get _isValidForm {
    return (formKey.currentState?.validate() ?? false) && icon.value != null;
  }

  Future<void> pickIcon() async {
    icon.value = await openDialog<int?>(const IconsPicker());
  }

  void onSelectColor(Color? color) {
    this.color.value = color?.value;
  }

  String? nameValidator(String? value) {
    return Validations.nameValidator(value)?.tr;
  }

  @override
  void clearData() {
    super.clearData();
    nameController.clear();
    color.value = null;
    icon.value = null;
  }
}
