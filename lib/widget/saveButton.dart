import 'dart:async';

import 'package:flutter/material.dart';
import 'package:revocabulary/screen/Saved/SavedWordProvider.dart';
import 'package:revocabulary/values/AppColors.dart';

class SaveButton extends StatefulWidget {
  final IconData icon;
  final bool saved;
  final Color lightColor;
  final Color darkColor;
  final String wordID;
  final double iconSize;
  final Function onSaved;

  const SaveButton(
      {@required this.iconSize,
      @required this.wordID,
      this.icon,
      this.onSaved,
      @required this.saved,
      @required this.lightColor,
      @required this.darkColor});

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool isSave = false;
  int state = 0; // unsave
  AnimationController animationController;
  Animation animation;
  SavedWordProvider savedWordProvider;
  @override
  void initState() {
    super.initState();
    changeState();
  }

  void changeState() {
    if (widget.saved) {
      setState(() {
        isSave = true;
        state = 1;
      });
    }
  }

  void animationButton() {
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 1).animate(animationController);
    animationController.forward();
    //show loading

    if (mounted) {
      setState(() {
        state = 2;
      });
    }

    // change state base on isSave
    Timer(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          state = 1;
          isSave = !isSave;
        });
      }
    });
  }

  Widget buildWidget() {
    if (state == 1 && isSave) {
      //print("saved");
      //TODO save word here
      
      return Icon(
        Icons.bookmark,
        color: widget.darkColor,
        size: 30,
      );
    }
    if (state == 2) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
        ),
      );
    } else {
      //print("unsave else");
      //TODO unsave word here
      
      return Icon(
        Icons.bookmark_border,
        color: widget.lightColor,
        size: 30,
      );
    }
  }
  void addWord(){
    if(isSave){
      widget.onSaved(true);
      print("unsave");
    }
    else{
      widget.onSaved(false);
      print("save");
    }
  }
  @override
  void dispose() {
    super.dispose();
    //animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
          padding: EdgeInsets.all(0),
          width: 50,
          height: 50,
          child: RaisedButton(
            elevation: 0,
            color: AppColors.secondaryColor,
            padding: EdgeInsets.all(0),
            shape: CircleBorder(),
            animationDuration: Duration(milliseconds: 1000),
            onPressed: () {
              //print("state $state , $isSave");
              
              setState(() {
                animationButton();
              });
              addWord();
            },
            child: buildWidget(),
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
