import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/cupertino.dart';

/// Show automatically the widget that best suits the current screensize
///
/// Widget will be shown for all sizes larger than specified until a widget is available that better suits larger screensizes.
class AdaptiveWidget extends StatelessWidget {
  final BuildContext context;
  final Widget xsmallWidget;
  final Widget? smallWidget;
  final Widget? mediumWidget;
  final Widget? largeWidget;
  final Widget? xlargeWidget;

  const AdaptiveWidget({
    Key? key,
    required this.context,
    required this.xsmallWidget,
    this.smallWidget,
    this.mediumWidget,
    this.largeWidget,
    this.xlargeWidget,
  }) : super(key: key);

  Widget _getBestWidgetForScreen(BuildContext context) {
    AdaptiveWindowType t = getWindowType(context);
    Widget widget = xsmallWidget;

    if (t >= AdaptiveWindowType.small && smallWidget != null) {
      widget = smallWidget!;
    }
    if (t >= AdaptiveWindowType.medium && mediumWidget != null) {
      widget = mediumWidget!;
    }
    if (t >= AdaptiveWindowType.large && largeWidget != null) {
      widget = largeWidget!;
    }
    if (t >= AdaptiveWindowType.xlarge && xlargeWidget != null) {
      widget = xlargeWidget!;
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return _getBestWidgetForScreen(context);
  }
}
