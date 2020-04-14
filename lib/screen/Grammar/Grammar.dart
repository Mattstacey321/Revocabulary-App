import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:revocabulary/screen/Grammar/Tense.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';
import 'package:revocabulary/widget/faslideAnimation.dart';

class Grammar extends StatefulWidget {
  @override
  _GrammarState createState() => _GrammarState();
}

class _GrammarState extends State<Grammar> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
    return Hero(
        tag: "grammar",
        child: Scaffold(
          body: Container(
            height: screenSize.height,
            width: screenSize.width,
            child: Column(
              children: <Widget>[
                Container(
                    height: screenSize.height / 4.5,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: AssetImage("assets/pngs/tense.png"))),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleIcon(
                              icon: FeatherIcons.arrowLeft,
                              iconSize: 30,
                              iconColor: Colors.white,
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                        FaSlideAnimation(
                          delayed: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Let's \nlearn some grammar",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 10),
                Flexible(
                    child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  itemCount: 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.5, crossAxisSpacing: 40),
                  itemBuilder: (context, index) => FaSlideAnimation(
                    delayed: 0,
                    child: Material(
                      borderRadius: BorderRadius.circular(15),
                      clipBehavior: Clip.antiAlias,
                      color: AppColors.primaryColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Tense(),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  tileMode: TileMode.mirror,
                                  colors: [AppColors.primaryColor, AppColors.secondaryColor])),
                          child: Text(
                            "Thì",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}
