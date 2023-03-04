import 'package:get/get.dart';
import 'package:todo_app/core/extensions/date_time_ext.dart';
import 'package:todo_app/core/library/app_material.dart';

import '/app/task/controllers/create_task_screen_controller.dart';
import '/core/utils/controllers_helpers.dart';
import '/domain/entities/category_entity.dart';
import '../../dashboard/widgets/task_category_card.dart';

class AddNewTaskForm extends StatelessWidget {
  final CreateTaskScreenController _controller;

  AddNewTaskForm({Key? key})
      : _controller = ControllersHelpers.inject(CreateTaskScreenController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const gap = Space.vertical(25.0);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
          key: _controller.formKey,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BuildText(data: LocaleKeys.addTask, fontSize: 20.0),
                gap,
                BuildTextField(
                    key: const Key('titleK'),
                    controller: _controller.titleController,
                    validator: _controller.titleValidator,
                    hint: LocaleKeys.taskTitle),
                gap,
                BuildTextField(
                    controller: _controller.descriptionController,
                    hint: LocaleKeys.description),
                gap,
                Obx(() => _selectedCategory(_controller.category.value)),
                gap,
                Obx(() => _dueDate(_controller.dueDate.value)),
                gap,
                const _ActionsRow()
              ])),
    );
  }

  Widget _selectedCategory(CategoryEntity? category) {
    if (category == null) return const Space.empty();
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const BuildText(data: LocaleKeys.taskCategory),
      TaskCategoryCard(category: category)
    ]);
  }

  Widget _dueDate(DateTime? date) {
    if (date == null) return const Space.empty();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BuildText(data: LocaleKeys.dueDate),
        BuildText(data: date.dueDateFormat, translate: false)
      ],
    );
  }
}

///
///To build crete task actions buttons
class _ActionsRow extends StatelessWidget {
  const _ActionsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctr = ControllersHelpers.find<CreateTaskScreenController>();

    return Row(
      children: [
        DateTimePickerButton(onSelectDate: ctr.onSelectDueDate),
        const Space.horizontal(15.0),
        _button(IconsKeys.tag, ctr.toCategories),
        const Spacer(),
        Obx(() => ctr.isLoading.value
            ? const LoadingWidget()
            : _button(IconsKeys.send, ctr.onAddTask,
                color: Palette.mainColor, key: const Key('addTask'))),
      ],
    );
  }

  Widget _button(String icon, impl, {Color? color, Key? key}) {
    return IconButton(
        key: key,
        onPressed: impl,
        icon: SvgIcon.defSize(icon: icon, color: color));
  }
}
