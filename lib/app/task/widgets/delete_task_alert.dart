import '/core/applicationManagers/navigation_manager.dart';
import '/core/library/app_material.dart';

class DeleteTaskAlert extends StatelessWidget {
  final String msg;

  const DeleteTaskAlert({Key? key, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Column(children: const [
          BuildText(data: LocaleKeys.deleteTask),
          Divider(color: Palette.hint)
        ]),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.all(10.0),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const BuildText(data: LocaleKeys.deleteTaskHint, fontSize: 20.0),
          const Space.vertical(5.0),
          BuildText(data: msg),
          const Space.vertical(20.0),
          Row(children: [
            const Expanded(child: CancelButton()),
            Expanded(
                child: BuildMainButton(
                    title: LocaleKeys.deleteTask,
                    onPressed: () => NavigationManager.back(r: true)))
          ])
        ]));
  }
}
