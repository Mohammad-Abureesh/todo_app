import 'package:flutter/material.dart';

import '/app/dashboard/widgets/add_task_float_button.dart';
import '../widgets/dashboard_app_bar.dart';
import '../widgets/dashboard_screen_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const DashboardAppBar(),
        body: DashboardScreenBody(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: const AddTaskFloatButton());
  }
}
