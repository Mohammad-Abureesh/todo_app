import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/presentation/style/palette.dart';

class BuildText extends StatelessWidget {
  final String data;

  final double? fontSize;

  final Color? color;

  final bool translate;

  const BuildText(
      {Key? key,
      required this.data,
      this.translate = true,
      this.fontSize,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(translate ? data.tr : data,
        overflow: TextOverflow.visible,
        style: GoogleFonts.lato(
            color: color ?? Palette.white, fontSize: fontSize));
  }
}
