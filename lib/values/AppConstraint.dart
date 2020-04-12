import 'package:flutter/material.dart';

class AppConstraint {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Material circleIcon = Material(
    clipBehavior: Clip.antiAlias,
    color: Colors.transparent,
    type: MaterialType.circle,
  );
}
