import 'package:flutter/material.dart';
import 'package:todo_app/core/applicationManagers/navigation_manager.dart';
import 'package:todo_app/core/presentation/style/palette.dart';
import 'package:todo_app/core/utils/mat_icons.dart';

class IconsPicker extends StatelessWidget {
  const IconsPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: 200,
        height: 300,
        child: GridView.count(
          crossAxisCount: 5,
          children: iconsLibrary.values
              .map((e) => IconButton(
                  onPressed: () {
                    NavigationManager.back(r: e.codePoint);
                  },
                  icon: Icon(e, color: Palette.white)))
              .toList(),
        ),
      ),
    );
  }
}
