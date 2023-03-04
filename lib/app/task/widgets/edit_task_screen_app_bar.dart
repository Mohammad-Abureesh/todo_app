import '/app/task/controllers/edit_task_screen_controller.dart';
import '/core/enums/e_task_status.dart';
import '/core/library/app_material.dart';
import '/core/utils/controllers_helpers.dart';

class EditTaskScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const EditTaskScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ctr = ControllersHelpers.find<EditTaskScreenController>();

    List<Widget> actions = [ShareButton(onShare: ctr.shareCurrentTaskDetails)];

    if (ctr.task.value.status == TaskStatus.unComplete) {
      actions.add(_MarkTaskASComplete(onPressed: ctr.markTaskAsComplete));
    }

    return AppBar(
      actions: actions,
      elevation: 0.0,
      leading: IconButton(
        onPressed: ctr.back,
        icon: const Icon(Icons.close),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90.0);
}

class _MarkTaskASComplete extends StatelessWidget {
  final VoidCallback? onPressed;
  const _MarkTaskASComplete({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        child: BuildMainButton(
            onPressed: onPressed,
            wait: false,
            fontSize: 12.0,
            height: 20.0,
            width: 120.0,
            background: Palette.fieldFillColor,
            title: LocaleKeys.markASComplete));
  }
}
