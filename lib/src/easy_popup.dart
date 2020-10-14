import 'package:flutter/material.dart';

import 'easy_popup_child.dart';
import 'easy_popup_route.dart';

class EasyPopup {
  ///Dismiss the popup related to the specific BuildContext
  static pop(BuildContext context) {
    EasyPopupRoute.pop(context);
  }

  ///Show popup
  static show(
    BuildContext context,
    EasyPopupChild child, {
    Offset offsetLT,
    Offset offsetRB,
    bool cancelable = true,
    bool darkEnable = true,
    Duration duration = const Duration(milliseconds: 300),
    List<RRect> highlights,
  }) {
    Navigator.of(context).push(
      EasyPopupRoute(
        child: child,
        offsetLT: offsetLT,
        offsetRB: offsetRB,
        cancelable: cancelable,
        darkEnable: darkEnable,
        duration: duration,
        highlights: highlights,
      ),
    );
  }

  ///Set popup highlight positions
  static setHighlights(BuildContext context, List<RRect> highlights) {
    EasyPopupRoute.setHighlights(context, highlights);
  }
}
