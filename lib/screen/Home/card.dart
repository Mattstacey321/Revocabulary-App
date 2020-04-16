import 'package:flutter/material.dart';
import 'package:responsive_widgets/responsive_widgets.dart';

class CardTitle extends StatelessWidget {
  final String text;
  final Color color;
  final double left;
  final double right;
  final double bottom;
  final double top;
  final Color circleColor;
  final Alignment alignment;
  final Function onPress;
  CardTitle(
      {this.text,
      this.color,
      this.left,
      this.right,
      this.bottom,
      this.top,
      this.alignment,
      this.circleColor,
      this.onPress});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    String type = text;
    return Material(
      child: InkWell(
        onTap: () {
          return onPress(type);
        },
        child: ContainerResponsive(
          alignment: Alignment.center,
          height: 100,
          width: 150,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
          child: Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: TextResponsive(
                    text,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              Positioned.fill(
                top: top,
                bottom: bottom,
                left: left,
                right: right,
                child: Align(
                  alignment: alignment,
                  child: ContainerResponsive(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
