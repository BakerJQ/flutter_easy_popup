import 'package:flutter/material.dart';

class EasyPopupRoute<T> extends PopupRoute<T> {
  final Widget child;
  final Offset offsetLT, offsetRB;
  final Duration duration;
  final bool cancelable;
  final bool outsideTouchCancelable;
  // final bool darkEnable;
  final double opacity;
  final VoidCallback onPopupShow;
  final VoidCallback onPopupDismiss;
  final List<RRect> highlights;

  EasyPopupRoute({
    @required this.child,
    this.offsetLT,
    this.offsetRB,
    this.cancelable = true,
    this.outsideTouchCancelable = true,
    // this.darkEnable = true,
    this.opacity = 0.5,
    this.duration = const Duration(milliseconds: 300),
    this.onPopupShow,
    this.onPopupDismiss,
    this.highlights,
  }) {
    assert(opacity != null && opacity <= 1.0 && opacity >= 0.0);
    assert(duration != null);
  }

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  GlobalKey<__PopRouteWidgetState> _globalKey = GlobalKey();
  @override
  bool didPop(T result) {
    onPopupDismiss?.call();
    _globalKey.currentState.dismiss();
    return super.didPop(result);
  }

  @override
  TickerFuture didPush() {
    onPopupShow?.call();
    return super.didPush();
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _PopRouteWidget(
      key: _globalKey,
      child: child,
      offsetLT: offsetLT,
      offsetRB: offsetRB,
      duration: duration,
      // animation: animation,
      cancelable: cancelable,
      outsideTouchCancelable: outsideTouchCancelable,
      // darkEnable: darkEnable,
      opacity: opacity,
      highlights: highlights,
    );
  }

  @override
  Duration get transitionDuration => duration;

  // @override
  // Animation<double> createAnimation() {
  //   return CurvedAnimation(
  //       parent: super.createAnimation(),
  //       curve: Curves.linear//,
  //       // reverseCurve: Curves.linear
  //   );// const Interval(0.0, 2.0/3.0));
  // }

  static pop(BuildContext context) {
    // __PopRouteWidgetState.of(context).dismiss();
    Navigator.of(context).pop();
  }

  static setHighlights(BuildContext context, List<RRect> highlights) {
    __PopRouteWidgetState.of(context).highlights = highlights;
  }
}

class _PopRouteWidget extends StatefulWidget {
  final Key key;
  final Widget child;
  final Offset offsetLT, offsetRB;
  final Duration duration;
  // final Animation<double> animation;
  final bool cancelable;
  final bool outsideTouchCancelable;
  // final bool darkEnable;
  final double opacity;
  final List<RRect> highlights;


  _PopRouteWidget({
    this.key,
    this.child,
    this.offsetLT,
    this.offsetRB,
    this.duration,
    // this.animation,
    this.cancelable,
    this.outsideTouchCancelable,
    // this.darkEnable,
    this.opacity,
    this.highlights,
  }):super(key: key);

  @override
  __PopRouteWidgetState createState() => __PopRouteWidgetState();
}

class __PopRouteWidgetState extends State<_PopRouteWidget>
    with SingleTickerProviderStateMixin
{
  Animation<double> _alphaAnim;
  AnimationController _alphaController;
  List<RRect> _highlights = [];

  @override
  void initState() {
    super.initState();
    highlights = widget.highlights ?? [];
    _alphaController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _alphaAnim = Tween<double>(begin: 0, end: 255).animate(_alphaController);
    _alphaController.forward();
  }

  static __PopRouteWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<__PopRouteWidgetState>();
  }

  dismiss() {
    _alphaController?.reverse();
  }

  set highlights(List<RRect> value) {
    setState(() {
      _highlights = value;
    });
  }

  @override
  void dispose() {
    _alphaController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.cancelable) {
          // dismiss();
          return true;
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          if (widget.outsideTouchCancelable) {
            // dismiss();
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: <Widget>[
            widget.opacity != 0
                ? AnimatedBuilder(
                    animation: _alphaController , //widget.animation,
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
                            Colors.black.withAlpha((_alphaAnim.value * widget.opacity).toInt()),
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
