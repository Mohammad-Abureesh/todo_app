import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:todo_app/core/presentation/style/palette.dart';

import 'build_text.dart';

class BuildTextField extends StatelessWidget {
  final TextEditingController controller;

  final String? label;
  final String? hint;

  final double labelSize;
  final double radius;

  final FormFieldValidator<String?>? validator;
  final ValueChanged<String?>? onChanged;

  final bool enableBorder;

  final Widget? prefix;
  final Widget? suffix;

  final Color? fillColor;

  final AutovalidateMode? validateMode;

  const BuildTextField(
      {Key? key,
      required this.controller,
      this.label,
      this.hint,
      this.labelSize = 18.0,
      this.radius = 4.0,
      this.enableBorder = false,
      this.validator,
      this.onChanged,
      this.prefix,
      this.fillColor,
      this.validateMode,
      this.suffix})
      : super(key: key);

  bool get _hasLabel => label != null;

  @override
  Widget build(BuildContext context) {
    return _hasLabel ? _withLabel : _field;
  }

  Widget get _withLabel {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [BuildText(data: label ?? '', fontSize: labelSize), _field]);
  }

  //To build main field widget
  Widget get _field {
    return TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        autovalidateMode: validateMode,
        style: const TextStyle(color: Palette.white),
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: suffix,
          fillColor: fillColor,
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 150.0, maxWidth: 150.0),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 150.0, maxWidth: 150.0),
          hintText: hint?.tr,
          enabledBorder: enableBorder ? null : InputBorder.none,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        ));
  }
}
