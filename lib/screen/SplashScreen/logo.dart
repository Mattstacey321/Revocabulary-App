import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final AnimationController slideAnimation;
  final Animation<Offset> animation;
  Logo({this.animation, this.slideAnimation});
  @override
  Widget build(BuildContext context) {
    return  Container(
        alignment: Alignment.center,
        width: 150,
        height: 150,
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(blurRadius: 2, offset: Offset(2, 2),color: Colors.black26)]),
        child: Text("Revoca", style: TextStyle(color: Color(0xff828AE6),fontSize: 40)),
      
    );
  }
}
