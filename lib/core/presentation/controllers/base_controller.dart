import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '/core/applicationManagers/navigation_manager.dart';

abstract class BaseController extends GetxController with _Navigator {
  void logError(String error) {
    printError(info: error);
  }

  void clearData() {}
}

mixin _Navigator {
  Future<void> openScreen(Widget screen,
      {bool removeParent = false, args}) async {
    await NavigationManager.openScreen(screen, off: removeParent, args: args);
  }

  Future<R?> openDialog<R>(Widget dialog, {Color? barrierColor}) async {
    return await NavigationManager.openDialog(dialog,
        barrierColor: barrierColor);
  }

  void back() {
    NavigationManager.back();
  }
}
