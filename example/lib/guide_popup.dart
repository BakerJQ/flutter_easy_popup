import 'package:easy_popup/easy_popup.dart';
import 'package:flutter/material.dart';

class GuidePopup extends StatefulWidget with EasyPopupChild {
  final List<GlobalKey> highlightKeys;

  GuidePopup(this.highlightKeys);

  @override
  _GuidePopupState createState() => _GuidePopupState();

  @override
  dismiss() {}
}

class _GuidePopupState extends State<GuidePopup> {
  int highlightIndex = -1;
  double hLeft, hTop, hWidth, hHeight, hRadius;

  @override
  void initState() {
    super.initState();
    Rect rect = _calculateNextGuide();
    hRadius = 10;
    hLeft = rect.left;
    hTop = rect.top;
    hHeight = rect.height;
    hWidth = rect.width;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _next(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(
            top: hTop - 55,
            left: hLeft + (hWidth - 300) / 2,
          ),
          child: Container(
              width: 300,
              height: 50,
              alignment: Alignment.center,
              color: Colors.white,
              child: Text('${_getShowText()}')),
        ),
      ),
    );
  }

  String _getShowText() {
    switch (highlightIndex) {
      case 0:
        return 'Click here to show dropdown menu.';
      case 1:
        return 'Click here to show guide.';
      case 2:
        return 'Click here to show multi highlight guide.';
      case 3:
        return 'Click here to show loading.';
    }
    return '';
  }

  _next() {
    Rect rect = _calculateNextGuide();
    if (rect == null) {
      return;
    }
    List<RRect> highlights = [
      RRect.fromRectAndRadius(
        rect,
        Radius.circular(hRadius),
      ),
    ];
    setState(() {
      EasyPopup.setHighlights(context, highlights);
      hLeft = rect.left;
      hTop = rect.top;
      hHeight = rect.height;
      hWidth = rect.width;
    });
  }

  Rect _calculateNextGuide() {
    highlightIndex++;
    if (highlightIndex >= widget.highlightKeys.length) {
      _dismiss();
      return null;
    }
    RenderBox box =
        widget.highlightKeys[highlightIndex].currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    return Rect.fromLTWH(
      offset.dx - 5,
      offset.dy - 5,
      box.size.width + 10,
      box.size.height + 10,
    );
  }

  _dismiss() {
    EasyPopup.pop(context);
  }
}
