import 'package:flutter/material.dart';
import 'package:todo_app/app/login/controller/login_screen_controller.dart';
import 'package:todo_app/core/constants/icons_keys.dart';
import 'package:todo_app/core/constants/locale_keys.dart';
import 'package:todo_app/core/presentation/widgets/build_main_button.dart';
import 'package:todo_app/core/presentation/widgets/space_widget.dart';
import 'package:todo_app/core/presentation/widgets/svg_icon.dart';
import 'package:todo_app/core/utils/controllers_helpers.dart';

class LoginScreenBody extends StatelessWidget {
  final LoginScreenController _controller;

  LoginScreenBody({Key? key})
      : _controller = ControllersHelpers.inject(LoginScreenController()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SvgIcon.defSize(icon: IconsKeys.todo, size: 150.0),
            const Spacer(),
            BuildMainButton(
                key: const Key('unlock'),
                width: double.infinity,
                onPressed: _controller.onUnlock,
                title: LocaleKeys.scanToUnlock),
            const Space.vertical(70.0)
          ],
        ),
      ),
    ));
  }
}
