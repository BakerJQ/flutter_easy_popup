import 'package:flutter/material.dart';

import 'easy_popup_route.dart';

class EasyPopup {
  ///Dismiss the popup related to the specific BuildContext
  static pop(BuildContext context) {
    EasyPopupRoute.pop(context);
  }

  ///Show popup
  static show(
    BuildContext context,
    Widget child, {
    Offset offsetLT,
    Offset offsetRB,
    bool cancelable = true,
    bool outsideTouchCancelable = true,
    // bool darkEnable = true,
    double opacity = 0.5,
    Duration duration = const Duration(milliseconds: 300),
    VoidCallback onPopupShow,
    VoidCallback onPopupDismiss,
    List<RRect> highlights,
  }) {
    Navigator.of(context).push(
      EasyPopupRoute(
        child: child,
        offsetLT: offsetLT,
        offsetRB: offsetRB,
        cancelable: cancelable,
        outsideTouchCancelable: outsideTouchCancelable,
        // darkEnable: darkEnable,
        opacity: opacity,
        duration: duration,
        onPopupShow: onPopupShow,
        onPopupDismiss: onPopupDismiss,
        highlights: highlights,
      ),
    );
  }

  ///Set popup highlight positions
  static setHighlights(BuildContext context, List<RRect> highlights) {
    EasyPopupRoute.setHighlights(context, highlights);
  }
}

