import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:revocabulary/class/Word.dart';
import 'package:revocabulary/screen/Saved/SavedWordProvider.dart';
import 'package:revocabulary/screen/Test_Word/testMemorize.dart';
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
  bool showDeleteIcon = false;
  bool hideObject = false;
  Box<Word> word;
  @override
  void initState() {
    super.initState();
    word = Hive.box<Word>('word');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future openHive() async {
    word = await Hive.openBox<Word>('word');
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = AppConstraint.getScreenSize(context);
    savedWordModel = Injector.get(context: context);
    //var words = Hive.box("word");
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          showDeleteIcon = false;
        });
      },
      child: ContainerResponsive(
        padding: EdgeInsetsResponsive.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FaSlideAnimation(
              delayed: 200,
              child: Padding(
                padding: EdgeInsetsResponsive.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextResponsive("Saved", style: TextStyle(color: AppColors.primaryColor, fontSize: ScreenUtil().setSp(35))),
                    Spacer(),
                    FaSlideAnimation(
                      delayed: 500,
                      child: IgnorePointer(
                        ignoring: word.isEmpty ? true : false,
                        child: CircleIcon(
                          icon: FeatherIcons.play,
                          iconColor: word.isEmpty ?AppColors.secondaryColor :AppColors.primaryColor,
                          iconSize: 30,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TestYourMemorize(),
                            ));
                          },
                        ),
                      ),
                    ),
                    FaSlideAnimation(
                      delayed: 600,
                      child: CircleIcon(
                        icon: FeatherIcons.search,
                        iconColor: AppColors.primaryColor,
                        iconSize: 30,
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ),
            ),
            word.listenable().value == null
                ? ContainerResponsive(
                    child: Image.asset("assets/pngs/no_data.png"),
                  )
                : Expanded(
                    child: ValueListenableBuilder(
                    valueListenable: word.listenable(),
                    builder: (context, Box<Word> words, widget) {
                      print(words.length);
                      return GridView.builder(
                          itemCount: words.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.height / 3),
                          ),
                          itemBuilder: (context, index) {
                            //var words = savedWordModel.words;
                            return Stack(
                              children: <Widget>[
                                FaSlideAnimation(
                                  delayed: 200,
                                  child: Padding(
                                    padding: EdgeInsetsResponsive.symmetric(horizontal: 20,vertical: 10),
                                    child: Material(
                                      clipBehavior: Clip.antiAlias,
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.alternativeColor,
                                      child: InkWell(
                                        onTap: () {
                                          print(word.getAt(index).meaning);
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            showDeleteIcon = true;
                                          });
                                        },
                                        child: ContainerResponsive(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(boxShadow: [
                                            BoxShadow(
                                                blurRadius: 1,
                                                offset: Offset(1, 2),
                                                color: AppColors.alternativeColor.withOpacity(0.1))
                                          ], borderRadius: BorderRadius.circular(15)),
                                          child: TextResponsive(
                                            words.getAt(index).word,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: -2,
                                    top: -2,
                                    child: Visibility(
                                        visible: showDeleteIcon,
                                        child: FaSlideAnimation(
                                          isReserve: !showDeleteIcon,
                                          delayed: 50,
                                          child: Material(
                                            clipBehavior: Clip.antiAlias,
                                            type: MaterialType.circle,
                                            color: Colors.transparent,
                                            child: IconButton(
                                                icon: Icon(
                                                  FeatherIcons.minusCircle,
                                                  color: AppColors.primaryColor,
                                                ),
                                                onPressed: () {
                                                  print("item index $index");
                                                  setState(() {
                                                    hideObject = true;
                                                  });
                                                  savedWordModel.removeWord(index);
                                                }),
                                          ),
                                        )))
                              ],
                            );
                          });
                    },
                  ))
          ],
        ),
      ),
    );
  }
}
