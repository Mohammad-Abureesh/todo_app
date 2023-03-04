import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ResponsiveWrapperBuilder {
  ///App responsive builder
  ///
  /// [_defaultBuilder] to init default builder for Android & ios ... other
  static ResponsiveWrapperBuilder platform = ResponsiveWrapperBuilder._();

  final Widget Function(BuildContext, Widget?) builder;

  ///Internal factory constructor
  factory ResponsiveWrapperBuilder._() {
    return ResponsiveWrapperBuilder._defaultBuilder();
  }

  ///Default builder
  ResponsiveWrapperBuilder._defaultBuilder()
      : builder = ((context, widget) => ResponsiveWrapper.builder(widget,
                maxWidth: 1200,
                minWidth: 480,
                mediaQueryData:
                    MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                defaultScale: true,
                breakpoints: const [
                  ResponsiveBreakpoint.resize(480, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ]));
}
