import 'package:easy_popup/easy_popup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DropDownMenu extends StatefulWidget {
  _DropDownMenuState _state;
  final Key key;
  DropDownMenu({this.key}): super(key: key);

  @override
  _DropDownMenuState createState() {
    _state = _DropDownMenuState();
    return _state;
  }

  dismiss() {
    _state.dismiss();
  }
}

class _DropDownMenuState extends State<DropDownMenu>
    with SingleTickerProviderStateMixin {
  Animation<Offset> _animation;
  AnimationController _controller;

  @override
  void initState() {

    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  dismiss() {
    _controller?.reverse();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 50),
        child: ClipRect(
          child: SlideTransition(
            position: _animation,
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: 4,
                itemExtent: 50,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      Fluttertoast.showToast(msg: 'item$index');
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'item$index',
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
