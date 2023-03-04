import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon extends StatelessWidget {
  final String icon;
  final String _extension;

  final Size _size;

  final Color? color;

  final BoxFit? fit;

  SvgIcon(
      {required this.icon,
      double width = 25.0,
      double height = 25.0,
      Key? key,
      this.color,
      this.fit})
      : _size = Size(width, height),
        _extension = 'svg',
        super(key: key);

  SvgIcon.defSize(
      {required this.icon, double? size, Key? key, this.color, this.fit})
      : _size = Size.square(size ?? 30.0),
        _extension = 'svg',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final path = 'assets/icons/$icon.$_extension';

    ColorFilter? filter;

    if (color != null) filter = ColorFilter.mode(color!, BlendMode.srcIn);

    return SvgPicture.asset(path,
        height: _size.height,
        width: _size.width,
        fit: fit ?? BoxFit.contain,
        colorFilter: filter);
  }
}
