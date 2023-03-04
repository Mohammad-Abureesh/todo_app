import 'package:flutter/material.dart';

import '/core/presentation/style/palette.dart';
import '/core/presentation/widgets/build_text.dart';
import '/core/presentation/widgets/space_widget.dart';
import '/domain/entities/category_entity.dart';

class TaskCategoryCard extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap;

  const TaskCategoryCard({Key? key, required this.category, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
          elevation: 0.0,
          color: category.color.withOpacity(0.50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Icon(category.icon, color: category.color),
                const Space.horizontal(5.0),
                BuildText(data: category.name, color: Palette.white)
              ]))),
    );
  }
}
