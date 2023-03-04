import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NavigationManager {
  static Future<void> openScreen(Widget page, {bool off = false, args}) async {
    if (off) return await Get.offAll(page);
    Get.to(page, preventDuplicates: false, arguments: args);
  }

  static Future<R?> openDialog<R>(Widget dialog, {Color? barrierColor}) async {
    return Get.dialog(dialog, barrierColor: barrierColor);
  }

  static void back<R>({R? r}) async {
    Get.back(result: r);
  }

  static Future<R?> openBottomSheet<R>(Widget bottomSheet,
      {FutureOr<void>? Function()? completeAction}) async {
    return await Get.bottomSheet<R>(bottomSheet,
            enableDrag: true, isScrollControlled: true)
        .whenComplete(completeAction ?? () {});
  }
}
