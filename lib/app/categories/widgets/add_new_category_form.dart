import 'package:get/get.dart';

import '/app/categories/controller/add_category_screen_controller.dart';
import '/app/categories/widgets/colors_slider.dart';
import '/core/library/app_material.dart';
import '/core/utils/controllers_helpers.dart';

class AddNewCategoryForm extends StatelessWidget {
  final AddCategoryScreenController _controller;

  AddNewCategoryForm({Key? key})
      : _controller = ControllersHelpers.inject(AddCategoryScreenController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BuildText(data: LocaleKeys.createNewCategory),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FormSection(
                              title: LocaleKeys.categoryName,
                              child: BuildTextField(
                                  hint: LocaleKeys.categoryName,
                                  enableBorder: true,
                                  validator: _controller.nameValidator,
                                  controller: _controller.nameController)),
                          _FormSection(
                              title: LocaleKeys.categoryIcon,
                              titleChild: _controller.icon.value == null
                                  ? null
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                          IconData(_controller.icon.value!,
                                              fontFamily: 'MaterialIcons'),
                                          color: Palette.white)),
                              child: BuildMainButton(
                                  title: LocaleKeys.chooseIconFromLibrary,
                                  background: Palette.black800,
                                  height: 35.0,
                                  wait: false,
                                  onPressed: _controller.pickIcon,
                                  radius: 5.0)),
                          _FormSection(
                              title: LocaleKeys.categoryColor,
                              child: ColorsSlider(
                                  active: _controller.color.value,
                                  onSelect: _controller.onSelectColor)),
                        ],
                      ),
                    ),
                  ),
                ),
                const _AddFormActions(),
              ],
            )));
  }
}

class _AddFormActions extends StatelessWidget {
  const _AddFormActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(children: [
          const Expanded(child: CancelButton()),
          const Space.horizontal(10.0),
          Expanded(
              child: BuildMainButton(
                  title: LocaleKeys.createCategory,
                  onPressed:
                      ControllersHelpers.find<AddCategoryScreenController>()
                          .onAddCategory))
        ]));
  }
}

class _FormSection extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget? titleChild;

  const _FormSection(
      {Key? key, required this.title, required this.child, this.titleChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      BuildText(
        data: '${title.tr}:',
        translate: false,
        fontSize: 20.0,
      )
    ];

    if (titleChild != null) children.add(titleChild!);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: children),
            const Space.vertical(20.0),
            child
          ],
        ));
  }
}
