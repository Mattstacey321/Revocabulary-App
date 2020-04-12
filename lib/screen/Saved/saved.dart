import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:revocabulary/screen/Saved/SavedWordProvider.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/values/AppConstraint.dart';
import 'package:revocabulary/widget/circleIcon.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  SavedWordProvider savedWordModel;
  @override
  void initState() {
    
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
    savedWordModel = Injector.get(context:context);
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Text("Saved", style: TextStyle(color: AppColors.primaryColor, fontSize: 40)),
                Spacer(),
                CircleIcon(
                  icon: FeatherIcons.search,
                  iconColor: AppColors.primaryColor,
                  iconSize: 35,
                  onTap: () {},
                )
              ],
            ),
          ),
          //Expanded(child: ListView.builder(itemBuilder: null))
        ],
      ),
    );
  }
}
