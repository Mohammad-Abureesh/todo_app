import 'package:flutter/material.dart';

import '/core/presentation/style/palette.dart';

class ColorsSlider extends StatelessWidget {
  final int? active;
  final Function(Color? color) onSelect;

  const ColorsSlider({Key? key, this.active, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Colors.red,
          Colors.green,
          Colors.amberAccent,
          Colors.lightBlue,
          Colors.pink
        ]
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: () => onSelect.call(e),
                    child: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: e,
                      child: active == e.value
                          ? const Icon(Icons.check, color: Palette.white)
                          : null,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
