import 'package:get/get.dart';

import '/app/categories/screens/add_new_category_screen.dart';
import '/domain/entities/category_entity.dart';
import 'common_categories_controller.dart';

class CategoriesScreenController extends CommonCategoriesController {
  RxList<CategoryEntity> categories = <CategoryEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    loader.start();
    categories.value = await interactor.fetchCategories();
    loader.stop();
  }

  ///To open add new category screen
  void toAddNewCategory() {
    openScreen(const AddNewCategoryScreen());
  }

  void refreshList() {
    _loadCategories();
  }
}
