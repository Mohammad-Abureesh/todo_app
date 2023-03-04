import 'package:flutter/material.dart';
import 'package:todo_app/core/presentation/style/palette.dart';
import 'package:todo_app/core/presentation/widgets/build_text.dart';
import 'package:todo_app/core/presentation/widgets/loading_widget.dart';

class BuildMainButton extends StatefulWidget {
  final String title;
  final Color? background;
  final Color? titleColor;
  final dynamic onPressed;
  final double? fontSize;
  final double? width;
  final double? height;
  final double radius;
  final bool wait;

  const BuildMainButton(
      {this.title = '',
      this.background,
      Key? key,
      this.onPressed,
      this.titleColor,
      this.fontSize,
      this.width,
      this.radius = 4.0,
      this.height = 50.0,
      this.wait = true})
      : super(key: key);

  @override
  State<BuildMainButton> createState() => _BuildMainButtonState();
}

class _BuildMainButtonState extends State<BuildMainButton> {
  bool _waiting = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(widget.background),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.radius)))),
        onPressed: _waiting ? null : _impl,
        child: _waiting
            ? const LoadingWidget(color: Palette.white)
            : BuildText(
                data: widget.title,
                color: widget.titleColor,
                fontSize: widget.fontSize ?? 16.0),
      ),
    );
  }

  void _impl() async {
    _updateWaitingState = true;
    await widget.onPressed?.call();
    _updateWaitingState = false;
  }

  set _updateWaitingState(bool value) {
    if (!widget.wait) return;
    setState(() {
      _waiting = value;
    });
  }
}
