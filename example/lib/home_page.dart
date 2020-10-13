import 'package:easy_popup/easy_popup.dart';
import 'package:flutter/material.dart';

import 'drop_down_menu.dart';
import 'highlight_popup.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey key = new GlobalKey();

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
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
              key: key,
              behavior: HitTestBehavior.opaque,
              onTap: _showGuidePopup,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  width: 200,
                  height: 50,
                  color: Colors.blueAccent,
                  alignment: Alignment.center,
                  child: Text(
                    'ShowHighLightPopup',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showDropDownMenu() {
    EasyPopup.show(context, DropDownMenu(),
        offsetLT: Offset(0, MediaQuery.of(context).padding.top + 50));
  }

  _showGuidePopup() {
    EasyPopup.show(context, HighLightPopup(key), highlightWidgetKey: key);
  }
}
