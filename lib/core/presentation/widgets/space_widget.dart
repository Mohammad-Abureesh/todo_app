import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double _space;
  final bool isVertical;

  ///To return [SizedBox] widget By default return vertical space
  const Space(this._space, {this.isVertical = true, Key? key})
      : super(key: key);

  const Space.vertical(this._space, {Key? key})
      : isVertical = true,
        super(key: key);

  const Space.horizontal(this._space, {Key? key})
      : isVertical = false,
        super(key: key);

  const Space.empty({Key? key})
      : _space = 0.0,
        isVertical = false,
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      isVertical ? _addVerticalSpace() : _addHorizontalSpace();

  //To return sized box with width for adding horizontal space
  Widget _addHorizontalSpace() => SizedBox(width: _space);

  //To return sized box with width for adding vertical space
  Widget _addVerticalSpace() => SizedBox(height: _space);
}
