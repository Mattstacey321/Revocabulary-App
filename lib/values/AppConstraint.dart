import 'package:flutter/material.dart';

class AppConstraint{
  static Size getScreenSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
}