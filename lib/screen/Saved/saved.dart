import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:revocabulary/screen/Saved/SavedWordProvider.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';
import 'package:revocabulary/widget/faslideAnimation.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> with TickerProviderStateMixin {
  SavedWordProvider savedWordModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      savedWordModel.readFromLocal();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
    savedWordModel = Injector.get(context: context);
    var words = savedWordModel.words;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FaSlideAnimation(
            delayed: 200,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Saved", style: TextStyle(color: AppColors.primaryColor, fontSize: 40)),
                  Spacer(),
                  FaSlideAnimation(
                    delayed: 600,
                    child: CircleIcon(
                      icon: FeatherIcons.search,
                      iconColor: AppColors.primaryColor,
                      iconSize: 35,
                      onTap: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: GridView.builder(
                  itemCount: savedWordModel.words.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 3),
                  ),
                  itemBuilder: (context, index) {
                    var words = savedWordModel.words;
                    return FaSlideAnimation(
                      delayed: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.alternativeColor,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    offset: Offset(1, 2),
                                    color: AppColors.alternativeColor.withOpacity(0.1))
                              ], borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                words[index].word,
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
