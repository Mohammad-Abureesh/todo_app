import 'package:flutter/material.dart';

import '/core/applicationManagers/navigation_manager.dart';
import '/core/constants/locale_keys.dart';
import '/core/presentation/style/palette.dart';
import '/core/presentation/widgets/build_main_button.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BuildMainButton(
        title: LocaleKeys.cancel,
        titleColor: Palette.mainColor,
        fontSize: 16.0,
        background: Colors.transparent,
        onPressed: NavigationManager.back);
  }
}
