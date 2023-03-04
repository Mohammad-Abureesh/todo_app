import 'package:get/get.dart';

import 'localization_settings.dart';

class Translate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en': LocalizationSettings.en};
}
