import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  final Widget child;
  final Offset begin;
  final Offset end;
  final int delayed;
  final Curve curve;
  final bool isShow;
  const SlideAnimation(
      {this.begin, this.end, this.delayed, this.child, this.curve, this.isShow = false});
  @override
  _SlideAnimationState createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;
  double height = 0;
  double width = 0;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: widget.delayed));
    animation = Tween(begin: widget.begin, end: widget.end)
        .animate(CurvedAnimation(parent: controller, curve: widget.curve));
    if (widget.isShow) {
      setState(() {
        controller.forward();
        height = 150;
        width= 150;
      });
    } else
      setState(() {
        height= 0;
        width = 0;
        controller.reverse();
      });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: FadeTransition(
          opacity: controller,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            child: widget.child,
            height: height,
            width: width,

          )),
    );
  }
}
