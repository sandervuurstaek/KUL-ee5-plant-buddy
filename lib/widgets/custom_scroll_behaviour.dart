import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomScrollBehaviour extends MaterialScrollBehavior {
  const CustomScrollBehaviour()
      : super(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch);

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}
