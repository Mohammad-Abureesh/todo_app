import 'package:todo_app/app/dashboard/widgets/task_card.dart';
import 'package:todo_app/core/library/app_material.dart';
import 'package:todo_app/domain/entities/task_entity.dart';

class CalendarTasksBottomView extends StatelessWidget {
  final List<TaskEntity> tasks;
  final OnFindCategory onFindCategory;

  const CalendarTasksBottomView(
      {Key? key, required this.tasks, required this.onFindCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              width: size.width - 50,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: List.generate(
                    tasks.length,
                    (index) => SizedBox(
                        width: size.width - 50,
                        child: TaskCard(
                            task: tasks[index],
                            onUpdateState: (status, task) {},
                            disableNavToDetails: true,
                            onFindCategory: onFindCategory))),
              ),
            )));
  }
}
