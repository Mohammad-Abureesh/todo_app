import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/locale_keys.dart';
import 'package:todo_app/core/presentation/widgets/build_text.dart';

import '../widgets/categories_screen_body.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        title: const Center(child: BuildText(data: LocaleKeys.chooseCategory)),
        content: CategoriesScreenBody());
  }
}
