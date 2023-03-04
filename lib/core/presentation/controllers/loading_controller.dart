import 'package:get/get.dart';

class LoadingController extends GetxController {
  final RxBool _loading = false.obs;

  RxBool get isLoading => _loading;

  void start() {
    _updateLoadingState = true;
  }

  void stop() {
    _updateLoadingState = false;
  }

  set _updateLoadingState(bool value) {
    _loading.value = value;
  }
}
