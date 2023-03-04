import 'package:get/get.dart';

import '/app/dashboard/widgets/task_category_card.dart';
import '/app/task/controllers/edit_task_screen_controller.dart';
import '/core/extensions/date_time_ext.dart';
import '/core/library/app_material.dart';
import '/core/utils/controllers_helpers.dart';
import '/domain/entities/category_entity.dart';

class EditTaskScreenBody extends StatelessWidget {
  final EditTaskScreenController _controller;

  EditTaskScreenBody({Key? key})
      : _controller = ControllersHelpers.find<EditTaskScreenController>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const gap = Space.vertical(20.0);
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Form(
                key: _controller.formKey,
                child: Column(
                  children: [
                    gap,
                    BuildTextField(
                        validateMode: AutovalidateMode.onUserInteraction,
                        controller: _controller.titleController,
                        suffix: SvgIcon.defSize(
                          icon: IconsKeys.edit,
                          size: 30.0,
                        ),
                        validator: _controller.titleValidator,
                        hint: LocaleKeys.taskTitle),
                    BuildTextField(
                        controller: _controller.descriptionController,
                        hint: LocaleKeys.description),
                    gap,
                    DateTimePickerButton(
                        initDate: _controller.dueDate.value,
                        onSelectDate: _controller.onSelectDueDate,
                        child: _Section(
                            icon: IconsKeys.timer,
                            title: LocaleKeys.taskTime,
                            child: _dueDateChild(_controller.dueDate.value))),
                    _Section(
                        onTap: _controller.selectCategory,
                        icon: IconsKeys.tag,
                        title: LocaleKeys.taskCategory,
                        child: _categoryChild(_controller.category.value)),
                    _Section(
                        onTap: _controller.onDeleteButtonPressed,
                        icon: IconsKeys.trash,
                        title: LocaleKeys.deleteTask,
                        color: Colors.red),
                    _Section(
                        vis: _controller.dueDate.value != null,
                        onTap: _controller.showOnCalendar,
                        icon: IconsKeys.calendar,
                        title: LocaleKeys.calendar),
                  ],
                ),
              ),
            )),
            BuildMainButton(
                onPressed: _controller.onSaveEdit,
                width: double.infinity,
                title: LocaleKeys.editTask),
            const Space.vertical(30.0)
          ],
        ),
      );
    });
  }

  Widget? _categoryChild(CategoryEntity? value) =>
      value == null ? null : TaskCategoryCard(category: value);

  Widget? _dueDateChild(DateTime? value) {
    if (value == null) return null;
    return Card(
        elevation: 0.0,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BuildText(data: value.dueDateFormat)));
  }
}

class _Section extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? child;
  final Color? color;
  final bool vis;
  final VoidCallback? onTap;

  const _Section(
      {Key? key,
      required this.icon,
      required this.title,
      this.child,
      this.color,
      this.onTap,
      this.vis = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!vis) return const Space.empty();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: InkWell(
        onTap: onTap,
        child: Row(children: [
          SvgIcon.defSize(icon: icon, color: color),
          const Space.horizontal(10.0),
          BuildText(data: title, color: color),
          const Spacer(),
          child ?? const Space.empty()
        ]),
      ),
    );
  }
}
