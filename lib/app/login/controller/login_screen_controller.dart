import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '/app/dashboard/screens/dashboard_screen.dart';
import '/core/constants/locale_keys.dart';
import '/core/presentation/controllers/base_controller.dart';
import '/core/presentation/controllers/loading_controller.dart';

class LoginScreenController extends BaseController {
  LoginScreenController()
      : _localAuthentication = LocalAuthentication(),
        loader = LoadingController();

  final LoadingController loader;
  final LocalAuthentication _localAuthentication;

  ///To handle biometric state if current device supported
  RxBool isSupportedAuth = false.obs;

  ///Unlock app button impl
  Future<void> onUnlock() async {
    loader.start();
    _updateIsSupportedState = await _localAuthentication.canCheckBiometrics;

    //todo:handel un supported devices
    if (isSupportedAuth.isFalse) {
      loader.stop();
      return;
    }

    if (await _auth()) await _successLogin();
    loader.stop();
  }

  ///When success local authenticate then to dashboard
  Future<void> _successLogin() async {
    await openScreen(const DashboardScreen(), removeParent: true);
  }

  Future<bool> _auth() async {
    try {
      return _localAuthentication.authenticate(
          localizedReason: LocaleKeys.scanToUnlock.tr);
    } catch (_) {
      return false;
    }
  }

  set _updateIsSupportedState(bool value) {
    isSupportedAuth.value = value;
  }
}
