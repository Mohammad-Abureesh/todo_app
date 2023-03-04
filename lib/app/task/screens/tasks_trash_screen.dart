import 'package:get/get.dart';
import 'package:todo_app/app/dashboard/widgets/empty_tasks_list.dart';

import '/app/task/controllers/tasks_trash_controller.dart';
import '/core/library/app_material.dart';
import '/core/utils/controllers_helpers.dart';

class TasksTrashScreen extends StatelessWidget {
  const TasksTrashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0.0, title: const BuildText(data: LocaleKeys.trash)),
        body: _TrashScreenBody());
  }
}

class _TrashScreenBody extends StatelessWidget {
  final TasksTrashController _controller;

  _TrashScreenBody({Key? key})
      : _controller = ControllersHelpers.inject(TasksTrashController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.tasks.isEmpty
        ? const EmptyTasksList()
        : ListView.separated(
            padding: const EdgeInsets.all(20.0),
            itemCount: _controller.tasks.length,
            itemBuilder: (_, index) {
              final task = _controller.tasks.elementAt(index);
              return ListTile(
                  title: Row(
                children: [
                  BuildText(data: task.title, fontSize: 20.0),
                  const Spacer(),
                  IconButton(
                      onPressed: () => _controller.restoreTask(task),
                      icon: const Icon(Icons.restore, color: Colors.blue)),
                  IconButton(
                      onPressed: () => _controller.delete(task),
                      icon: const Icon(Icons.delete, color: Colors.red)),
                ],
              ));
            },
            separatorBuilder: (_, index) => const Divider(color: Palette.white),
          ));
  }
}
