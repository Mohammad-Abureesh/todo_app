import 'package:flutter/widgets.dart';
import 'package:todo_app/core/data/data_base.dart';
import 'package:todo_app/core/localization/localization_settings.dart';

class PreLaunchManager {
  static final PreLaunchManager _manager = PreLaunchManager._internal();

  PreLaunchManager._internal();

  factory PreLaunchManager() {
    return _manager;
  }

  //To prevent create another instance
  bool _mounted = false;

  ///To initialize all pre launch settings
  static Future<void> ensureInitialized() async {
    await _manager.initialize();
  }

  Future<void> initialize() async {
    if (_mounted) {
      throw _InitializeError();
    }

    _mounted = true;

    WidgetsFlutterBinding.ensureInitialized();
    await LocalizationSettings.initLangFiles();
    await CreateDataBase.create();
  }
}

class _InitializeError implements Exception {
  @override
  String toString() {
    return '''
    ${'-' * 50}
    ${super.toString()}
     <PreLaunchManager> Initialize Error
      - PreLaunchManager already initialize
      - Only can call initialize method in main point
    ${'-' * 50}
    ''';
  }
}
