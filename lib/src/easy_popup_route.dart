import 'package:flutter/material.dart';

import 'easy_popup_child.dart';

class EasyPopupRoute extends PopupRoute {
  final EasyPopupChild child;
  final Offset? offsetLT, offsetRB;
  final Duration duration;
  final bool cancelable;
  final bool outsideTouchCancelable;
  final bool darkEnable;
  final List<RRect>? highlights;

  EasyPopupRoute({
    required this.child,
    this.offsetLT,
    this.offsetRB,
    this.cancelable = true,
    this.outsideTouchCancelable = true,
    this.darkEnable = true,
    this.duration = const Duration(milliseconds: 300),
    this.highlights,
  });

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _PopRouteWidget(
      child: child,
      offsetLT: offsetLT,
      offsetRB: offsetRB,
      duration: duration,
      cancelable: cancelable,
      outsideTouchCancelable: outsideTouchCancelable,
      darkEnable: darkEnable,
      highlights: highlights,
    );
  }

  @override
  Duration get transitionDuration => duration;

  static pop(BuildContext context) {
    __PopRouteWidgetState.of(context)!.dismiss();
    Navigator.of(context).pop();
  }

  static setHighlights(BuildContext context, List<RRect> highlights) {
    __PopRouteWidgetState.of(context)!.highlights = highlights;
  }
}

class _PopRouteWidget extends StatefulWidget {
  final EasyPopupChild child;
  final Offset? offsetLT, offsetRB;
  final Duration? duration;
  final bool cancelable;
  final bool outsideTouchCancelable;
  final bool darkEnable;
  final List<RRect>? highlights;

  _PopRouteWidget({
    required this.child,
    this.offsetLT,
    this.offsetRB,
    this.duration,
    this.cancelable = true,
    this.outsideTouchCancelable = true,
    this.darkEnable = true,
    this.highlights,
  });

  @override
  __PopRouteWidgetState createState() => __PopRouteWidgetState();
}

class __PopRouteWidgetState extends State<_PopRouteWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> alphaAnim;
  late AnimationController alphaController;
  List<RRect> _highlights = [];

  @override
  void initState() {
    super.initState();
    highlights = widget.highlights ?? [];
    alphaController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    alphaAnim = Tween<double>(begin: 0, end: 127).animate(alphaController);
    alphaController.forward();
  }

  static __PopRouteWidgetState? of(BuildContext context) {
    return context.findAncestorStateOfType<__PopRouteWidgetState>();
  }

  dismiss() {
    alphaController.reverse();
    widget.child.dismiss();
  }

  set highlights(List<RRect> value) {
    setState(() {
      _highlights = value;
    });
  }

  @override
  void dispose() {
    alphaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          if (widget.outsideTouchCancelable) {
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
                            children: _buildDark(),
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

  List<Widget> _buildDark() {
    List<Widget> widgets = [];
    widgets.add(Container(
      color: Colors.transparent,
    ));
    for (RRect highlight in _highlights) {
      widgets.add(Positioned(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: highlight.tlRadius,
                topRight: highlight.trRadius,
                bottomLeft: highlight.blRadius,
                bottomRight: highlight.brRadius,
              )),
          width: highlight.width,
          height: highlight.height,
        ),
        left: highlight.left,
        top: highlight.top,
      ));
    }
    return widgets;
  }
}
