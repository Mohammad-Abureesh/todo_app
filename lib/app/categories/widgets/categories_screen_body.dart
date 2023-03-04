import 'package:get/get.dart';

import '/core/applicationManagers/navigation_manager.dart';
import '/core/library/app_material.dart';
import '/core/utils/controllers_helpers.dart';
import '/domain/entities/category_entity.dart';
import '../controller/categories_screen_controller.dart';

class CategoriesScreenBody extends StatelessWidget {
  final CategoriesScreenController _controller;

  CategoriesScreenBody({Key? key})
      : _controller = ControllersHelpers.inject(CategoriesScreenController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(color: Palette.white),
          Obx(() => _controller.isLoading.value
              ? const LoadingWidget()
              : _CategoriesGrid(categories: _controller.categories)),
          BuildMainButton(
              height: 60.0,
              width: double.infinity,
              title: LocaleKeys.addCategory,
              onPressed: _controller.toAddNewCategory)
        ],
      ),
    );
  }
}

///
///To build categories grid view widget
class _CategoriesGrid extends StatelessWidget {
  final List<CategoryEntity> categories;

  const _CategoriesGrid({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    size = Size(size.width - 30.0, size.height - 350.0);

    final child = categories.isEmpty
        ? const EmptyList()
        : GridView.count(
            shrinkWrap: true,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 20.0,
            crossAxisCount: 3,
            children: categories.map((e) => _CategoryCard(e)).toList());

    return SizedBox.fromSize(size: size, child: child);
  }
}

///
///To build single Category card widget
class _CategoryCard extends StatelessWidget {
  final CategoryEntity element;
  const _CategoryCard(this.element, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => NavigationManager.back<CategoryEntity?>(r: element),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                  color: element.color.withOpacity(0.50),
                  elevation: 0.0,
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(element.icon,
                          color: element.color, size: 40.0))),
              BuildText(data: element.name, translate: false),
            ]));
  }
}
