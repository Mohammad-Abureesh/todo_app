import 'package:get/get.dart';

class ControllersHelpers {
  ///To inject controller to memory
  static R inject<R>(R controller) {
    return Get.put(controller);
  }

  ///To find controller already injected to memory
  static R find<R>() {
    return Get.find<R>();
  }

  ///To find controller if register return controller
  ///else return null if not register
  static R? findOrNull<R>() {
    if (!isRegister<R>()) return null;
    return Get.find<R>();
  }

  ///To check if controller is register
  static bool isRegister<R>() {
    return Get.isRegistered<R>();
  }

  ///To delete controller from memory if is registered
  static void delete<R>() {
    if (isRegister<R>()) {
      Get.delete<R>();
    }
  }
}
