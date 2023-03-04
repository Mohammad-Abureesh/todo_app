import '/domain/entities/category_entity.dart';

abstract class CategoriesInteractor {
  Future<List<CategoryEntity>> fetchCategories();

  Future<void> createCategory(CategoryEntity model);

  Future<void> updateCategory(CategoryEntity model);

  Future<void> deleteCategory(CategoryEntity model);

  CategoryEntity? findOne(int id);
}
