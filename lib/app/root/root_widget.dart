import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/constants/locale_keys.dart';

import '/app/login/screens/login_screen.dart';
import '/core/localization/localization_settings.dart';
import '/core/localization/translation.dart';
import '/core/presentation/style/theme/dark_theme.dart';
import 'responsive_builder.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: LocaleKeys.appName,
        debugShowCheckedModeBanner: false,
        supportedLocales: LocalizationSettings.localesList,
        themeMode: ThemeMode.dark,
        darkTheme: DarkTheme.theme,
        translations: Translate(),
        locale: LocalizationSettings.appLocale,
        home: const LoginScreen(),
        builder: ResponsiveWrapperBuilder.platform.builder);
  }
}
