import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:revocabulary/values/AppColors.dart';
import 'package:revocabulary/widget/circleIcon.dart';

class PhraseVerb extends StatefulWidget {
  @override
  PhraseVerbState createState() => PhraseVerbState();
}

class PhraseVerbState extends State<PhraseVerb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: Row(
            children: <Widget>[
              CircleIcon(
                icon: FeatherIcons.arrowLeft,
                iconSize: 30,
                onTap: () {
                  Navigator.pop(context);
                },
                iconColor: AppColors.primaryColor,
              ),
              SizedBox(width: 10),
              Text(
                "Phrase Vebs",
                style: TextStyle(
                    color: AppColors.primaryColor, fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          preferredSize: Size.fromHeight(40)),
    );
  }
}
