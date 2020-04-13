import 'dart:async';

import 'package:flutter/material.dart';

class FaSlideAnimation extends StatefulWidget {
  final Widget child;
  final int delayed;
  final bool isReserve;
  FaSlideAnimation({this.child, this.delayed, this.isReserve = false});
  @override
  _FaSlideAnimationState createState() => _FaSlideAnimationState();
}

class _FaSlideAnimationState extends State<FaSlideAnimation> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    if (widget.isReserve == false) {
      Timer(Duration(milliseconds: widget.delayed), () {
        animationController.forward();
      });
    }
    if (widget.isReserve) {
      Timer(Duration(milliseconds: widget.delayed), () {
        animationController.reverse();
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: FadeTransition(
        opacity: animationController,
        child: widget.child,
      ),
    );
  }
}
