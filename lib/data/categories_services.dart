import 'package:get/get.dart';
import 'package:todo_app/core/data/service_settings.dart';

import '/core/constants/data_base_config.dart';
import '/core/data/data_base_services.dart';
import '/domain/entities/category_entity.dart';
import '/domain/interactors/categories_interactor.dart';

class CategoriesServices extends DataBaseServices<CategoryEntity>
    with ServiceSettingMixin
    implements CategoriesInteractor {
  static List<CategoryEntity> categories = [];

  @override
  String get table => DbConfig.categoryT;

  @override
  Future<void> createCategory(CategoryEntity model) async {
    await insert(model);
  }

  @override
  Future<void> deleteCategory(CategoryEntity model) async {
    await delete(model);
  }

  @override
  Future<List<CategoryEntity>> fetchCategories() async {
    categories = await retrieveAll(table, CategoryEntity.fromMap);
    return categories;
  }

  @override
  Future<void> updateCategory(CategoryEntity model) async {
    await update(model);
  }

  @override
  CategoryEntity? findOne(int id) {
    return categories.firstWhereOrNull((e) => e.id == id);
  }
}
