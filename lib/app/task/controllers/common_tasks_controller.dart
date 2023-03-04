import 'package:get/get.dart';

import '/core/presentation/controllers/base_controller.dart';
import '/core/presentation/controllers/loading_controller.dart';
import '/data/tasks_services.dart';
import '/domain/interactors/tasks_interactor.dart';

abstract class CommonTasksController extends BaseController {
  final TasksInteractor interactor = TasksServices();
  final LoadingController loader = LoadingController();

  RxBool get isLoading => loader.isLoading;
}
