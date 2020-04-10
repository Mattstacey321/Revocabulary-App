import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:revocabulary/values/AppColors.dart';

class Vocabulary extends StatefulWidget {
  @override
  _VocabularyState createState() => _VocabularyState();
}

class _VocabularyState extends State<Vocabulary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: 80,
              child: Row(
                children: <Widget>[
                  Text("Vocabulary", style: TextStyle(color: AppColors.primaryColor, fontSize: 40)),
                  Spacer(),
                  Material(
                      clipBehavior: Clip.antiAlias,
                      type: MaterialType.circle,
                      color: Colors.transparent,
                      child: IconButton(icon: Icon(FeatherIcons.sliders,color: AppColors.primaryColor,size: 30,), onPressed: () {}))
                ],
              ),
            ),
            /*ListView.builder(
              itemCount: ,
              itemBuilder: )*/
          ],
        ),
      ),
    );
  }
}
