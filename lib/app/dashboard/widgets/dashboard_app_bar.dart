import '/app/task/screens/calendar_screen.dart';
import '/app/task/screens/tasks_trash_screen.dart';
import '/core/applicationManagers/navigation_manager.dart';
import '/core/library/app_material.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const BuildText(data: LocaleKeys.home),
        actions: const [_TrashButton(), _CalenderButton()]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

class _CalenderButton extends StatelessWidget {
  const _CalenderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _onPressed,
      icon: SvgIcon.defSize(icon: IconsKeys.calendar),
    );
  }

  void _onPressed() {
    NavigationManager.openScreen(const CalendarScreen());
  }
}

class _TrashButton extends StatelessWidget {
  const _TrashButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => NavigationManager.openScreen(const TasksTrashScreen()),
        icon: const Icon(Icons.delete_outlined));
  }
}
