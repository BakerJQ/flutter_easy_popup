import 'package:easy_popup/easy_popup.dart';
import 'package:easy_popup_example/loading.dart';
import 'package:flutter/material.dart';

import 'drop_down_menu.dart';
import 'guide_popup.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey key1 = new GlobalKey(),
      key2 = new GlobalKey(),
      key3 = new GlobalKey(),
      key4 = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          title: Text('EasyPopup'),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              key: key1,
              behavior: HitTestBehavior.opaque,
              onTap: _showDropDownMenu,
              child: Container(
                color: Colors.blueAccent,
                alignment: Alignment.center,
                width: 200,
                height: 50,
                child: Text(
                  'ShowDropDownMenu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              key: key2,
              behavior: HitTestBehavior.opaque,
              onTap: _showGuidePopup,
              child: Container(
                width: 200,
                height: 50,
                color: Colors.blueAccent,
                alignment: Alignment.center,
                child: Text(
                  'ShowGuidePopup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              key: key3,
              behavior: HitTestBehavior.opaque,
              onTap: _showMultiHighlightsGuidePopup,
              child: Container(
                width: 200,
                height: 50,
                color: Colors.blueAccent,
                alignment: Alignment.center,
                child: Text(
                  'ShowMultiHighlightPopup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              key: key4,
              behavior: HitTestBehavior.opaque,
              onTap: _showLoading,
              child: Container(
                color: Colors.blueAccent,
                alignment: Alignment.center,
                width: 200,
                height: 50,
                child: Text(
                  'ShowLoading',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDropDownMenu() {
    DropDownMenu dropDownMenu = DropDownMenu();
    EasyPopup.show(context, dropDownMenu,
      offsetLT: Offset(0, MediaQuery.of(context).padding.top + 50),
      onPopupDismiss: (){
        dropDownMenu.dismiss();
      });
  }

  _showLoading() {
    EasyPopup.show(context, Loading(),
        // darkEnable: false,
        opacity: 0,
        duration: Duration(milliseconds: 0));
  }

  _showGuidePopup() {
    RenderBox box = key1.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    double left = offset.dx - 5;
    double top = offset.dy - 5;
    double width = box.size.width + 10;
    double height = box.size.height + 10;
    List<RRect> highlights = [
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, width, height),
        Radius.circular(10),
      ),
    ];
    EasyPopup.show(
      context,
      GuidePopup([key1, key2, key3, key4]),
      cancelable: false,
      highlights: highlights,
      duration: Duration(milliseconds: 100),
    );
  }

  _showMultiHighlightsGuidePopup() {
    List<GlobalKey> keys = [key1, key2, key3, key4];
    List<RRect> highlights = [];
    for (GlobalKey key in keys) {
      RenderBox box = key.currentContext.findRenderObject();
      Offset offset = box.localToGlobal(Offset.zero);
      double left = offset.dx - 5;
      double top = offset.dy - 5;
      double width = box.size.width + 10;
      double height = box.size.height + 10;
      highlights.add(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, width, height),
          Radius.circular(10),
        ),
      );
    }
    EasyPopup.show(
      context,
      GuidePopup([key1]),
      cancelable: false,
      highlights: highlights,
      duration: Duration(milliseconds: 100),
    );
  }
}
