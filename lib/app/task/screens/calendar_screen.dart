import '/app/task/widgets/calendar_screen_body.dart';
import '/core/applicationManagers/navigation_manager.dart';
import '/core/library/app_material.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            leading: const IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: NavigationManager.back),
            title: const BuildText(data: LocaleKeys.calendar)),
        body: CalendarScreenBody());
  }
}
