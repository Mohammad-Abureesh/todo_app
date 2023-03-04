import 'package:flutter/material.dart';

import '/core/constants/locale_keys.dart';
import '/core/presentation/widgets/build_text.dart';
import '/core/presentation/widgets/empty_list.dart';
import '/core/presentation/widgets/space_widget.dart';

class EmptyTasksList extends StatelessWidget {
  const EmptyTasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const gap = Space.vertical(10.0);

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            EmptyList(),
            gap,
            BuildText(data: LocaleKeys.whatDoYouWantTodo, fontSize: 20.0),
            gap,
            BuildText(data: LocaleKeys.tapToAddTask),
          ]),
    );
  }
}
