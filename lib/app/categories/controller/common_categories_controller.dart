import 'package:get/get.dart';

import '/core/presentation/controllers/base_controller.dart';
import '/core/presentation/controllers/loading_controller.dart';
import '/data/categories_services.dart';
import '/domain/interactors/categories_interactor.dart';

abstract class CommonCategoriesController extends BaseController {
  final CategoriesInteractor interactor = CategoriesServices();
  final LoadingController loader = LoadingController();

  RxBool get isLoading => loader.isLoading;
}
