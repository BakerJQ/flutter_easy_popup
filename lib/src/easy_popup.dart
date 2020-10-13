import 'package:flutter/material.dart';

import 'easy_popup_route.dart';
import 'popup_child.dart';

class EasyPopup {
  static pop(BuildContext context) {
    EasyPopupRoute.pop(context);
  }

  static show(
    BuildContext context,
    PopupChild child, {
    Offset offsetLT,
    Offset offsetRB,
    bool cancelable = true,
    bool darkEnable = true,
    Duration duration = const Duration(milliseconds: 300),
    GlobalKey highlightWidgetKey,
  }) {
    Navigator.of(context).push(
      EasyPopupRoute(
        child: child,
        offsetLT: offsetLT,
        offsetRB: offsetRB,
        cancelable: cancelable,
        darkEnable: darkEnable,
        duration: duration,
        highlightWidgetKey: highlightWidgetKey,
      ),
    );
  }
}
