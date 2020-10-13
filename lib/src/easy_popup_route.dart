import 'package:flutter/material.dart';

import 'popup_child.dart';

class EasyPopupRoute extends PopupRoute {
  final PopupChild child;
  final Offset offsetLT, offsetRB;
  final GlobalKey highlightWidgetKey;
  final Duration duration;
  final bool cancelable;
  final bool darkEnable;

  EasyPopupRoute({
    @required this.child,
    this.offsetLT,
    this.offsetRB,
    this.cancelable = true,
    this.darkEnable = true,
    this.duration = const Duration(milliseconds: 300),
    this.highlightWidgetKey,
  });

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _PopRouteWidget(
      child: child,
      offsetLT: offsetLT,
      offsetRB: offsetRB,
      duration: duration,
      cancelable: cancelable,
      darkEnable: darkEnable,
      highlightWidgetKey: highlightWidgetKey,
    );
  }

  @override
  Duration get transitionDuration => duration;

  static pop(BuildContext context) {
    __PopRouteWidgetState.of(context).dismiss();
    Navigator.of(context).pop();
  }
}

class _PopRouteWidget extends StatefulWidget {
  final PopupChild child;
  final Offset offsetLT, offsetRB;
  final Duration duration;
  final bool cancelable;
  final bool darkEnable;
  final GlobalKey highlightWidgetKey;

  _PopRouteWidget({
    this.child,
    this.offsetLT,
    this.offsetRB,
    this.duration,
    this.cancelable,
    this.darkEnable,
    this.highlightWidgetKey,
  });

  @override
  __PopRouteWidgetState createState() => __PopRouteWidgetState();
}

class __PopRouteWidgetState extends State<_PopRouteWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> alphaAnim;
  AnimationController alphaController;

  @override
  void initState() {
    super.initState();
    alphaController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    alphaAnim = Tween<double>(begin: 0, end: 127).animate(alphaController);
    alphaController.forward();
  }

  static __PopRouteWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<__PopRouteWidgetState>();
  }

  dismiss() {
    alphaController?.reverse();
    widget.child?.dismiss();
  }

  @override
  void dispose() {
    alphaController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RenderBox highlight =
        widget.highlightWidgetKey?.currentContext?.findRenderObject();
    Offset highlightOffset = highlight?.localToGlobal(Offset.zero);
    return WillPopScope(
      onWillPop: () async {
        if (widget.cancelable) {
          dismiss();
          return true;
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          if (widget.cancelable) {
            dismiss();
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: <Widget>[
            widget.darkEnable
                ? AnimatedBuilder(
                    animation: alphaController,
                    builder: (_, __) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: widget.offsetLT?.dx ?? 0,
                          top: widget.offsetLT?.dy ?? 0,
                          right: widget.offsetRB?.dx ?? 0,
                          bottom: widget.offsetRB?.dy ?? 0,
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withAlpha(alphaAnim.value.toInt()),
                            BlendMode.srcOut,
                          ),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  backgroundBlendMode: BlendMode.dstOut,
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  color: Colors.white,
                                  width: highlight?.size?.width ?? 0,
                                  height: highlight?.size?.height ?? 0,
                                ),
                                left: highlightOffset?.dx,
                                top: highlightOffset?.dy,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Container(),
            widget.child,
          ],
        ),
      ),
    );
  }
}
