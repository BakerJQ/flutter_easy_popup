import 'package:easy_popup/easy_popup.dart';
import 'package:flutter/material.dart';

class HighLightPopup extends StatelessWidget with PopupChild {
  final GlobalKey highlightKey;

  HighLightPopup(this.highlightKey);

  @override
  Widget build(BuildContext context) {
    RenderBox box = highlightKey.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(
          top: offset.dy - 55,
          left: offset.dx + (box.size.width - 300) / 2,
        ),
        child: Container(
            width: 300,
            height: 50,
            alignment: Alignment.center,
            color: Colors.white,
            child: Text('This is a highlight popup.')),
      ),
    );
  }

  @override
  dismiss() {}
}
