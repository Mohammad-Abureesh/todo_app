import 'package:flutter/material.dart';

import '/core/constants/icons_keys.dart';
import '/core/presentation/style/palette.dart';
import '/core/presentation/widgets/build_text_field.dart';
import '/core/presentation/widgets/svg_icon.dart';

class SearchField extends StatelessWidget {
  final String? hint;
  final ValueChanged<String?>? onSearch;
  final TextEditingController? controller;

  const SearchField({Key? key, this.hint, this.onSearch, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: BuildTextField(
        controller: controller ?? TextEditingController(),
        onChanged: onSearch,
        enableBorder: true,
        hint: hint,
        fillColor: Palette.fieldFillColor,
        prefix: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgIcon.defSize(
                icon: IconsKeys.search, color: Palette.hint, size: 30.0)),
      ),
    );
  }
}
