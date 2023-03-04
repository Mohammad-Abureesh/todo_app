import 'package:todo_app/core/constants/locale_keys.dart';

class Validations {
  static String? titleValidator(String? value) {
    if (value == null || value.isEmpty) return LocaleKeys.enterTaskTitle;
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) return LocaleKeys.enterCategoryName;
    return null;
  }
}
